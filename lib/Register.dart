import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/Homepage.dart';
import 'Custom/customtextfield.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  var namecontroller = TextEditingController();
  var emailcontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
  var confirmpasswordcontroller = TextEditingController();

  Future<void> savedata() async{

    var email=emailcontroller.text.trim();
    var password=passwordcontroller.text.trim();
    var name=namecontroller.text.trim();
    var user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    var uid=user.user!.uid;
    var usercredential = await FirebaseFirestore.instance
        .collection('user')
        .doc(uid)
        .set({'Name': name, 'Email': email });

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Homepage()),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("Register")),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              customfield(
                labelText: 'Name',
                prefixIcon: Icons.person,
                controller: namecontroller,
              ),
              customfield(
                labelText: 'Email',
                prefixIcon: Icons.email,
                controller: emailcontroller,
              ),
              customfield(
                labelText: 'Password',
                prefixIcon: Icons.password,
                controller: passwordcontroller,
              ),
              customfield(
                labelText: 'Confirm Password',
                prefixIcon: Icons.password,
                controller: confirmpasswordcontroller,
              ),

              ElevatedButton(
                onPressed: () {
                  var name = namecontroller.text.trim();
                  var email = emailcontroller.text.trim();
                  var password = passwordcontroller.text.trim();
                  var confirm = confirmpasswordcontroller.text.trim();
                  if (name.isEmpty ||
                        email.isEmpty ||
                        password.isEmpty ||
                        confirm.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("All fields are required")),
                      );
                    }
                    else if(!RegExp(
                      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                    ).hasMatch(email)){
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Wrong email")),
                      );
                    }else if (password.length <6) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Password must be 6 characters"),
                        ),
                      );
                    } else if (password != confirm) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Password does not match")),
                      );
                    } else if (RegExp(
                      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                    ).hasMatch(email)) {
                      if (password.length >= 6 && password == confirm) {
                        try {
                          savedata();
                      }catch (e) {
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text("Error Occured")));
                        }
                    }
                  }else{
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Invalid email or password")),
                      );
                  }
                },
                child: Text("Register"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
