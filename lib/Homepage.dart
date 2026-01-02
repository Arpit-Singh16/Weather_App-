import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/Setting.dart';
import 'package:weather_app/weatherhome.dart';
import 'Add_location.dart';


class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final PageController controller = PageController();
  List<String> cities = [];
  List<Map<String,dynamic>> weather=[];
  Map<String,dynamic> description={};
  dynamic temp;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchLocation();
  }


  void Sendmessage(){
    SmsSender sender = SmsSender();
    String message = "⚠️ Health Alert!\n"
        "Location: $location\n"
        "Possible outbreak: $disease\n"
        "Precaution: Boil water, use ORS, visit nearest hospital.";
  }

  Future<void> refresh() async {
setState(() {
  isLoading=true;
  CircularProgressIndicator(color: Colors.blue,);
});
fetchLocation();

setState(() {
  isLoading=false;
});
  }

  Future<void> Fetchweather(List<String> cities)async {
    for(String city in cities){
    final API_key = '1869896c7323f9fa46066467d0933148';
    final url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/forecast?q=$city&appid=$API_key&units=metric');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data= jsonDecode(response.body);
        setState(() {
          weather.add(data);
        });

      }
      else {
        print('Failed to load weather data');
      }
    }
    catch (e) {
      print('Failed to load weather data');
    }
    }
  }



  Future<void> fetchLocation() async {
    var user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('location')
          .where('uid', isEqualTo: user.uid)
          .get();

      List<String> cityList = [];

      for (var doc in snapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        // In your DB, 'name' might be a String or a List
        if (data['name'] is String) {
          cityList.add(data['name']);
        }
        else if (data['name'] is List) {
         cityList.addAll(List<String>.from(data['name']));
       }
      }

      setState(() {
        cities = cityList;
        weather.clear();
      });
      await Fetchweather(cities);

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching cities: $e");
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.grey,
      //   foregroundColor: Colors.black,
      //   actions: [
      //     IconButton(onPressed: refresh, icon: Icon(Icons.refresh)),
      //     IconButton(
      //       onPressed: () {
      //         Navigator.push(context,
      //             MaterialPageRoute(builder: (context) => AddLocation()));
      //       },
      //       icon: Icon(Icons.add_location_alt_sharp),
      //     ),
      //     IconButton(
      //       onPressed: () {
      //         Navigator.push(context,
      //             MaterialPageRoute(builder: (context) => Setting()));
      //       },
      //       icon: Icon(Icons.settings),
      //     ),
      //   ],
      // ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : cities.isEmpty
          ? Center(child: Text("No cities found"))
          : PageView.builder(
        controller: controller,
        itemCount: cities.length,
        itemBuilder: (context, index) {
          if (index >= weather.length){
            return Center(child: CircularProgressIndicator());
          }
          return Weatherhome(
            city: cities[index],
            controller: controller,
            length: cities.length,
            description: weather[index]['list'][0]['weather'][0]['description'],
            temperature: weather[index]['list'][0]['main']['temp'],
            function:refresh,
          );
        },
      ),
    );
  }
}
