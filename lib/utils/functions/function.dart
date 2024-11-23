import 'package:flutter/material.dart';

class UtilFunctions {
  // show shanckbar
  void showSnackBarWdget(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
