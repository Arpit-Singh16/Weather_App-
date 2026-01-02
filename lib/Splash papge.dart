import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/Homepage.dart';
import 'Login page.dart';

class Splashpage extends StatefulWidget {
  const Splashpage({super.key});

  @override
  State<Splashpage> createState() => _SplashpageState();
}

class _SplashpageState extends State<Splashpage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var user=FirebaseAuth.instance.currentUser;

    Timer(Duration(seconds: 3), () {
      if(user!=null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Homepage()),
        );
      }else{
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Loginpage()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.clipartmax.com%2Fmiddle%2Fm2H7Z5K9H7d3N4m2_cloudy-clipart-sun-behind-cloud-sun-and-clouds-emoji%2F&psig=AOvVaw0oqHkK4qIP2SqqnxsaygWk&ust=1753276823760000&source=images&cd=vfe&opi=89978449&ved=0CBUQjRxqFwoTCIi2k7_H0I4DFQAAAAAdAAAAABAE",
              ),
              radius: 30,
            ),
            Text("Weather Report"),
            CircularProgressIndicator(color: Colors.blue),

          ],
        ),
      ),
    );
  }
}
