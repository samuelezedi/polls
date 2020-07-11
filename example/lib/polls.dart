import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter/material.dart';

typedef void PollCallBack(int choice);

typedef void PollTotal(int total);

int userPollChoice;

class Polls extends StatefulWidget {
  /// this takes the question on the poll
  final Text question;

  ///this determines what type of view use should see
  ///if its creator, or view requiring you to vote or view showing your vote
  final PollsType viewType;

  /// this takes in poll options array
  final List children;

  /// this call back returns user choice after voting
  final PollCallBack onVote;

  /// this is takes in current user choice
  final int userChoice;

  /// this determines if the creator of the poll can vote or not
  final bool allowCreatorVote;

  /// c1 stands for choice 1
  @protected
  String c1;

  /// c2 stands for choice 2
  @protected
  String c2;

  /// c3 stands for choice 3
  @protected
  String c3;

  /// c4 stands for choice 4
  @protected
  String c4;

  /// v1 stands for value 1
  @protected
  double v1;

  /// v2 stands for value 2
  @protected
  double v2;

  @protected
  double v3;

  @protected
  double v4;

  /// this returns total votes casted
  PollTotal getTotal;

  /// this returns highest votes casted
  PollTotal getHighest;

  @protected
  double highest;

  /// style
  TextStyle pollStyle;
  TextStyle leadingPollStyle;

  ///colors setting for polls widget
  Color outlineColor;
  Color backgroundColor;
  Color onVoteBackgroundColor;
  Color iconColor = Colors.black;
  Color leadingBackgroundColor = Colors.blueGrey;

  bool userChoiceCheck;

  /// user choices
  String choice1Title = '';

  String choice2Title = '';

  String choice3Title = '';

  String choice4Title = '';

  double choice1Value = 0.0;

  double choice2Value = 0.0;

  double choice3Value = 0.0;

  double choice4Value = 0.0;

  /// Polls contruct by default get view for voting
  Polls({
    @required this.children,
    @required this.question,
    @required this.viewType,
    this.userChoice,
    this.allowCreatorVote = false,
    this.onVote,
    this.outlineColor = Colors.blue,
    this.backgroundColor = Colors.blueGrey,
    this.onVoteBackgroundColor = Colors.blue,
    this.leadingPollStyle,
    this.pollStyle,
    this.iconColor,
    this.leadingBackgroundColor,
  })  : assert(viewType != null),
        assert(onVote != null),
        assert(question != null),
        assert(children != null) {
    /// if polls style is null, it sets default pollstyle and leading pollstyle
    this.pollStyle = this.pollStyle == null
        ? TextStyle(color: Colors.black, fontWeight: FontWeight.w300)
        : this.pollStyle;
    this.leadingPollStyle = this.leadingPollStyle == null
        ? TextStyle(color: Colors.black, fontWeight: FontWeight.w800)
        : this.leadingPollStyle;

    /// choice values are set from children
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

  /// this creates view for see polls result
  Polls.viewPolls(
      {@required this.children,
        @required this.question,
        this.userChoice,
        this.leadingPollStyle,
        this.pollStyle,
        this.backgroundColor = Colors.blue,
        this.leadingBackgroundColor = Colors.blueAccent,
        this.onVoteBackgroundColor = Colors.blueGrey,
        this.iconColor = Colors.black})
      : allowCreatorVote = null,
        viewType = PollsType.readOnly,
        onVote = null,
        assert(children != null),
        assert(question != null) {
    this.pollStyle = this.pollStyle == null
        ? TextStyle(color: Colors.black, fontWeight: FontWeight.w300)
        : this.pollStyle;
    this.leadingPollStyle = this.leadingPollStyle == null
        ? TextStyle(color: Colors.black, fontWeight: FontWeight.w800)
        : this.leadingPollStyle;

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

  /// This creates view for the creator of the polls
  Polls.creator(
      {@required this.children,
        @required this.question,
        this.leadingPollStyle,
        this.pollStyle,
        this.backgroundColor = Colors.blue,
        this.leadingBackgroundColor = Colors.blueAccent,
        this.onVoteBackgroundColor = Colors.blueGrey,
        this.allowCreatorVote = false})
      : viewType = PollsType.creator,
        onVote = null,
        userChoice = null,
        assert(children != null),
        assert(question != null) {
    this.pollStyle = this.pollStyle == null
        ? TextStyle(color: Colors.black, fontWeight: FontWeight.w300)
        : this.pollStyle;
    this.leadingPollStyle = this.leadingPollStyle == null
        ? TextStyle(color: Colors.black, fontWeight: FontWeight.w800)
        : this.leadingPollStyle;

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

  /// this creates view for users to cast votes
  Polls.castVote({
    @required this.children,
    @required this.question,
    this.allowCreatorVote = false,
    this.onVote,
    this.outlineColor = Colors.blue,
    this.backgroundColor = Colors.blueGrey,
    this.pollStyle,
  })  : viewType = PollsType.voter,
        userChoice = null,
        assert(onVote != null),
        assert(question != null),
        assert(children != null) {
    this.pollStyle = this.pollStyle == null
        ? TextStyle(color: Colors.black, fontWeight: FontWeight.w300)
        : this.pollStyle;

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
    if (widget.viewType == PollsType.voter) {
      //user can cast vote with this widget
      return voterWidget(context);
    }
    if (widget.viewType == PollsType.creator) {
      //mean this is the creator of the polls and cannot vote
      if (widget.allowCreatorVote) {
        return voterWidget(context);
      }
      return pollCreator(context);
    }

    if (widget.viewType == PollsType.readOnly) {
      //user can view his votes with this widget
      return voteCasted(context);
    }
    return Container();
  }

  /// voterWidget creates view for users to cast their votes

  Widget voterWidget(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        widget.question,
        SizedBox(
          height: 12,
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.only(bottom: 10),
          child: Container(
            margin: EdgeInsets.all(0),
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(0),
            height: 35,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: widget.backgroundColor,
            ),
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
              ),
            ),
          ),
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.only(bottom: 10),
          child: Container(
            margin: EdgeInsets.all(0),
            padding: EdgeInsets.all(0),
            height: 35,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: widget.backgroundColor,
            ),
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
          padding: EdgeInsets.only(bottom: 10),
          child: Container(
            margin: EdgeInsets.all(0),
            padding: EdgeInsets.all(0),
            height: 35,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: widget.backgroundColor,
            ),
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
          padding: EdgeInsets.only(bottom: 10),
          child: Container(
            margin: EdgeInsets.all(0),
            padding: EdgeInsets.all(0),
            height: 35,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: widget.backgroundColor,
            ),
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

  /// pollCreator creates view for the creator of the polls,
  /// to see poll activities
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
        SizedBox(
          height: 12,
        ),
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
                              ? widget.leadingPollStyle
                              : widget.pollStyle),
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
                          ? widget.leadingPollStyle
                          : widget.pollStyle)
                ],
              ),
              linearStrokeCap: LinearStrokeCap.roundAll,
              progressColor: widget.highest == widget.v1
                  ? widget.leadingBackgroundColor
                  : widget.onVoteBackgroundColor),
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
                              ? widget.leadingPollStyle
                              : widget.pollStyle),
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
                          ? widget.leadingPollStyle
                          : widget.pollStyle)
                ],
              ),
              linearStrokeCap: LinearStrokeCap.roundAll,
              progressColor: widget.highest == widget.v2
                  ? widget.leadingBackgroundColor
                  : widget.onVoteBackgroundColor),
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
                              ? widget.leadingPollStyle
                              : widget.pollStyle),
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
                          ? widget.leadingPollStyle
                          : widget.pollStyle)
                ],
              ),
              linearStrokeCap: LinearStrokeCap.roundAll,
              progressColor: widget.highest == widget.v3
                  ? widget.leadingBackgroundColor
                  : widget.onVoteBackgroundColor),
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
                              ? widget.leadingPollStyle
                              : widget.pollStyle),
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
                          ? widget.leadingPollStyle
                          : widget.pollStyle)
                ],
              ),
              linearStrokeCap: LinearStrokeCap.roundAll,
              progressColor: widget.highest == widget.v4
                  ? widget.leadingBackgroundColor
                  : widget.onVoteBackgroundColor),
        )
            : Offstage(),
      ],
    );
  }

  /// voteCasted created view for user to see votes they casted including other peoples vote
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
        SizedBox(
          height: 12,
        ),
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
                    Text(widget.c1.toString(),
                        style: widget.highest == widget.v1
                            ? widget.leadingPollStyle
                            : widget.pollStyle),
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
                        ? widget.leadingPollStyle
                        : widget.pollStyle)
              ],
            ),
            linearStrokeCap: LinearStrokeCap.roundAll,
            progressColor: widget.highest == widget.v1
                ? widget.leadingBackgroundColor
                : widget.onVoteBackgroundColor,
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
                            ? widget.leadingPollStyle
                            : widget.pollStyle),
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
                        ? widget.leadingPollStyle
                        : widget.pollStyle)
              ],
            ),
            linearStrokeCap: LinearStrokeCap.roundAll,
            progressColor: widget.highest == widget.v2
                ? widget.leadingBackgroundColor
                : widget.onVoteBackgroundColor,
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
                            ? widget.leadingPollStyle
                            : widget.pollStyle),
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
                        ? widget.leadingPollStyle
                        : widget.pollStyle)
              ],
            ),
            linearStrokeCap: LinearStrokeCap.roundAll,
            progressColor: widget.highest == widget.v3
                ? widget.leadingBackgroundColor
                : widget.onVoteBackgroundColor,
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
                            ? widget.leadingPollStyle
                            : widget.pollStyle),
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
                        ? widget.leadingPollStyle
                        : widget.pollStyle)
              ],
            ),
            linearStrokeCap: LinearStrokeCap.roundAll,
            progressColor: widget.highest == widget.v4
                ? widget.leadingBackgroundColor
                : widget.onVoteBackgroundColor,
          ),
        ),
      ],
    );
  }

  /// simple logic to detect users choice and return a check icon
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

/// Help detect type of view user wants
enum PollsType {
  creator,
  voter,
  readOnly,
}

/// provides options array to polls
class PollOptions {
  double value;
  String title;

  PollOptions({@required this.title, @required this.value})
      : assert(title != null),
        assert(value != null);

  show() {
    return [this.title, this.value];
  }
}

/// does the maths for Polls
class PollMath {
  getMainPerc(v1, v2, v3, v4, choice) {
    var div;
    var slot1res = v1;
    var slot2res = v2;
    var slot3res = v3 == null ? 0.0 : v3;
    var slot4res = v4 == null ? 0.0 : v4;

    if (choice == 1) {
      var sum = slot1res + slot2res + slot3res + slot4res;
      div = div = sum == 0 ? 0 : (100 / sum) * slot1res;
    }
    if (choice == 2) {
      var sum = slot1res + slot2res + slot3res + slot4res;
      div = div = sum == 0 ? 0 : (100 / sum) * slot2res;
    }
    if (choice == 3) {
      var sum = slot1res + slot2res + slot3res + slot4res;
      div = div = sum == 0 ? 0 : (100 / sum) * slot3res;
    }
    if (choice == 4) {
      var sum = slot1res + slot2res + slot3res + slot4res;
      div = div = sum == 0 ? 0 : (100 / sum) * slot4res;
    }
    return div == 0 ? 0 : div.round();
  }

  List getPerc(v1, v2, v3, v4, choice) {
    var div;
    var slot1res = v1;
    var slot2res = v2;
    var slot3res = v3 == null ? 0.0 : v3;
    var slot4res = v4 == null ? 0.0 : v4;

    if (choice == 1) {
      var sum = slot1res + slot2res + slot3res + slot4res;
      div = sum == 0 ? 0 : (1 / sum) * slot1res;
    }
    if (choice == 2) {
      var sum = slot1res + slot2res + slot3res + slot4res;
      div = sum == 0 ? 0 : (1 / sum) * slot2res;
    }
    if (choice == 3) {
      var sum = slot1res + slot2res + slot3res + slot4res;
      div = sum == 0 ? 0 : (1 / sum) * slot3res;
    }
    if (choice == 4) {
      var sum = slot1res + slot2res + slot3res + slot4res;
      div = sum == 0 ? 0 : (1 / sum) * slot4res;
    }
    return [div == 0 ? 0.0 : div.toDouble(), div];
  }
}
