import 'package:flutter/material.dart';

class customfield extends StatefulWidget {
  final String labelText;
  final IconData prefixIcon;
  final TextInputType? type;
  final bool? readonly;
  final TextEditingController? controller;
  const customfield({super.key, required this.labelText, required this.prefixIcon, required this.controller, this.type, this.readonly});

  @override
  State<customfield> createState() => _customfieldState();
}

class _customfieldState extends State<customfield> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
            ),
      child: TextField(
        controller: widget.controller,
        readOnly: widget.readonly?? false,
        decoration: InputDecoration(
          labelText: widget.labelText,
          prefixIcon: Icon(widget.prefixIcon),
          border: OutlineInputBorder(),
        ),
        keyboardType: widget.type,
      ),
    );
  }
}
