import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'Custom/customtextfield.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var namecontroller = TextEditingController();
  var emailcontroller =TextEditingController();
  var phonecontroller = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchdata();
  }

  Future<void> fetchdata() async {
    setState(() => isLoading = true);
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        DocumentSnapshot snapshot = await FirebaseFirestore.instance
            .collection('user') // Ensure this matches your Firebase collection name
            .doc(user.uid)
            .get();

        if (snapshot.exists) {
          Map<String, dynamic> pro = snapshot.data() as Map<String, dynamic>;

          namecontroller.text = pro.containsKey('Name') ? pro['Name'] : '';
          emailcontroller.text = pro.containsKey('Email') ? pro['Email'] : '';
          phonecontroller.text = pro.containsKey('Phone') ? pro['Phone'] : '';

          print("Name: ${pro['Name']}");
          print("Email: ${pro['Email']}");
          print("Phone: ${pro['Phone']}");
        } else {
          namecontroller.clear();
          emailcontroller.clear();
          phonecontroller.clear();
        }
        setState(() {});
      } catch (e) {
        print("Error fetching profile: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error occurred: $e")),
        );
      }
    }
    setState(() => isLoading = false);
  }

  Future<void> update() async {
    if (namecontroller.text.isEmpty || emailcontroller.text.isEmpty || phonecontroller.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("All fields must be filled")),
      );
      return;
    }

    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance.collection('user').doc(user.uid).update({
        'Name': namecontroller.text.trim(),
        'Email': emailcontroller.text.trim(),
        'Phone': phonecontroller.text.trim(),
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("User not found")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Profile"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          child: Column(
            children: [
              customfield(
                labelText: 'Name',
                prefixIcon: Icons.person,
                controller: namecontroller,
              ),
              SizedBox(height: 20,),
              customfield(
                labelText: 'Email',
                readonly: true,
                prefixIcon: Icons.mail,
                controller: emailcontroller,
              ),
              SizedBox(height: 20,),
              customfield(
                labelText: 'Ph.Number',
                prefixIcon: Icons.call,
                controller: phonecontroller,
                type: TextInputType.number,
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: update,
                  child: Text("Save changes"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
