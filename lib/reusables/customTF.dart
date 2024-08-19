import 'package:flutter/material.dart';

class Customtf extends StatelessWidget {
  final text;
  final TextEditingController controller;
  final String hinttext;
  final TextInputType keyboardType;
  final bool obsecuretext;
  const Customtf(
      {super.key,
      this.text,
      required this.controller,
      required this.hinttext,
      required this.keyboardType,
      required this.obsecuretext});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obsecuretext,
      keyboardType: keyboardType,
      controller: controller,
      decoration: InputDecoration(
        label: text,
        hintText: hinttext,
        hintStyle: const TextStyle(
          color: Colors.black,
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey[400]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey[200]!),
        ),
        fillColor: Colors.grey[600],
        filled: true,
      ),
    );
  }
}
