import 'package:flutter/material.dart';

class Utils {
  static showSnackBar(BuildContext context, String msg, Color bgColor) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      backgroundColor: bgColor,
    ));
  }
}
