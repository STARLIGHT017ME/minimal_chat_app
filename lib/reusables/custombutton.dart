import 'package:flutter/material.dart';

class Custombutton extends StatelessWidget {
  final String text;
  final void Function() onTap;
  const Custombutton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(color: Colors.grey[200]),
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.symmetric(horizontal: 1),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
