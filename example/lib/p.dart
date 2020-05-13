library polls;
import 'package:example/optionview.dart';
import 'package:example/pollwidget.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class Polls extends StatefulWidget {

  Key key;

  int totalVotes;

  DateTime voteEnds;
  Map pollData;
  int type;
  List children;


  Polls({
    @required this.children,
    this.pollData,
    this.type,
    this.voteEnds,
    this.totalVotes,
  })  :assert( children != null), assert( pollData != null), assert( type != null), assert( voteEnds != null), assert( totalVotes != null);


  @override
  _PollsState createState() => _PollsState(children: children, type: type, totalVotes: totalVotes, voteEnds: voteEnds, pollData: pollData);
}

class _PollsState extends State<Polls> {

  String choice1Title = '';

  String choice2Title = '';

  String choice3Title = '';

  String choice4Title = '';

  double choice1Value = 0.0;

  double choice2Value = 0.0;

  double choice3Value = 0.0;

  double choice4Value = 0.0;

  double highest = 0;

  Color voteCastedColor = Colors.green;

  Color voteNotCastedColor = Colors.green;

  int option;
  double value;
  String title;

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

  Key key;

  int totalVotes;

  DateTime voteEnds;
  Map pollData;
  int type;
  List children;

  _PollsState({
    @required this.children,
    this.pollData,
    this.type,
    this.voteEnds,
    this.totalVotes,
    this.key
  })  : assert( children != null), assert( pollData != null), assert( type != null), assert( voteEnds != null), assert( totalVotes != null) {

    print(children);

    this.choice1Value = children[0][1];
    this.choice1Title = children[0][0];

    this.choice2Value = children[1][1];
    this.choice2Title = children[1][0];

    if(children.length > 2) {
      this.choice3Value = children[2][1];
      this.choice3Title = children[2][0];
    }

    if(children.length > 3) {
      this.choice4Value = children[3][1];
      this.choice4Title = children[3][0];
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }



  @override
  Widget build(BuildContext context) {

    PollWidget pollWidget = new PollWidget.instance(
      c1: choice1Title,
      c2: choice2Title,
      c3: choice3Title,
      c4: choice4Title,
      v1: choice1Value,
      v2: choice2Value,
      v3: choice3Value,
      v4: choice4Value,
      total: totalVotes,
      highest: highest,
    );

    if(type == 2){
      //vote has been casted by this user
      return pollWidget.voteCasted(context);

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
                    Text(this.choice1Title,
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
