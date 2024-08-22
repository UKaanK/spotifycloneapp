import 'package:flutter/material.dart';

class BasicAppButton extends StatelessWidget {
  const BasicAppButton(
      {super.key, required this.onPressed, required this.title, this.height});
  final VoidCallback onPressed;
  final double? height;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style:
          ElevatedButton.styleFrom(minimumSize: Size.fromHeight(height ?? 80)),
      child: Text(
        title,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
