import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddLocation extends StatefulWidget {
  const AddLocation({super.key});

  @override
  State<AddLocation> createState() => _AddLocationState();
}

class _AddLocationState extends State<AddLocation> {
  var searchcontroller = TextEditingController();
  Map maprecord = {};
  List<dynamic> Original = [];
  List<String> city=[];
  List<dynamic> filtered = [];
  List<Map<String,dynamic>> cities=[];
  bool is_loading = false;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();

    is_loading = true;
    fetchlist();

  }

  // var user = FirebaseAuth.instance.currentUser;
  // Future<void> fetchLocation() async {
  //   var user = FirebaseAuth.instance.currentUser;
  //   if (user == null) return;
  //
  //   try {
  //     QuerySnapshot snapshot = await FirebaseFirestore.instance
  //         .collection('location')
  //         .where('uid', isEqualTo: user.uid)
  //         .get();
  //
  //     List<Map<String,dynamic>> cityList = [];
  //
  //     for (var doc in snapshot.docs) {
  //       Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
  //
  //       cityList.add(data);
  //     }
  //
  //
  //       // In your DB, 'name' might be a String or a List
  //       // if (data['name'] is String) {
  //       //   cityList.add(data['name']);
  //       // }
  //       //else if (data['name'] is List) {
  //       // cityList.addAll(List<String>.from(data['name']));
  //       //  }
  //
  //     setState(() {
  //       cities = cityList;
  //     });
  //   } catch (e) {
  //     print("Error fetching cities: $e");
  //   }
  // }

  void _onSearch(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    // Wait 500ms after user stops typing
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (query.isNotEmpty) {
        fetchData(query); // Call API with typed query
      } else {
        setState(() {
          filtered = Original; // Clear list if input empty
        });
      }
    });
  }

  Future<void> fetchlist() async {
    var user=FirebaseAuth.instance.currentUser;
    if(user==null){
      return null;
    }
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('location')
          .where('uid', isEqualTo: user.uid)
          .get();

      for(var doc in snapshot.docs){
        Map<String,dynamic> data = doc.data() as Map<String,dynamic>;

        var name=data['Name'];
        city.add(name);
        fetchData();
      }
    }
    catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("No city addded")));
    }
  }

  void fetchData([String? query]) async {
    final uri = Uri.https('api.openweathermap.org','/geo/1.0/direct', {
      'q': query,
      'limit': '20',
      'appid': '1869896c7323f9fa46066467d0933148',
    });
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      setState(() {
        Original = jsonDecode(response.body);
        filtered = Original;
      });
    } else {
      setState(() {
         Original =city;
      });
    }
    setState(() {
      is_loading = false;
    });
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(centerTitle: true, title: Text("Select Location")),
        body: Column(
          children: [
            TextField(
              controller: searchcontroller,
              onChanged: _onSearch,
              decoration: InputDecoration(
                labelText: "Search",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
            if (is_loading)
              const CircularProgressIndicator()
            else if (Original.isEmpty && searchcontroller.text.isNotEmpty)
              const Text("No locations found."),

            if (Original.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: Original.length,
                  itemBuilder: (context, index) {
                    final city = Original[index];
                    final name = city['name'];
                    final country = city['country'];
                    return Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        leading: Text(name),
                        subtitle: Text(country),
                        trailing: IconButton(
                          onPressed: () async {
                            try {
                              var user=FirebaseAuth.instance.currentUser;
                              await FirebaseFirestore.instance
                                  .collection('location')
                                  .add(
                                    {
                                      'uid': user!.uid,
                                      'name': name,
                                      'country': country,
                                        }
                                  );

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Location Added")),
                              );
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Failed to add location"),
                                ),
                              );
                            }
                          },
                          icon: Icon(Icons.add),
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
