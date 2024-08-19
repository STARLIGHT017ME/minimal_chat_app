import 'package:flutter/material.dart';

class Chatbubble extends StatelessWidget {
  final String message;
  final bool iscurrentuser;
  const Chatbubble(
      {super.key, required this.message, required this.iscurrentuser});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: iscurrentuser ? Colors.green : Colors.grey.shade500),
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 25),
      child: Text(
        message,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
