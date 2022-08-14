import 'package:flutter/material.dart';

class CoreFunctions {
  static pushToNext(context, page) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => page));
  }

  static pushAndRemoveUntilNext(context, page) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => page), (route) => false);
  }

  static pushReplacePage(context, page) {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => page));
  }
}
