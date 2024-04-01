import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Color gradientColorStart;
  final Color gradientColorEnd;
  final String text;
  final Color? textColor;
  final void Function()? onTap;
  const CustomButton({
    super.key,
    required this.text,
    this.textColor,
    this.onTap,
    required this.gradientColorStart,
    required this.gradientColorEnd,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Container(
          decoration: BoxDecoration(
            gradient:
                LinearGradient(colors: [gradientColorStart, gradientColorEnd]),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
                child: Text(
              text,
              style: TextStyle(fontSize: 12, color: textColor),
            )),
          ),
        ),
      ),
    );
  }
}
