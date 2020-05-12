library polls;

import 'package:flutter/material.dart';

class Polls {

  Key key;

  Map _choiceOne = {'name' : '', 'value' : 0};

  Map _choiceTwo = {'name' : '', 'value' : 0};

  Map _choiceThree = {'name' : '', 'value' : 0};

  Map _choiceFour = {'name' : '', 'value' : 0};


  choiceOne (String title, double value) {
    this._choiceOne['name'] = title;
    this._choiceOne['value'] = value;
  }

  choiceTwo (String title, double value) {
    this._choiceTwo['name'] = title;
    this._choiceTwo['value'] = value;
  }

  choiceThree (String title, double value) {
    this._choiceThree['name'] = title;
    this._choiceThree['value'] = value;
  }

  choiceFour (String title, double value) {
    this._choiceFour['name'] = title;
    this._choiceFour['value'] = value;
  }


}