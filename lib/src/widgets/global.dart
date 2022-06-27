import 'package:flutter/material.dart';

/// simple logic to detect users choice and return a check icon
Widget myOwnChoice(choice, index) {

  if (choice!=null) {
    return Icon(
      Icons.check_circle_outline,
      color: Colors.white,
      size: 17,
    );
  } else {
    return Container();
  }
}