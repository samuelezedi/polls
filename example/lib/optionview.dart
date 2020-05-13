
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PollOptions {
  double value;
  String title;

  show() {
    return [this.title, this.value];
  }

  PollOptions(
      {@required this.title, @required this.value})
      : assert(title != null),
        assert(value != null);

}
