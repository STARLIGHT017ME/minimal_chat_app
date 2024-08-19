import 'package:flutter/material.dart';

class CustomUserTile extends StatelessWidget {
  final text;
  final void Function()? onTap;
  const CustomUserTile({super.key, this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[600],
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
        padding: const EdgeInsets.all(25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //icon
            const Icon(Icons.person),
            //user name
            Text(text)
          ],
        ),
      ),
    );
  }
}
