
import 'package:example/calc.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class PollWidget {

  String c1;
  String c2;
  String c3;
  String c4;
  double v1;
  double v2;
  double v3;
  double v4;
  int total;
  double highest;

  //colors
  Color notVotedOutlineColor;
  Color notVotedBackgroundColor;
  Color notVotedTextColor;

  Color votedOutlineColor;
  Color votedBackgroundColor;
  Color votedTextColor;


  Color userChoiceTextColor;
  Color userChoiceOutlineColor;
  Color userChoiceBackgroundColor;
  Color userChoiceIconColor;

  PollWidget.instance({c1, c2, c3, c4, v1, v2, v3, v4,total, highest}) {
    this.c1 = c1;
    this.c2 = c2;
    this.c3 = c3;
    this.c4 = c4;
    this.v1 = v1;
    this.v2 = v2;
    this.v3 = v3;
    this.v4 = v4;
    this.highest = highest;
    this.total = total;
    this.notVotedOutlineColor = Colors.blue;
    this.notVotedTextColor = Colors.blue;
    this.notVotedBackgroundColor = Colors.white;
    this.votedBackgroundColor = Colors.blueGrey;
    this.votedOutlineColor = Colors.transparent;
    this.votedTextColor = Colors.white;
    this.userChoiceTextColor = Colors.white;
    this.userChoiceOutlineColor = Colors.transparent;
    this.userChoiceBackgroundColor = Colors.blue;
    this.userChoiceIconColor = Colors.black54;
  }

  voteCasted(context) {
    return Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          child: Container(
            margin: EdgeInsets.all(0),
            width: MediaQuery.of(context).size.width,
            child: OutlineButton(
              onPressed: () {
                //cast vote
//              _calculateVoteAndPost(data, 1, 'one');
              },
              color: Colors.green,
              padding: EdgeInsets.all(5.0),
              child: Text(this.c1,
                  style: TextStyle(fontSize: 18.0)),
              borderSide: BorderSide(
                color: Colors.black,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(20.0),
//                              side: BorderSide(color: Colors.red)
              ),
            ),
          ),
        ),

        Container(
          width: double.infinity,
          child: Container(
            margin: EdgeInsets.all(0),
            width: MediaQuery.of(context).size.width,
            child: OutlineButton(
              onPressed: () {
                //cast vote
//              _calculateVoteAndPost(data, 1, 'one');
              },
              color: Colors.green,
              padding: EdgeInsets.all(5.0),
              child: Text(this.c2,
                  style: TextStyle(fontSize: 18.0)),
              borderSide: BorderSide(
                color: Colors.black,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(20.0),
//                              side: BorderSide(color: Colors.red)
              ),
            ),
          ),
        ),

        Container(
          width: double.infinity,
          child: Container(
            margin: EdgeInsets.all(0),
            width: MediaQuery.of(context).size.width,
            child: OutlineButton(
              onPressed: () {
                //cast vote
//              _calculateVoteAndPost(data, 1, 'one');
              },
              color: Colors.green,
              padding: EdgeInsets.all(5.0),
              child: Text(this.c3,
                  style: TextStyle(fontSize: 18.0)),
              borderSide: BorderSide(
                color: Colors.black,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(20.0),
//                              side: BorderSide(color: Colors.red)
              ),
            ),
          ),
        ),

        Container(
          width: double.infinity,
          child: Container(
            margin: EdgeInsets.all(0),
            width: MediaQuery.of(context).size.width,
            child: OutlineButton(
              onPressed: () {
                //cast vote
//              _calculateVoteAndPost(data, 1, 'one');
              },
              color: Colors.green,
              padding: EdgeInsets.all(5.0),
              child: Text(this.c4,
                  style: TextStyle(fontSize: 18.0)),
              borderSide: BorderSide(
                color: Colors.black,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(20.0),
//                              side: BorderSide(color: Colors.red)
              ),
            ),
          ),
        ),
      ],
    );
  }

  pollCreator(context) {
    var sortedKeys = [v1,v2,v3,v4];
    double current = 0;
    for (var i = 0; i < sortedKeys.length; i++) {
      double s = double.parse(sortedKeys[i].toString());
      if (sortedKeys[i] >= current) {
        current = s;
      }
    }
    highest = current;
    return Column(
      children: <Widget>[
    Container(
    margin: EdgeInsets.fromLTRB(3, 3, 10, 3),
    width: double.infinity,
    child: LinearPercentIndicator(
//              width: MediaQuery.of(context).size.width,

    animation: true,
    lineHeight: 38.0,
    animationDuration: 500,
    percent: PollMath().getPerc(v1,v2,v3,v4
    , 1)[0],
    center: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
    Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
    Text(c1,
    style: TextStyle(
    fontSize: 16,
    color: votedTextColor,
    fontWeight: highest == v1
    ? FontWeight.w900
        : FontWeight.w100,
    )),
    SizedBox(
    width: 10,
    ),
    ],
    ),
    Text(PollMath().getMainPerc(v1,v2,v3,v4, 1).toString() + "%",
    style: TextStyle(
    fontSize: 16,
    color: votedTextColor,
    fontWeight: highest == v1
    ? FontWeight.w900
        : FontWeight.w100,
    ))
    ],
    ),
    linearStrokeCap: LinearStrokeCap.roundAll,
    progressColor: highest == v1
    ? votedBackgroundColor
        : votedBackgroundColor.withOpacity(0.7)),
    ),
      ],
    );
  }

}