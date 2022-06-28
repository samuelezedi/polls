import 'package:flutter/material.dart';

/// simple logic to detect users choice and return a check icon
Widget myOwnChoice(choice, index, Widget icon) {

  if (choice!=null) {
    if(choice==index) {
      return icon;
    }
  }
  return Container();

}