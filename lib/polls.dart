library polls;

import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter/material.dart';

typedef void PollCallBack(int choice);

typedef void PollTotal(int total);

late int userPollChoice;

class Polls extends StatefulWidget {
  /// this takes the question on the poll
  final Text question;

  ///this determines what type of view user should see
  ///if its creator, or view requiring you to vote or view showing your vote
  final PollsType? viewType;

  ///this takes in vote data which should be a Map
  /// with this, polls widget determines what type of view the user should see
  final Map? voteData;

  final String? currentUser;

  final String? creatorID;

  /// this takes in poll options array
  final List children;

  /// this call back returns user choice after voting
  final PollCallBack? onVote;

  /// this is takes in current user choice
  final int? userChoice;

  /// this determines if the creator of the poll can vote or not
  final bool allowCreatorVote;

  /// this returns total votes casted
  final PollTotal? getTotal;

  /// this returns highest votes casted
  final PollTotal? getHighest;

  @protected
  final double? highest;

  /// style
  final TextStyle? pollStyle;
  final TextStyle? leadingPollStyle;

  ///colors setting for polls widget
  final Color outlineColor;
  final Color backgroundColor;
  final Color? onVoteBackgroundColor;
  final Color? iconColor;
  final Color? leadingBackgroundColor;

  /// Polls contruct by default get view for voting
  Polls({
    required this.children,
    required this.question,
    required this.voteData,
    required this.currentUser,
    required this.creatorID,
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
        viewType = null,
        assert(onVote != null),
        assert(question != null),
        assert(children != null),
        assert(voteData != null),
        assert(currentUser != null),
        assert(creatorID != null);

  /// Polls.option is used to set polls options
  static List options({required String title, required double value}) {
    if (title != null && value != null) {
      return [title, value];
    } else {
      throw 'Poll Option(title or Value is equal to )';
    }
  }

  /// this creates view for see polls result
  Polls.viewPolls(
      {required this.children,
      required this.question,
      this.userChoice,
      this.leadingPollStyle,
      this.pollStyle,
      this.backgroundColor = Colors.blue,
      this.leadingBackgroundColor = Colors.blueAccent,
      this.onVoteBackgroundColor = Colors.blueGrey,
      this.iconColor = Colors.black})
      : allowCreatorVote = false,
        getTotal = null,
        highest = null,
        voteData = null,
        currentUser = null,
        creatorID = null,
        getHighest = null,
        outlineColor = Colors.transparent,
        viewType = PollsType.readOnly,
        onVote = null,
        assert(children != null),
        assert(question != null);

  /// This creates view for the creator of the polls
  Polls.creator(
      {required this.children,
      required this.question,
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
        voteData = null,
        currentUser = null,
        creatorID = null,
        getTotal = null,
        iconColor = null,
        outlineColor = Colors.transparent,
        assert(children != null),
        assert(question != null);

  /// this creates view for users to cast votes
  Polls.castVote({
    required this.children,
    required this.question,
    required this.onVote,
    this.allowCreatorVote = false,
    this.outlineColor = Colors.blue,
    this.backgroundColor = Colors.blueGrey,
    this.pollStyle,
  })  : viewType = PollsType.voter,
        userChoice = null,
        highest = null,
        getHighest = null,
        getTotal = null,
        iconColor = null,
        voteData = null,
        currentUser = null,
        creatorID = null,
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
  late String c1;

  /// c2 stands for choice 2
  @protected
  late String c2;

  /// c3 stands for choice 3
  @protected
  String? c3;

  /// c4 stands for choice 4
  @protected
  String? c4;

  /// c3 stands for choice 5
  @protected
  String? c5;

  /// c4 stands for choice 6
  @protected
  String? c6;

  /// c3 stands for choice 7
  @protected
  String? c7;

  /// c4 stands for choice 8
  @protected
  String? c8;

  /// v1 stands for value 1
  @protected
  late double v1;

  /// v2 stands for value 2
  @protected
  late double v2;

  @protected
  double? v3;

  @protected
  double? v4;

  @protected
  double? v5;

  @protected
  double? v6;

  @protected
  double? v7;

  @protected
  double? v8;

  /// user choices
  String choice1Title = '';

  String choice2Title = '';

  String choice3Title = '';

  String choice4Title = '';

  String choice5Title = '';

  String choice6Title = '';

  String choice7Title = '';

  String choice8Title = '';

  double choice1Value = 0.0;

  double choice2Value = 0.0;

  double choice3Value = 0.0;

  double choice4Value = 0.0;

  double choice5Value = 0.0;

  double choice6Value = 0.0;

  double choice7Value = 0.0;

  double choice8Value = 0.0;

  /// style
  late TextStyle pollStyle;
  late TextStyle leadingPollStyle;

  ///colors setting for polls widget
  Color? outlineColor;
  Color? backgroundColor;
  Color? onVoteBackgroundColor;
  Color? iconColor;
  Color? leadingBackgroundColor;

  late double highest;

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

    if (widget.children.length > 4) {
      this.choice5Value = widget.children[4][1];
      this.choice5Title = widget.children[4][0];
      this.v5 = widget.children[4][1];
      this.c5 = widget.children[4][0];
    }

    if (widget.children.length > 5) {
      this.choice6Value = widget.children[5][1];
      this.choice6Title = widget.children[5][0];
      this.v6 = widget.children[5][1];
      this.c6 = widget.children[5][0];
    }

    if (widget.children.length > 6) {
      this.choice7Value = widget.children[6][1];
      this.choice7Title = widget.children[6][0];
      this.v7 = widget.children[6][1];
      this.c7 = widget.children[6][0];
    }

    if (widget.children.length > 7) {
      this.choice8Value = widget.children[7][1];
      this.choice8Title = widget.children[7][0];
      this.v8 = widget.children[7][1];
      this.c8 = widget.children[7][0];
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.viewType == null) {
      var viewType = (widget.voteData?.containsKey(widget.currentUser) ?? false)
          ? PollsType.readOnly
          : widget.currentUser == widget.creatorID
              ? PollsType.creator
              : PollsType.voter;
      if (viewType == PollsType.voter) {
        //user can cast vote with this widget
        return voterWidget(context);
      }
      if (viewType == PollsType.creator) {
        //mean this is the creator of the polls and cannot vote
        if (widget.allowCreatorVote) {
          return voterWidget(context);
        }
        return pollCreator(context);
      }

      if (viewType == PollsType.readOnly) {
        //user can view his votes with this widget
        return voteCasted(context);
      }
    } else {
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
                widget.onVote!(userPollChoice);
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
                widget.onVote!(userPollChoice);
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
                      widget.onVote!(userPollChoice);
                    },
                    color: Colors.green,
                    padding: EdgeInsets.all(5.0),
                    child: Text(this.c3 ?? '', style: widget.pollStyle),
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
                      widget.onVote!(userPollChoice);
                    },
                    color: Colors.green,
                    padding: EdgeInsets.all(5.0),
                    child: Text(this.c4 ?? '', style: widget.pollStyle),
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
        this.c5 != null
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
                        userPollChoice = 5;
                      });
                      widget.onVote!(userPollChoice);
                    },
                    color: Colors.green,
                    padding: EdgeInsets.all(5.0),
                    child: Text(this.c5 ?? '', style: widget.pollStyle),
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
        this.c6 != null
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
                        userPollChoice = 6;
                      });
                      widget.onVote!(userPollChoice);
                    },
                    color: Colors.green,
                    padding: EdgeInsets.all(5.0),
                    child: Text(this.c6 ?? '', style: widget.pollStyle),
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
        this.c7 != null
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
                        userPollChoice = 7;
                      });
                      widget.onVote!(userPollChoice);
                    },
                    color: Colors.green,
                    padding: EdgeInsets.all(5.0),
                    child: Text(this.c7 ?? '', style: widget.pollStyle),
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
        this.c8 != null
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
                        userPollChoice = 8;
                      });
                      widget.onVote!(userPollChoice);
                    },
                    color: Colors.green,
                    padding: EdgeInsets.all(5.0),
                    child: Text(this.c8 ?? '', style: widget.pollStyle),
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
    var sortedKeys = [
      this.v1,
      this.v2,
      this.v3,
      this.v4,
      this.v5,
      this.v6,
      this.v7,
      this.v8
    ];

    double current = 0;

    for (var i = 0; i < sortedKeys.length; i++) {
      if (sortedKeys[i] != null) {
        double s = double.parse(sortedKeys[i].toString());

        if ((sortedKeys[i] ?? 0) >= current) {
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
              percent: PollMath.getPerc(this.v1, this.v2, this.v3, this.v4,
                  this.v5, this.v6, this.v7, this.v8, 1)[0],
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
                      PollMath.getMainPerc(this.v1, this.v2, this.v3, this.v4,
                                  this.v5, this.v6, this.v7, this.v8, 1)
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
              percent: PollMath.getPerc(this.v1, this.v2, this.v3, this.v4,
                  this.v5, this.v6, this.v7, this.v8, 2)[0],
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
                      PollMath.getMainPerc(this.v1, this.v2, this.v3, this.v4,
                                  this.v5, this.v6, this.v7, this.v8, 2)
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
                    percent: PollMath.getPerc(this.v1, this.v2, this.v3,
                        this.v4, this.v5, this.v6, this.v7, this.v8, 3)[0],
                    center: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(this.c3 ?? '',
                                style: this.highest == this.v3
                                    ? widget.leadingPollStyle
                                    : widget.pollStyle),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                        Text(
                            PollMath.getMainPerc(
                                        this.v1,
                                        this.v2,
                                        this.v3,
                                        this.v4,
                                        this.v5,
                                        this.v6,
                                        this.v7,
                                        this.v8,
                                        3)
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
                    percent: PollMath.getPerc(this.v1, this.v2, this.v3,
                        this.v4, this.v5, this.v6, this.v7, this.v8, 4)[0],
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
                            PollMath.getMainPerc(
                                        this.v1,
                                        this.v2,
                                        this.v3,
                                        this.v4,
                                        this.v5,
                                        this.v6,
                                        this.v7,
                                        this.v8,
                                        4)
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
        this.c5 != null
            ? Container(
                margin: EdgeInsets.fromLTRB(3, 3, 10, 3),
                width: double.infinity,
                child: LinearPercentIndicator(
                    animation: true,
                    lineHeight: 38.0,
                    animationDuration: 500,
                    percent: PollMath.getPerc(this.v1, this.v2, this.v3,
                        this.v4, this.v5, this.v6, this.v7, this.v8, 5)[0],
                    center: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(this.c5.toString(),
                                style: widget.highest == this.v5
                                    ? widget.leadingPollStyle
                                    : widget.pollStyle),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                        Text(
                            PollMath.getMainPerc(
                                        this.v1,
                                        this.v2,
                                        this.v3,
                                        this.v4,
                                        this.v5,
                                        this.v6,
                                        this.v7,
                                        this.v8,
                                        5)
                                    .toString() +
                                "%",
                            style: this.highest == this.v5
                                ? widget.leadingPollStyle
                                : widget.pollStyle)
                      ],
                    ),
                    linearStrokeCap: LinearStrokeCap.roundAll,
                    progressColor: this.highest == this.v5
                        ? widget.leadingBackgroundColor
                        : widget.onVoteBackgroundColor),
              )
            : Offstage(),

        this.c6 != null
            ? Container(
          margin: EdgeInsets.fromLTRB(3, 3, 10, 3),
          width: double.infinity,
          child: LinearPercentIndicator(
              animation: true,
              lineHeight: 38.0,
              animationDuration: 500,
              percent: PollMath.getPerc(this.v1, this.v2, this.v3,
                  this.v4, this.v5, this.v6, this.v7, this.v8, 6)[0],
              center: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(this.c6.toString(),
                          style: widget.highest == this.v6
                              ? widget.leadingPollStyle
                              : widget.pollStyle),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                  Text(
                      PollMath.getMainPerc(
                          this.v1,
                          this.v2,
                          this.v3,
                          this.v4,
                          this.v5,
                          this.v6,
                          this.v7,
                          this.v8,
                          6)
                          .toString() +
                          "%",
                      style: this.highest == this.v6
                          ? widget.leadingPollStyle
                          : widget.pollStyle)
                ],
              ),
              linearStrokeCap: LinearStrokeCap.roundAll,
              progressColor: this.highest == this.v6
                  ? widget.leadingBackgroundColor
                  : widget.onVoteBackgroundColor),
        )
            : Offstage(),

        this.c7 != null
            ? Container(
          margin: EdgeInsets.fromLTRB(3, 3, 10, 3),
          width: double.infinity,
          child: LinearPercentIndicator(
              animation: true,
              lineHeight: 38.0,
              animationDuration: 500,
              percent: PollMath.getPerc(this.v1, this.v2, this.v3,
                  this.v4, this.v5, this.v6, this.v7, this.v8, 7)[0],
              center: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(this.c7.toString(),
                          style: widget.highest == this.v7
                              ? widget.leadingPollStyle
                              : widget.pollStyle),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                  Text(
                      PollMath.getMainPerc(
                          this.v1,
                          this.v2,
                          this.v3,
                          this.v4,
                          this.v5,
                          this.v6,
                          this.v7,
                          this.v8,
                          7)
                          .toString() +
                          "%",
                      style: this.highest == this.v7
                          ? widget.leadingPollStyle
                          : widget.pollStyle)
                ],
              ),
              linearStrokeCap: LinearStrokeCap.roundAll,
              progressColor: this.highest == this.v7
                  ? widget.leadingBackgroundColor
                  : widget.onVoteBackgroundColor),
        )
            : Offstage(),

        this.c8 != null
            ? Container(
          margin: EdgeInsets.fromLTRB(3, 3, 10, 3),
          width: double.infinity,
          child: LinearPercentIndicator(
              animation: true,
              lineHeight: 38.0,
              animationDuration: 500,
              percent: PollMath.getPerc(this.v1, this.v2, this.v3,
                  this.v4, this.v5, this.v6, this.v7, this.v8, 8)[0],
              center: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(this.c8.toString(),
                          style: widget.highest == this.v8
                              ? widget.leadingPollStyle
                              : widget.pollStyle),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                  Text(
                      PollMath.getMainPerc(
                          this.v1,
                          this.v2,
                          this.v3,
                          this.v4,
                          this.v5,
                          this.v6,
                          this.v7,
                          this.v8,
                          8)
                          .toString() +
                          "%",
                      style: this.highest == this.v8
                          ? widget.leadingPollStyle
                          : widget.pollStyle)
                ],
              ),
              linearStrokeCap: LinearStrokeCap.roundAll,
              progressColor: this.highest == this.v8
                  ? widget.leadingBackgroundColor
                  : widget.onVoteBackgroundColor),
        )
            : Offstage(),
      ],
    );
  }

  /// voteCasted created view for user to see votes they casted including other peoples vote
  Widget voteCasted(context) {
    /// Fix by AksharPrasanna
    this.v1 = widget.children[0][1];
    this.v2 = widget.children[1][1];
    if (this.c3 != null) this.v3 = widget.children[2][1];
    if (this.c4 != null) this.v4 = widget.children[3][1];
    if (this.c5 != null) this.v5 = widget.children[4][1];
    if (this.c6 != null) this.v6 = widget.children[5][1];
    if (this.c7 != null) this.v7 = widget.children[6][1];
    if (this.c8 != null) this.v8 = widget.children[7][1];

    var sortedKeys = [this.v1, this.v2, this.v3, this.v4, this.v5, this.v6, this.v7, this.v8];
    double current = 0;
    for (var i = 0; i < sortedKeys.length; i++) {
      if (sortedKeys[i] != null) {
        double s = double.parse(sortedKeys[i].toString());
        if ((sortedKeys[i] ?? 0) >= current) {
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
            percent: PollMath.getPerc(this.v1, this.v2, this.v3, this.v4,
                this.v5, this.v6, this.v7, this.v8, 1)[0],
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
                    PollMath.getMainPerc(this.v1, this.v2, this.v3, this.v4,
                                this.v5, this.v6, this.v7, this.v8, 1)
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
            percent: PollMath.getPerc(this.v1, this.v2, this.v3, this.v4,
                this.v5, this.v6, this.v7, this.v8, 2)[0],
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
                    PollMath.getMainPerc(this.v1, this.v2, this.v3, this.v4,
                                this.v5, this.v6, this.v7, this.v8, 2)
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
                  percent: PollMath.getPerc(this.v1, this.v2, this.v3, this.v4,
                      this.v5, this.v6, this.v7, this.v8, 3)[0],
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
                          PollMath.getMainPerc(
                                      this.v1,
                                      this.v2,
                                      this.v3,
                                      this.v4,
                                      this.v5,
                                      this.v6,
                                      this.v7,
                                      this.v8,
                                      3)
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
                  percent: PollMath.getPerc(this.v1, this.v2, this.v3, this.v4,
                      this.v5, this.v6, this.v7, this.v8, 4)[0],
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
                          PollMath.getMainPerc(
                                      this.v1,
                                      this.v2,
                                      this.v3,
                                      this.v4,
                                      this.v5,
                                      this.v6,
                                      this.v7,
                                      this.v8,
                                      4)
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

        this.c5 == null
            ? Offstage()
            : Container(
          margin: EdgeInsets.fromLTRB(3, 3, 10, 3),
          width: double.infinity,
          child: LinearPercentIndicator(
//              width: MediaQuery.of(context).size.width,
            animation: true,
            lineHeight: 38.0,
            animationDuration: 500,
            percent: PollMath.getPerc(this.v1, this.v2, this.v3, this.v4,
                this.v5, this.v6, this.v7, this.v8, 5)[0],
            center: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(this.c5.toString(),
                        style: this.highest == this.v5
                            ? widget.leadingPollStyle
                            : widget.pollStyle),
                    SizedBox(
                      width: 10,
                    ),
                    myOwnChoice(widget.userChoice == 5)
                  ],
                ),
                Text(
                    PollMath.getMainPerc(
                        this.v1,
                        this.v2,
                        this.v3,
                        this.v4,
                        this.v5,
                        this.v6,
                        this.v7,
                        this.v8,
                        5)
                        .toString() +
                        "%",
                    style: this.highest == this.v5
                        ? widget.leadingPollStyle
                        : widget.pollStyle)
              ],
            ),
            linearStrokeCap: LinearStrokeCap.roundAll,
            progressColor: this.highest == this.v5
                ? widget.leadingBackgroundColor
                : widget.onVoteBackgroundColor,
          ),
        ),

        this.c6 == null
            ? Offstage()
            : Container(
          margin: EdgeInsets.fromLTRB(3, 3, 10, 3),
          width: double.infinity,
          child: LinearPercentIndicator(
//              width: MediaQuery.of(context).size.width,
            animation: true,
            lineHeight: 38.0,
            animationDuration: 500,
            percent: PollMath.getPerc(this.v1, this.v2, this.v3, this.v4,
                this.v5, this.v6, this.v7, this.v8, 6)[0],
            center: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(this.c6.toString(),
                        style: this.highest == this.v6
                            ? widget.leadingPollStyle
                            : widget.pollStyle),
                    SizedBox(
                      width: 10,
                    ),
                    myOwnChoice(widget.userChoice == 6)
                  ],
                ),
                Text(
                    PollMath.getMainPerc(
                        this.v1,
                        this.v2,
                        this.v3,
                        this.v4,
                        this.v5,
                        this.v6,
                        this.v7,
                        this.v8,
                        6)
                        .toString() +
                        "%",
                    style: this.highest == this.v6
                        ? widget.leadingPollStyle
                        : widget.pollStyle)
              ],
            ),
            linearStrokeCap: LinearStrokeCap.roundAll,
            progressColor: this.highest == this.v6
                ? widget.leadingBackgroundColor
                : widget.onVoteBackgroundColor,
          ),
        ),

        this.c7 == null
            ? Offstage()
            : Container(
          margin: EdgeInsets.fromLTRB(3, 3, 10, 3),
          width: double.infinity,
          child: LinearPercentIndicator(
//              width: MediaQuery.of(context).size.width,
            animation: true,
            lineHeight: 38.0,
            animationDuration: 500,
            percent: PollMath.getPerc(this.v1, this.v2, this.v3, this.v4,
                this.v5, this.v6, this.v7, this.v8, 7)[0],
            center: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(this.c7.toString(),
                        style: this.highest == this.v7
                            ? widget.leadingPollStyle
                            : widget.pollStyle),
                    SizedBox(
                      width: 10,
                    ),
                    myOwnChoice(widget.userChoice == 7)
                  ],
                ),
                Text(
                    PollMath.getMainPerc(
                        this.v1,
                        this.v2,
                        this.v3,
                        this.v4,
                        this.v5,
                        this.v6,
                        this.v7,
                        this.v8,
                        7)
                        .toString() +
                        "%",
                    style: this.highest == this.v7
                        ? widget.leadingPollStyle
                        : widget.pollStyle)
              ],
            ),
            linearStrokeCap: LinearStrokeCap.roundAll,
            progressColor: this.highest == this.v7
                ? widget.leadingBackgroundColor
                : widget.onVoteBackgroundColor,
          ),
        ),

        this.c8 == null
            ? Offstage()
            : Container(
          margin: EdgeInsets.fromLTRB(3, 3, 10, 3),
          width: double.infinity,
          child: LinearPercentIndicator(
//              width: MediaQuery.of(context).size.width,
            animation: true,
            lineHeight: 38.0,
            animationDuration: 500,
            percent: PollMath.getPerc(this.v1, this.v2, this.v3, this.v4,
                this.v5, this.v6, this.v7, this.v8, 8)[0],
            center: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(this.c8.toString(),
                        style: this.highest == this.v8
                            ? widget.leadingPollStyle
                            : widget.pollStyle),
                    SizedBox(
                      width: 10,
                    ),
                    myOwnChoice(widget.userChoice == 8)
                  ],
                ),
                Text(
                    PollMath.getMainPerc(
                        this.v1,
                        this.v2,
                        this.v3,
                        this.v4,
                        this.v5,
                        this.v6,
                        this.v7,
                        this.v8,
                        8)
                        .toString() +
                        "%",
                    style: this.highest == this.v8
                        ? widget.leadingPollStyle
                        : widget.pollStyle)
              ],
            ),
            linearStrokeCap: LinearStrokeCap.roundAll,
            progressColor: this.highest == this.v8
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

/// does the maths for Polls
class PollMath {
  static getMainPerc(v1, v2, v3, v4, v5, v6, v7, v8, choice) {
    var div;
    var slot1res = v1;
    var slot2res = v2;
    var slot3res = v3 == null ? 0.0 : v3;
    var slot4res = v4 == null ? 0.0 : v4;
    var slot5res = v5 == null ? 0.0 : v5;
    var slot6res = v6 == null ? 0.0 : v6;
    var slot7res = v7 == null ? 0.0 : v7;
    var slot8res = v8 == null ? 0.0 : v8;

    if (choice == 1) {
      var sum = slot1res + slot2res + slot3res + slot4res + slot5res + slot6res + slot7res + slot8res;
      div = div = sum == 0 ? 0 : (100 / sum) * slot1res;
    }
    if (choice == 2) {
      var sum = slot1res + slot2res + slot3res + slot4res + slot5res + slot6res + slot7res + slot8res;
      div = div = sum == 0 ? 0 : (100 / sum) * slot2res;
    }
    if (choice == 3) {
      var sum = slot1res + slot2res + slot3res + slot4res + slot5res + slot6res + slot7res + slot8res;
      div = div = sum == 0 ? 0 : (100 / sum) * slot3res;
    }
    if (choice == 4) {
      var sum = slot1res + slot2res + slot3res + slot4res + slot5res + slot6res + slot7res + slot8res;
      div = div = sum == 0 ? 0 : (100 / sum) * slot4res;
    }
    if (choice == 5) {
      var sum = slot1res + slot2res + slot3res + slot4res + slot5res + slot6res + slot7res + slot8res;
      div = div = sum == 0 ? 0 : (100 / sum) * slot5res;
    }

    if (choice == 6) {
      var sum = slot1res + slot2res + slot3res + slot4res + slot5res + slot6res + slot7res + slot8res;
      div = div = sum == 0 ? 0 : (100 / sum) * slot6res;
    }

    if (choice == 7) {
      var sum = slot1res + slot2res + slot3res + slot4res + slot5res + slot6res + slot7res + slot8res;
      div = div = sum == 0 ? 0 : (100 / sum) * slot7res;
    }

    if (choice == 8) {
      var sum = slot1res + slot2res + slot3res + slot4res + slot5res + slot6res + slot7res + slot8res;
      div = div = sum == 0 ? 0 : (100 / sum) * slot8res;
    }

    return div == 0 ? 0 : div.round();
  }

  static List getPerc(v1, v2, v3, v4, v5, v6, v7, v8, choice) {
    var div;
    var slot1res = v1;
    var slot2res = v2;
    var slot3res = v3 == null ? 0.0 : v3;
    var slot4res = v4 == null ? 0.0 : v4;
    var slot5res = v5 == null ? 0.0 : v5;
    var slot6res = v6 == null ? 0.0 : v6;
    var slot7res = v7 == null ? 0.0 : v7;
    var slot8res = v8 == null ? 0.0 : v8;

    if (choice == 1) {
      var sum = slot1res + slot2res + slot3res + slot4res + slot5res + slot6res + slot7res + slot8res;;
      div = sum == 0 ? 0 : (1 / sum) * slot1res;
    }
    if (choice == 2) {
      var sum = slot1res + slot2res + slot3res + slot4res + slot5res + slot6res + slot7res + slot8res;
      div = sum == 0 ? 0 : (1 / sum) * slot2res;
    }
    if (choice == 3) {
      var sum = slot1res + slot2res + slot3res + slot4res+ slot5res + slot6res + slot7res + slot8res;
      div = sum == 0 ? 0 : (1 / sum) * slot3res;
    }
    if (choice == 4) {
      var sum = slot1res + slot2res + slot3res + slot4res+ slot5res + slot6res + slot7res + slot8res;
      div = sum == 0 ? 0 : (1 / sum) * slot4res;
    }

    if (choice == 5) {
      var sum = slot1res + slot2res + slot3res + slot4res+ slot5res + slot6res + slot7res + slot8res;
      div = sum == 0 ? 0 : (1 / sum) * slot5res;
    }

    if (choice == 6) {
      var sum = slot1res + slot2res + slot3res + slot4res+ slot5res + slot6res + slot7res + slot8res;
      div = sum == 0 ? 0 : (1 / sum) * slot6res;
    }

    if (choice == 7) {
      var sum = slot1res + slot2res + slot3res + slot4res+ slot5res + slot6res + slot7res + slot8res;
      div = sum == 0 ? 0 : (1 / sum) * slot7res;
    }

    if (choice == 8) {
      var sum = slot1res + slot2res + slot3res + slot4res+ slot5res + slot6res + slot7res + slot8res;
      div = sum == 0 ? 0 : (1 / sum) * slot8res;
    }
    return [div == 0 ? 0.0 : div.toDouble(), div];
  }
}
