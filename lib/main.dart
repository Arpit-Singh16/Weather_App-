import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'Splash papge.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

   // if (kIsWeb) {
   //   await Firebase.initializeApp(
   //     options: const FirebaseOptions(
   //       apiKey: "AIzaSyB8scfkswR4oPamvBvhlugShdiDNS-lxaE",
   //       authDomain: "weather-app-b4e02.firebase.com",
   //       projectId: "weather-app-b4e02",
   //       storageBucket: "weather-app-b4e02.GeoFirestore.app",
   //       messagingSenderId: "610598284523",
   //       appId: "1:610598284523:android:528933835dc59b587a22ae",
   //        // optional
   //     ),
   //   );
   // } else {
    await Firebase.initializeApp();
  //}
  runApp(Demo());
}


class Demo extends StatefulWidget {
  const Demo({super.key});

  @override
  State<Demo> createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splashpage(),
    );
  }
}

