import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'About us.dart';
import 'Custom/Customlist.dart';
import 'Customcare.dart';
import 'Login page.dart';
import 'Profile.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back_ios)),
          title: Text("Setting",style: TextStyle(fontSize: 30,),),
        ),
        body: ListView(
          children:[
            InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Profile()));
                },
                child: Customlist(text: "Profile")),

            InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>CustomerCarePage()));
                },
                child: Customlist(text: "Custome care")),

            InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>AboutUsPage()));
                },
                child: Customlist(text: "About us")),

            InkWell(
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Loginpage()));
                },
                child: Customlist(text: "Log out")),
        ],
        ),
      ),
    );
  }
}
