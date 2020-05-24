
import 'package:percent_indicator/percent_indicator.dart';
import 'package:polls/core/maths.dart';
import 'package:polls/core/globals.dart';
import 'package:flutter/material.dart';

typedef void PollCallBack(int choice);

class Polls extends StatefulWidget {

  final Text question;

  final int type;

  final List children;

  final PollCallBack onVote;

  final int userChoice;

  final bool allowCreatorVote;

  @protected
  String c1;

  @protected
  String c2;

  @protected
  String c3;

  @protected
  String c4;

  @protected
  double v1;

  @protected
  double v2;

  @protected
  double v3;

  @protected
  double v4;

  @protected
  int total;

  @protected
  double highest;

  /// style
  TextStyle pollStyle;
  TextStyle leadingPollStyle;

  ///colors
  Color outlineColor;
  Color backgroundColor;
  Color iconColor = Colors.black;
  Color leadingBackgroundColor = Colors.blueGrey;

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
    this.userChoice = 2,
    this.allowCreatorVote = false,
    this.onVote,
    this.type = 2,
    this.outlineColor = Colors.blue,
    this.backgroundColor = Colors.blueGrey,
    this.pollStyle,
  })  : assert(onVote != null),
        assert(question != null),
        assert(children != null) {
    this.pollStyle == null ?? TextStyle(color: Colors.black,fontWeight: FontWeight.w300);
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
    this.leadingPollStyle,
    this.pollStyle,
    this.backgroundColor = Colors.blue,
    this.leadingBackgroundColor = Colors.blueAccent,
    this.iconColor = Colors.black
  })  : allowCreatorVote = null,
        type = 3,
        onVote = null,
        assert(children != null),
        assert(question != null) {
    this.pollStyle == null ?? TextStyle(color: Colors.black,fontWeight: FontWeight.w900);
    this.leadingPollStyle == null ?? TextStyle(color: Colors.black,fontWeight: FontWeight.w900);
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
    this.leadingPollStyle,
    this.pollStyle,
    this.backgroundColor = Colors.blue,
    this.leadingBackgroundColor = Colors.blueAccent,
    this.allowCreatorVote = false
  })  : type = 1,
        onVote = null,
        userChoice = null,
        assert(children != null),assert(question != null) {

    this.pollStyle = this.pollStyle == null ? TextStyle(color: Colors.black, fontWeight: FontWeight.w300) : this.pollStyle;
    this.leadingPollStyle =this.leadingPollStyle == null ? TextStyle(color: Colors.black, fontWeight: FontWeight.w800) : this.leadingPollStyle;

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

  Polls.castVote({
    @required this.children,
    @required this.question,
    this.userChoice = 2,
    this.allowCreatorVote = false,
    this.onVote,
    this.type = 2,
    this.outlineColor = Colors.blue,
    this.backgroundColor = Colors.blueGrey,
    this.pollStyle,
  })  : assert(onVote != null),
        assert(question != null),
        assert(children != null) {
    this.pollStyle == null ?? TextStyle(color: Colors.black,fontWeight: FontWeight.w300);
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
      //user can cast vote with this widget
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
      //user can view his votes with this widget
      return voteCasted(context);
    }
    return Container();
  }

  Widget voterWidget(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[

        widget.question,
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
              child: Text(widget.c1, style: widget.pollStyle),
              borderSide: BorderSide(
                color: widget.outlineColor,
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
              child: Text(widget.c2, style: widget.pollStyle),
              borderSide: BorderSide(
                color: widget.outlineColor,
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
              child: Text(widget.c3, style: widget.pollStyle),
              borderSide: BorderSide(
                color: widget.outlineColor,
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
              child: Text(widget.c4, style: widget.pollStyle),
              borderSide: BorderSide(
                color: widget.outlineColor,
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        widget.question,
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
                          style: widget.highest == widget.v1
                              ? widget.leadingPollStyle : widget.pollStyle
                      ),
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
                      style: widget.highest == widget.v1
                          ? widget.leadingPollStyle : widget.pollStyle)
                ],
              ),
              linearStrokeCap: LinearStrokeCap.roundAll,
              progressColor: widget.highest == widget.v1
                  ? widget.leadingBackgroundColor
                  : widget.backgroundColor),
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
                          style: widget.highest == widget.v2
                              ? widget.leadingPollStyle : widget.pollStyle),
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
                      style: widget.highest == widget.v2
                          ? widget.leadingPollStyle : widget.pollStyle)
                ],
              ),
              linearStrokeCap: LinearStrokeCap.roundAll,
              progressColor: widget.highest == widget.v2
                  ? widget.leadingBackgroundColor
                  : widget.backgroundColor),
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
                          style: widget.highest == widget.v3
                              ? widget.leadingPollStyle : widget.pollStyle),
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
                      style: widget.highest == widget.v3
                          ? widget.leadingPollStyle : widget.pollStyle)
                ],
              ),
              linearStrokeCap: LinearStrokeCap.roundAll,
              progressColor: widget.highest == widget.v3
                  ? widget.leadingBackgroundColor
                  : widget.backgroundColor),
        )
            : Offstage(),
        widget.c4 != null
            ? Container(
          margin: EdgeInsets.fromLTRB(3, 3, 10, 3),
          width: double.infinity,
          child: LinearPercentIndicator(

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
                          style: widget.highest == widget.v4
                              ? widget.leadingPollStyle : widget.pollStyle),
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
                      style: widget.highest == widget.v4
                          ? widget.leadingPollStyle : widget.pollStyle)
                ],
              ),
              linearStrokeCap: LinearStrokeCap.roundAll,
              progressColor: widget.highest == widget.v4
                  ? widget.leadingBackgroundColor
                  : widget.backgroundColor),
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        widget.question,
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
                        style: widget.highest == widget.v1
                            ? widget.leadingPollStyle : widget.pollStyle),
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
                    style: widget.highest == widget.v1
                        ? widget.leadingPollStyle : widget.pollStyle)
              ],
            ),
            linearStrokeCap: LinearStrokeCap.roundAll,
            progressColor: widget.highest == widget.v1
                ? widget.leadingBackgroundColor
                : widget.backgroundColor,
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
                        style: widget.highest == widget.v2
                            ? widget.leadingPollStyle : widget.pollStyle),
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
                    style: widget.highest == widget.v2
                        ? widget.leadingPollStyle : widget.pollStyle)
              ],
            ),
            linearStrokeCap: LinearStrokeCap.roundAll,
            progressColor: widget.highest == widget.v2
                ? widget.leadingBackgroundColor
                : widget.backgroundColor,
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
                        style: widget.highest == widget.v3
                            ? widget.leadingPollStyle : widget.pollStyle),
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
                    style: widget.highest == widget.v3
                        ? widget.leadingPollStyle : widget.pollStyle)
              ],
            ),
            linearStrokeCap: LinearStrokeCap.roundAll,
            progressColor: widget.highest == widget.v3
                ? widget.leadingBackgroundColor
                : widget.backgroundColor,
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
                        style: widget.highest == widget.v4
                            ? widget.leadingPollStyle : widget.pollStyle),
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
                    style: widget.highest == widget.v4
                        ? widget.leadingPollStyle : widget.pollStyle)
              ],
            ),
            linearStrokeCap: LinearStrokeCap.roundAll,
            progressColor: widget.highest == widget.v4
                ? widget.leadingBackgroundColor
                : widget.backgroundColor,
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
