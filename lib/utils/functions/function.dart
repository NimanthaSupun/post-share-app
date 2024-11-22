import 'package:flutter/material.dart';

class UtilFunctions {

  // show shanckbar
  void showSnackBar(BuildContext context, String message){
     ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
  }
}
