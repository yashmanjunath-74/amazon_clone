import 'package:amazon_clone/constants/global_variables.dart';
import 'package:flutter/material.dart';

class CustomButtton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color? color;
  final double? Fontsize;

  const CustomButtton(
      {super.key,
      required this.text,
      required this.onTap,
      this.color,
      this.Fontsize});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: color == null ? GlobalVariables.secondaryColor : color,
        minimumSize: const Size(double.infinity, 50),
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
        textStyle: TextStyle(
          fontSize: Fontsize == null ? 20 : Fontsize,
          fontWeight: FontWeight.bold,
        ),
      ),
      child: Text(
        text,
        style: TextStyle(color: color == null ? Colors.white : Colors.black),
      ),
    );
  }
}
