
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// This call return an array of options to Polls
class PollOptions {

  double value;
  String title;

  PollOptions(
      {@required this.title, @required this.value})
      : assert(title != null),
        assert(value != null);

  show() {
    return [this.title, this.value];
  }

}
