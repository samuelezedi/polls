

import 'package:example/p.dart';
import 'package:example/pollcontroller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'globals.dart';

class Options extends StatelessWidget with PollsController {

  int option;
  double value;
  String title;
  int type;

  Options({
    @required this.type,
    @required this.option,
    @required this.title,
    @required this.value
}) : assert(type != null),
    assert(option != null),
    assert(title != null),
    assert(value != null) {
    if(option == 1){
      choice1Title = this.title;
      choice1Value = this.value;
    }

    if(option == 2){
      choice2Title = this.title;
      choice2Value = this.value;
    }

    if(option == 3){
      choice3Title = this.title;
      choice3Value = this.value;
    }

    if(option == 4){
      choice4Title = this.title;
      choice4Value = this.value;
    }
  }

  _getMainPerc(polls, slot) {
    var div;
    var slot1res = choice1Value;
    var slot2res = choice3Value;
    var slot3res = choice3Value;
    var slot4res = choice3Value;
    if (slot == 1) {
      var sum = slot1res + slot2res + slot3res + slot4res;
      div = div = sum == 0 ? 0 : (100 / sum) * slot1res;
    }
    if (slot == 2) {
      var sum = slot1res + slot2res + slot3res + slot4res;
      div = div = sum == 0 ? 0 : (100 / sum) * slot2res;
    }
    if (slot == 3) {
      var sum = slot1res + slot2res + slot3res + slot4res;
      div = div = sum == 0 ? 0 : (100 / sum) * slot3res;
    }
    if (slot == 4) {
      var sum = slot1res + slot2res + slot3res + slot4res;
      div = div = sum == 0 ? 0 : (100 / sum) * slot4res;
    }
    return div == 0 ? 0 : div.round();
  }

  List _getPerc(polls, slot) {
    var div;
    var slot1res = choice4Value;
    var slot2res = choice4Value;
    var slot3res = choice4Value;
    var slot4res = choice4Value;
    if (slot == 1) {
      var sum = slot1res + slot2res + slot3res + slot4res;
      div = sum == 0 ? 0 : (1 / sum) * slot1res;
    }
    if (slot == 2) {
      var sum = slot1res + slot2res + slot3res + slot4res;
      div = sum == 0 ? 0 : (1 / sum) * slot2res;
    }
    if (slot == 3) {
      var sum = slot1res + slot2res + slot3res + slot4res;
      div = sum == 0 ? 0 : (1 / sum) * slot3res;
    }
    if (slot == 4) {
      var sum = slot1res + slot2res + slot3res + slot4res;
      div = sum == 0 ? 0 : (1 / sum) * slot4res;
    }
    return [div == 0 ? 0.0 : div.toDouble(), div];
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if(type == 2){
      //vote has been casted by this user
      return Container(
        width: double.infinity,
        child: Container(
          margin: EdgeInsets.all(0),
          width: MediaQuery.of(context).size.width,
          child: OutlineButton(
            onPressed: () {
              //cast vote
//              _calculateVoteAndPost(data, 1, 'one');
            },
            color: voteNotCastedColor,
            padding: EdgeInsets.all(5.0),
            child: Text(this.title,
                style: TextStyle(fontSize: 18.0)),
            borderSide: BorderSide(
              color: voteNotCastedColor,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(20.0),
//                              side: BorderSide(color: Colors.red)
            ),
          ),
        ),
      );
    }
    if(type == 1){
      //mean this is the creator of the polls and cannot vote
      return Container(
        margin: EdgeInsets.fromLTRB(3, 3, 10, 3),
        width: double.infinity,
        child: LinearPercentIndicator(
//              width: MediaQuery.of(context).size.width,

            animation: true,
            lineHeight: 38.0,
            animationDuration: 500,
            percent: _getPerc(this.value
                , 1)[0],
            center: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(this.title,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: highest == this.value
                              ? FontWeight.w900
                              : FontWeight.w100,
                        )),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                Text(_getMainPerc(this.value, 1).toString() + "%",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: highest == this.value
                          ? FontWeight.w900
                          : FontWeight.w100,
                    ))
              ],
            ),
            linearStrokeCap: LinearStrokeCap.roundAll,
            progressColor: highest == this.value
                ? voteCastedColor
                : voteCastedColor.withOpacity(0.7)),
      );
    }
  }
}