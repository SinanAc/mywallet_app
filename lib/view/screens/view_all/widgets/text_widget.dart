import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  const TitleText({
    Key? key,
    required this.text,
    required this.color,
    required this.fontSize,
  }) : super(key: key);
  final String text;
  final Color color;
  final double fontSize;
  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: fontSize,
        ));
  }
}
