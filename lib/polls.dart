library polls;

import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter/material.dart';

typedef void PollCallBack(int choice);

typedef void PollTotal(int total);

int userPollChoice;

class Polls extends StatefulWidget {
  /// this takes the question on the poll
  final Text question;

  ///this determines what type of view user should see
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

  /// this returns total votes casted
  final PollTotal getTotal;

  /// this returns highest votes casted
  final PollTotal getHighest;

  @protected
  final double highest;

  /// style
  final TextStyle pollStyle;
  final TextStyle leadingPollStyle;

  ///colors setting for polls widget
  final Color outlineColor;
  final Color backgroundColor;
  final Color onVoteBackgroundColor;
  final Color iconColor;
  final Color leadingBackgroundColor;

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
    this.iconColor = Colors.black,
    this.leadingBackgroundColor = Colors.blueGrey,
  })  : highest = null,
        getHighest = null,
        getTotal = null,
        assert(viewType != null),
        assert(onVote != null),
        assert(question != null),
        assert(children != null);

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
        getTotal = null,
        highest = null,
        getHighest = null,
        outlineColor = null,
        viewType = PollsType.readOnly,
        onVote = null,
        assert(children != null),
        assert(question != null);

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
        highest = null,
        getHighest = null,
        getTotal = null,
        iconColor = null,
        outlineColor = null,
        assert(children != null),
        assert(question != null);

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
        highest = null,
        getHighest = null,
        getTotal = null,
        iconColor = null,
        leadingBackgroundColor = null,
        leadingPollStyle = null,
        onVoteBackgroundColor = null,
        assert(onVote != null),
        assert(question != null),
        assert(children != null);

  @override
  _PollsState createState() => _PollsState();
}

class _PollsState extends State<Polls> {
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

  /// user choices
  String choice1Title = '';

  String choice2Title = '';

  String choice3Title = '';

  String choice4Title = '';

  double choice1Value = 0.0;

  double choice2Value = 0.0;

  double choice3Value = 0.0;

  double choice4Value = 0.0;

  /// style
  TextStyle pollStyle;
  TextStyle leadingPollStyle;

  ///colors setting for polls widget
  Color outlineColor;
  Color backgroundColor;
  Color onVoteBackgroundColor;
  Color iconColor;
  Color leadingBackgroundColor;

  double highest;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    /// if polls style is null, it sets default pollstyle and leading pollstyle
    this.pollStyle = widget.pollStyle == null
        ? TextStyle(color: Colors.black, fontWeight: FontWeight.w300)
        : this.pollStyle;
    this.leadingPollStyle = widget.leadingPollStyle == null
        ? TextStyle(color: Colors.black, fontWeight: FontWeight.w800)
        : this.leadingPollStyle;

    /// choice values are set from children
    this.choice1Value = widget.children[0][1];
    this.choice1Title = widget.children[0][0];
    this.v1 = widget.children[0][1];
    this.c1 = widget.children[0][0];

    this.choice2Value = widget.children[1][1];
    this.choice2Title = widget.children[1][0];
    this.v2 = widget.children[1][1];
    this.c2 = widget.children[1][0];

    if (widget.children.length > 2) {
      this.choice3Value = widget.children[2][1];
      this.choice3Title = widget.children[2][0];
      this.v3 = widget.children[2][1];
      this.c3 = widget.children[2][0];
    }

    if (widget.children.length > 3) {
      this.choice4Value = widget.children[3][1];
      this.choice4Title = widget.children[3][0];
      this.v4 = widget.children[3][1];
      this.c4 = widget.children[3][0];
    }
  }

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
              child: Text(this.c1, style: widget.pollStyle),
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
              child: Text(this.c2, style: widget.pollStyle),
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
        this.c3 != null
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
                    child: Text(this.c3, style: widget.pollStyle),
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
        this.c4 != null
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
                    child: Text(this.c4, style: widget.pollStyle),
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
    var sortedKeys = [this.v1, this.v2, this.v3, this.v4];

    double current = 0;

    for (var i = 0; i < sortedKeys.length; i++) {
      if (sortedKeys[i] != null) {
        double s = double.parse(sortedKeys[i].toString());

        if (sortedKeys[i] >= current) {
          current = s;
        }
      }
    }

    this.highest = current;

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
              percent:
                  PollMath().getPerc(this.v1, this.v2, this.v3, this.v4, 1)[0],
              center: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(this.c1,
                          style: this.highest == this.v1
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
                                  this.v1, this.v2, this.v3, this.v4, 1)
                              .toString() +
                          "%",
                      style: this.highest == this.v1
                          ? widget.leadingPollStyle
                          : widget.pollStyle)
                ],
              ),
              linearStrokeCap: LinearStrokeCap.roundAll,
              progressColor: this.highest == this.v1
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
              percent:
                  PollMath().getPerc(this.v1, this.v2, this.v3, this.v4, 2)[0],
              center: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(this.c2,
                          style: widget.highest == this.v2
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
                                  this.v1, this.v2, this.v3, this.v4, 2)
                              .toString() +
                          "%",
                      style: this.highest == this.v2
                          ? widget.leadingPollStyle
                          : widget.pollStyle)
                ],
              ),
              linearStrokeCap: LinearStrokeCap.roundAll,
              progressColor: this.highest == this.v2
                  ? widget.leadingBackgroundColor
                  : widget.onVoteBackgroundColor),
        ),
        this.c3 != null
            ? Container(
                margin: EdgeInsets.fromLTRB(3, 3, 10, 3),
                width: double.infinity,
                child: LinearPercentIndicator(
//              width: MediaQuery.of(context).size.width,

                    animation: true,
                    lineHeight: 38.0,
                    animationDuration: 500,
                    percent: PollMath()
                        .getPerc(this.v1, this.v2, this.v3, this.v4, 3)[0],
                    center: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(this.c3,
                                style: this.highest == this.v3
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
                                        this.v1, this.v2, this.v3, this.v4, 3)
                                    .toString() +
                                "%",
                            style: this.highest == this.v3
                                ? widget.leadingPollStyle
                                : widget.pollStyle)
                      ],
                    ),
                    linearStrokeCap: LinearStrokeCap.roundAll,
                    progressColor: this.highest == this.v3
                        ? widget.leadingBackgroundColor
                        : widget.onVoteBackgroundColor),
              )
            : Offstage(),
        this.c4 != null
            ? Container(
                margin: EdgeInsets.fromLTRB(3, 3, 10, 3),
                width: double.infinity,
                child: LinearPercentIndicator(
                    animation: true,
                    lineHeight: 38.0,
                    animationDuration: 500,
                    percent: PollMath()
                        .getPerc(this.v1, this.v2, this.v3, this.v4, 4)[0],
                    center: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(this.c4.toString(),
                                style: widget.highest == this.v4
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
                                        this.v1, this.v2, this.v3, this.v4, 4)
                                    .toString() +
                                "%",
                            style: this.highest == this.v4
                                ? widget.leadingPollStyle
                                : widget.pollStyle)
                      ],
                    ),
                    linearStrokeCap: LinearStrokeCap.roundAll,
                    progressColor: this.highest == this.v4
                        ? widget.leadingBackgroundColor
                        : widget.onVoteBackgroundColor),
              )
            : Offstage(),
      ],
    );
  }

  /// voteCasted created view for user to see votes they casted including other peoples vote
  Widget voteCasted(context) {

    // Fix by Contributor
    this.v1 = widget.children[0][1];
    this.v2 = widget.children[1][1];
    if (this.c3 != null) this.v3 = widget.children[2][1];
    if (this.c4 != null) this.v4 = widget.children[3][1];


    var sortedKeys = [this.v1, this.v2, this.v3, this.v4];
    double current = 0;
    for (var i = 0; i < sortedKeys.length; i++) {
      if (sortedKeys[i] != null) {
        double s = double.parse(sortedKeys[i].toString());
        if (sortedKeys[i] >= current) {
          current = s;
        }
      }
    }
    this.highest = current;
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
            percent:
                PollMath().getPerc(this.v1, this.v2, this.v3, this.v4, 1)[0],
            center: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(this.c1.toString(),
                        style: this.highest == this.v1
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
                            .getMainPerc(this.v1, this.v2, this.v3, this.v4, 1)
                            .toString() +
                        "%",
                    style: this.highest == this.v1
                        ? widget.leadingPollStyle
                        : widget.pollStyle)
              ],
            ),
            linearStrokeCap: LinearStrokeCap.roundAll,
            progressColor: this.highest == this.v1
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
            percent:
                PollMath().getPerc(this.v1, this.v2, this.v3, this.v4, 2)[0],
            center: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(this.c2.toString(),
                        style: this.highest == this.v2
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
                            .getMainPerc(this.v1, this.v2, this.v3, this.v4, 2)
                            .toString() +
                        "%",
                    style: this.highest == this.v2
                        ? widget.leadingPollStyle
                        : widget.pollStyle)
              ],
            ),
            linearStrokeCap: LinearStrokeCap.roundAll,
            progressColor: this.highest == this.v2
                ? widget.leadingBackgroundColor
                : widget.onVoteBackgroundColor,
          ),
        ),
        this.c3 == null
            ? Offstage()
            : Container(
                margin: EdgeInsets.fromLTRB(3, 3, 10, 3),
                width: double.infinity,
                child: LinearPercentIndicator(
//              width: MediaQuery.of(context).size.width,
                  animation: true,
                  lineHeight: 38.0,
                  animationDuration: 500,
                  percent: PollMath()
                      .getPerc(this.v1, this.v2, this.v3, this.v4, 3)[0],
                  center: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(this.c3.toString(),
                              style: this.highest == this.v3
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
                                  .getMainPerc(
                                      this.v1, this.v2, this.v3, this.v4, 3)
                                  .toString() +
                              "%",
                          style: this.highest == this.v3
                              ? widget.leadingPollStyle
                              : widget.pollStyle)
                    ],
                  ),
                  linearStrokeCap: LinearStrokeCap.roundAll,
                  progressColor: this.highest == this.v3
                      ? widget.leadingBackgroundColor
                      : widget.onVoteBackgroundColor,
                ),
              ),
        this.c4 == null
            ? Offstage()
            : Container(
                margin: EdgeInsets.fromLTRB(3, 3, 10, 3),
                width: double.infinity,
                child: LinearPercentIndicator(
//              width: MediaQuery.of(context).size.width,
                  animation: true,
                  lineHeight: 38.0,
                  animationDuration: 500,
                  percent: PollMath()
                      .getPerc(this.v1, this.v2, this.v3, this.v4, 4)[0],
                  center: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(this.c4.toString(),
                              style: this.highest == this.v4
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
                                  .getMainPerc(
                                      this.v1, this.v2, this.v3, this.v4, 4)
                                  .toString() +
                              "%",
                          style: this.highest == this.v4
                              ? widget.leadingPollStyle
                              : widget.pollStyle)
                    ],
                  ),
                  linearStrokeCap: LinearStrokeCap.roundAll,
                  progressColor: this.highest == this.v4
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
