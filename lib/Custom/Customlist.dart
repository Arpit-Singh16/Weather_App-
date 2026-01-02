import 'package:flutter/material.dart';

class Customlist extends StatefulWidget {
  final text;
  const Customlist({super.key, required this.text});

  @override
  State<Customlist> createState() => _CustomlistState();
}

class _CustomlistState extends State<Customlist> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical:10.0,horizontal: 10),
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            // border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [BoxShadow(
              color: Colors.grey,
              blurRadius: 5,
              offset: Offset(0,5),

            ),],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: ListTile(
              leading: Text(widget.text,style: TextStyle(fontSize: 20,color: Colors.deepPurpleAccent),),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
          ),
        ),
      ),
    );
  }
}
