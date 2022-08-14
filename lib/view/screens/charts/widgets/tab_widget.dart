import 'package:flutter/material.dart';
import 'package:my_wallet/view/core/colors.dart';

class TabWidget extends StatelessWidget {
  const TabWidget({
    Key? key,
    required this.text,
  }) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: kIndigoAccentColor, width: 1.5)),
        child: Align(
          alignment: Alignment.center,
          child:
              Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}
