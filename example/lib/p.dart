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
    );

    if(type == 2){
      //vote has been casted by this user
      return pollWidget.voteCasted(context);

    }
    if(type == 1){
      //mean this is the creator of the polls and cannot vote
      return pollWidget.pollCreator(context);

    }
  }
}
