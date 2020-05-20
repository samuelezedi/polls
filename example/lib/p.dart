library polls;

import 'package:example/calc.dart';
import 'package:example/globals.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

typedef void PollCallBack(int choice);

class Polls extends StatefulWidget {

  final String question;

  final DateTime voteEnds;

  final int type;

  final List children;

  final PollCallBack onVote;

  final int userChoice;

  final bool allowCreatorVote;

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

  Color votedOutlineColor = Colors.blueGrey;
  Color votedBackgroundColor = Colors.blueGrey;
  Color votedTextColor = Colors.black;

  Color userChoiceTextColor = Colors.blue;
  Color userChoiceOutlineColor = Colors.blue;
  Color userChoiceBackgroundColor = Colors.blueGrey;
  Color userChoiceIconColor = Colors.black;

  bool userChoiceCheck;

  String choice1Title = '';

  String choice2Title = '';

  String choice3Title = '';

  String choice4Title = '';

  double choice1Value = 0.0;

  double choice2Value = 0.0;

  double choice3Value = 0.0;

  double choice4Value = 0.0;

  Polls({
    @required this.children,
    @required this.question,
    this.voteEnds,
    this.userChoice = 2,
    this.allowCreatorVote = false,
    this.onVote,
    this.type = 2,
  })  : assert(onVote != null),
        assert(question != null),
        assert(children != null),
        assert(voteEnds != null) {
    this.choice1Value = this.children[0][1];
    this.choice1Title = this.children[0][0];
    this.v1 = this.children[0][1];
    this.c1 = this.children[0][0];

    this.choice2Value = this.children[1][1];
    this.choice2Title = this.children[1][0];
    this.v2 = this.children[1][1];
    this.c2 = this.children[1][0];

    if (this.children.length > 2) {
      this.choice3Value = this.children[2][1];
      this.choice3Title = this.children[2][0];
      this.v3 = this.children[2][1];
      this.c3 = this.children[2][0];
    }

    if (this.children.length > 3) {
      this.choice4Value = this.children[3][1];
      this.choice4Title = this.children[3][0];
      this.v4 = this.children[3][1];
      this.c4 = this.children[3][0];
    }
  }

  Polls.viewPolls({
    @required this.children,
    @required this.question,
    this.userChoice,
    this.voteEnds,
  })  : allowCreatorVote = null,
        type = 3,
        onVote = null,
        assert(children != null),
        assert(question != null) {
    this.choice1Value = this.children[0][1];
    this.choice1Title = this.children[0][0];
    this.v1 = this.children[0][1];
    this.c1 = this.children[0][0];

    this.choice2Value = this.children[1][1];
    this.choice2Title = this.children[1][0];
    this.v2 = this.children[1][1];
    this.c2 = this.children[1][0];

    if (this.children.length > 2) {
      this.choice3Value = this.children[2][1];
      this.choice3Title = this.children[2][0];
      this.v3 = this.children[2][1];
      this.c3 = this.children[2][0];
    }

    if (this.children.length > 3) {
      this.choice4Value = this.children[3][1];
      this.choice4Title = this.children[3][0];
      this.v4 = this.children[3][1];
      this.c4 = this.children[3][0];
    }
  }

  Polls.creator({
    @required this.children,
    @required this.question,
    this.voteEnds,
  })  : allowCreatorVote = false,
        type = 1,
        onVote = null,
        userChoice = null,
        assert(children != null),assert(question != null);

  Polls.castVote({
    @required this.children,
    @required this.question,
    this.voteEnds,
    this.userChoice = 2,
    this.allowCreatorVote = false,
    this.onVote,
    this.type = 2,
  })  : assert(onVote != null),
        assert(question != null),
        assert(children != null),
        assert(voteEnds != null) {
    this.choice1Value = this.children[0][1];
    this.choice1Title = this.children[0][0];
    this.v1 = this.children[0][1];
    this.c1 = this.children[0][0];

    this.choice2Value = this.children[1][1];
    this.choice2Title = this.children[1][0];
    this.v2 = this.children[1][1];
    this.c2 = this.children[1][0];

    if (this.children.length > 2) {
      this.choice3Value = this.children[2][1];
      this.choice3Title = this.children[2][0];
      this.v3 = this.children[2][1];
      this.c3 = this.children[2][0];
    }

    if (this.children.length > 3) {
      this.choice4Value = this.children[3][1];
      this.choice4Title = this.children[3][0];
      this.v4 = this.children[3][1];
      this.c4 = this.children[3][0];
    }
  }

  @override
  _PollsState createState() => _PollsState();
}

class _PollsState extends State<Polls> {
  @override
  Widget build(BuildContext context) {


    if (widget.type == 2) {
      //vote has been casted by this user
      return voterWidget(context);
    }
    if (widget.type == 1) {
      //mean this is the creator of the polls and cannot vote
      if (widget.allowCreatorVote) {
        return voterWidget(context);
      }
      return pollCreator(context);
    }

    if (widget.type == 3) {
      return voteCasted(context);
    }
    return Container();
  }

  Widget voterWidget(context) {
    return Column(
      children: <Widget>[
        Text(widget.question),
        Container(
          width: double.infinity,
          child: Container(
            margin: EdgeInsets.all(0),
            width: MediaQuery.of(context).size.width,
            child: OutlineButton(
              onPressed: () {
                setState(() {
                  userPollChoice = 1;
                });
                widget?.onVote(userPollChoice);
              },
              color: Colors.green,
              padding: EdgeInsets.all(5.0),
              child: Text(widget.c1, style: TextStyle(fontSize: 18.0)),
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
                setState(() {
                  userPollChoice = 2;
                });
                widget?.onVote(userPollChoice);
              },
              color: Colors.green,
              padding: EdgeInsets.all(5.0),
              child: Text(widget.c2, style: TextStyle(fontSize: 18.0)),
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
        widget.c3 != null
            ? Container(
                width: double.infinity,
                child: Container(
                  margin: EdgeInsets.all(0),
                  width: MediaQuery.of(context).size.width,
                  child: OutlineButton(
                    onPressed: () {
                      setState(() {
                        userPollChoice = 3;
                      });
                      widget?.onVote(userPollChoice);
                    },
                    color: Colors.green,
                    padding: EdgeInsets.all(5.0),
                    child: Text(widget.c3, style: TextStyle(fontSize: 18.0)),
                    borderSide: BorderSide(
                      color: Colors.black,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(20.0),
//                              side: BorderSide(color: Colors.red)
                    ),
                  ),
                ),
              )
            : Offstage(),
        widget.c4 != null
            ? Container(
                width: double.infinity,
                child: Container(
                  margin: EdgeInsets.all(0),
                  width: MediaQuery.of(context).size.width,
                  child: OutlineButton(
                    onPressed: () {
                      setState(() {
                        userPollChoice = 4;
                      });
                      widget?.onVote(userPollChoice);
                    },
                    color: Colors.green,
                    padding: EdgeInsets.all(5.0),
                    child: Text(widget.c4, style: TextStyle(fontSize: 18.0)),
                    borderSide: BorderSide(
                      color: Colors.black,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(20.0),
//                              side: BorderSide(color: Colors.red)
                    ),
                  ),
                ),
              )
            : Offstage(),
      ],
    );
  }

  Widget pollCreator(context) {
    var sortedKeys = [widget.v1, widget.v2, widget.v3, widget.v4];
    double current = 0;
    for (var i = 0; i < sortedKeys.length; i++) {
      if (sortedKeys[i] != null) {
        double s = double.parse(sortedKeys[i].toString());
        if (sortedKeys[i] >= current) {
          current = s;
        }
      }
    }
    widget.highest = current;
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(3, 3, 10, 3),
          width: double.infinity,
          child: LinearPercentIndicator(
              animation: true,
              lineHeight: 38.0,
              animationDuration: 500,
              percent: PollMath()
                  .getPerc(widget.v1, widget.v2, widget.v3, widget.v4, 1)[0],
              center: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(widget.c1,
                          style: TextStyle(
                            fontSize: 16,
                            color: widget.votedTextColor,
                            fontWeight: widget.highest == widget.v1
                                ? FontWeight.w900
                                : FontWeight.w100,
                          )),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                  Text(
                      PollMath()
                              .getMainPerc(
                                  widget.v1, widget.v2, widget.v3, widget.v4, 1)
                              .toString() +
                          "%",
                      style: TextStyle(
                        fontSize: 16,
                        color: widget.votedTextColor,
                        fontWeight: widget.highest == widget.v1
                            ? FontWeight.w900
                            : FontWeight.w100,
                      ))
                ],
              ),
              linearStrokeCap: LinearStrokeCap.roundAll,
              progressColor: widget.highest == widget.v1
                  ? widget.votedBackgroundColor
                  : widget.votedBackgroundColor.withOpacity(0.7)),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(3, 3, 10, 3),
          width: double.infinity,
          child: LinearPercentIndicator(
//              width: MediaQuery.of(context).size.width,

              animation: true,
              lineHeight: 38.0,
              animationDuration: 500,
              percent: PollMath()
                  .getPerc(widget.v1, widget.v2, widget.v3, widget.v4, 2)[0],
              center: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(widget.c2,
                          style: TextStyle(
                            fontSize: 16,
                            color: widget.votedTextColor,
                            fontWeight: widget.highest == widget.v2
                                ? FontWeight.w900
                                : FontWeight.w100,
                          )),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                  Text(
                      PollMath()
                              .getMainPerc(
                                  widget.v1, widget.v2, widget.v3, widget.v4, 2)
                              .toString() +
                          "%",
                      style: TextStyle(
                        fontSize: 16,
                        color: widget.votedTextColor,
                        fontWeight: widget.highest == widget.v2
                            ? FontWeight.w900
                            : FontWeight.w100,
                      ))
                ],
              ),
              linearStrokeCap: LinearStrokeCap.roundAll,
              progressColor: widget.highest == widget.v2
                  ? widget.votedBackgroundColor
                  : widget.votedBackgroundColor.withOpacity(0.7)),
        ),
        widget.c3 != null
            ? Container(
                margin: EdgeInsets.fromLTRB(3, 3, 10, 3),
                width: double.infinity,
                child: LinearPercentIndicator(
//              width: MediaQuery.of(context).size.width,

                    animation: true,
                    lineHeight: 38.0,
                    animationDuration: 500,
                    percent: PollMath().getPerc(
                        widget.v1, widget.v2, widget.v3, widget.v4, 3)[0],
                    center: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(widget.c3,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: widget.votedTextColor,
                                  fontWeight: widget.highest == widget.v3
                                      ? FontWeight.w900
                                      : FontWeight.w100,
                                )),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                        Text(
                            PollMath()
                                    .getMainPerc(widget.v1, widget.v2,
                                        widget.v3, widget.v4, 3)
                                    .toString() +
                                "%",
                            style: TextStyle(
                              fontSize: 16,
                              color: widget.votedTextColor,
                              fontWeight: widget.highest == widget.v3
                                  ? FontWeight.w900
                                  : FontWeight.w100,
                            ))
                      ],
                    ),
                    linearStrokeCap: LinearStrokeCap.roundAll,
                    progressColor: widget.highest == widget.v3
                        ? widget.votedBackgroundColor
                        : widget.votedBackgroundColor.withOpacity(0.7)),
              )
            : Offstage(),
        widget.c4 != null
            ? Container(
                margin: EdgeInsets.fromLTRB(3, 3, 10, 3),
                width: double.infinity,
                child: LinearPercentIndicator(
//              width: MediaQuery.of(context).size.width,

                    animation: true,
                    lineHeight: 38.0,
                    animationDuration: 500,
                    percent: PollMath().getPerc(
                        widget.v1, widget.v2, widget.v3, widget.v4, 4)[0],
                    center: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(widget.c4.toString(),
                                style: TextStyle(
                                  fontSize: 16,
                                  color: widget.votedTextColor,
                                  fontWeight: widget.highest == widget.v4
                                      ? FontWeight.w900
                                      : FontWeight.w100,
                                )),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                        Text(
                            PollMath()
                                    .getMainPerc(widget.v1, widget.v2,
                                        widget.v3, widget.v4, 4)
                                    .toString() +
                                "%",
                            style: TextStyle(
                              fontSize: 16,
                              color: widget.votedTextColor,
                              fontWeight: widget.highest == widget.v4
                                  ? FontWeight.w900
                                  : FontWeight.w100,
                            ))
                      ],
                    ),
                    linearStrokeCap: LinearStrokeCap.roundAll,
                    progressColor: widget.highest == widget.v4
                        ? widget.votedBackgroundColor
                        : widget.votedBackgroundColor.withOpacity(0.7)),
              )
            : Offstage(),
      ],
    );
  }

  Widget voteCasted(context) {
    var sortedKeys = [widget.v1, widget.v2, widget.v3, widget.v4];
    double current = 0;
    for (var i = 0; i < sortedKeys.length; i++) {
      if (sortedKeys[i] != null) {
        double s = double.parse(sortedKeys[i].toString());
        if (sortedKeys[i] >= current) {
          current = s;
        }
      }
    }
    widget.highest = current;
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
            percent: PollMath()
                .getPerc(widget.v1, widget.v2, widget.v3, widget.v4, 1)[0],
            center: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(widget.c1.toString(),
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: widget.highest == widget.v1
                              ? FontWeight.w900
                              : FontWeight.w100,
                        )),
                    SizedBox(
                      width: 10,
                    ),
                    myOwnChoice(widget.userChoice == 1)
                  ],
                ),
                Text(
                    PollMath()
                            .getMainPerc(
                                widget.v1, widget.v2, widget.v3, widget.v4, 1)
                            .toString() +
                        "%",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: widget.highest == widget.v1
                          ? FontWeight.w900
                          : FontWeight.w100,
                    ))
              ],
            ),
            linearStrokeCap: LinearStrokeCap.roundAll,
            progressColor: widget.highest == widget.v1
                ? widget.votedBackgroundColor
                : widget.votedBackgroundColor.withOpacity(0.7),
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(3, 3, 10, 3),
          width: double.infinity,
          child: LinearPercentIndicator(
//              width: MediaQuery.of(context).size.width,
            animation: true,
            lineHeight: 38.0,
            animationDuration: 500,
            percent: PollMath()
                .getPerc(widget.v1, widget.v2, widget.v3, widget.v4, 2)[0],
            center: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(widget.c2.toString(),
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: widget.highest == widget.v2
                              ? FontWeight.w900
                              : FontWeight.w100,
                        )),
                    SizedBox(
                      width: 10,
                    ),
                    myOwnChoice(widget.userChoice == 2)
                  ],
                ),
                Text(
                    PollMath()
                            .getMainPerc(
                                widget.v1, widget.v2, widget.v3, widget.v4, 2)
                            .toString() +
                        "%",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: widget.highest == widget.v2
                          ? FontWeight.w900
                          : FontWeight.w100,
                    ))
              ],
            ),
            linearStrokeCap: LinearStrokeCap.roundAll,
            progressColor: widget.highest == widget.v2
                ? widget.votedBackgroundColor
                : widget.votedBackgroundColor.withOpacity(0.7),
          ),
        ),
        widget.c3 == null
            ? Offstage()
            : Container(
                margin: EdgeInsets.fromLTRB(3, 3, 10, 3),
                width: double.infinity,
                child: LinearPercentIndicator(
//              width: MediaQuery.of(context).size.width,
                  animation: true,
                  lineHeight: 38.0,
                  animationDuration: 500,
                  percent: PollMath().getPerc(
                      widget.v1, widget.v2, widget.v3, widget.v4, 3)[0],
                  center: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(widget.c3.toString(),
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: widget.highest == widget.v3
                                    ? FontWeight.w900
                                    : FontWeight.w100,
                              )),
                          SizedBox(
                            width: 10,
                          ),
                          myOwnChoice(widget.userChoice == 3)
                        ],
                      ),
                      Text(
                          PollMath()
                                  .getMainPerc(widget.v1, widget.v2, widget.v3,
                                      widget.v4, 3)
                                  .toString() +
                              "%",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: widget.highest == widget.v3
                                ? FontWeight.w900
                                : FontWeight.w100,
                          ))
                    ],
                  ),
                  linearStrokeCap: LinearStrokeCap.roundAll,
                  progressColor: widget.highest == widget.v3
                      ? widget.votedBackgroundColor
                      : widget.votedBackgroundColor.withOpacity(0.7),
                ),
              ),
        widget.c4 == null
            ? Offstage()
            : Container(
                margin: EdgeInsets.fromLTRB(3, 3, 10, 3),
                width: double.infinity,
                child: LinearPercentIndicator(
//              width: MediaQuery.of(context).size.width,
                  animation: true,
                  lineHeight: 38.0,
                  animationDuration: 500,
                  percent: PollMath().getPerc(
                      widget.v1, widget.v2, widget.v3, widget.v4, 4)[0],
                  center: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(widget.c4.toString(),
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: widget.highest == widget.v4
                                    ? FontWeight.w900
                                    : FontWeight.w100,
                              )),
                          SizedBox(
                            width: 10,
                          ),
                          myOwnChoice(widget.userChoice == 4)
                        ],
                      ),
                      Text(
                          PollMath()
                                  .getMainPerc(widget.v1, widget.v2, widget.v3,
                                      widget.v4, 4)
                                  .toString() +
                              "%",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: widget.highest == widget.v4
                                ? FontWeight.w900
                                : FontWeight.w100,
                          ))
                    ],
                  ),
                  linearStrokeCap: LinearStrokeCap.roundAll,
                  progressColor: widget.highest == widget.v4
                      ? widget.votedBackgroundColor
                      : widget.votedBackgroundColor.withOpacity(0.7),
                ),
              ),
      ],
    );
  }

  Widget myOwnChoice(choice) {
    if (choice) {
      return Icon(
        Icons.check_circle_outline,
        color: Colors.white,
        size: 17,
      );
    } else {
      return Container();
    }
  }
}
