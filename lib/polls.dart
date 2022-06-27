library polls;

import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter/material.dart';
import 'package:polls/src/poll_maths.dart';
import 'package:polls/src/widgets/global.dart';
import 'package:equatable/equatable.dart';

part 'src/poll_options_model.dart';
part 'src/declarations.dart';
part 'src/poll_enums.dart';

// late int userPollChoice;

class Polls extends StatefulWidget {
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
    this.highest,
    this.getHighest,
    this.getTotal,
    this.viewType,
    this.barRadius = 10,
  });

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
  final List<PollOption> children;

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

  final double barRadius;

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

  @override
  _PollsState createState() => _PollsState();
}

class _PollsState extends State<Polls> {
  late int _userPollChoice;

  var choiceList = <String>[];
  var userChoiceList = <String>[];
  var valueList = <double>[];
  var userValueList = <double>[];

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
    this.pollStyle = widget.pollStyle ??
        TextStyle(color: Colors.black, fontWeight: FontWeight.w300);
    this.leadingPollStyle = widget.leadingPollStyle ??
        TextStyle(color: Colors.black, fontWeight: FontWeight.w800);

    print("right here");

    widget.children.map((e) {
      print("sdf");
      choiceList.add(e.option);
      userChoiceList.add(e.option);
      valueList.add(e.value);
      valueList.add(e.value);
    }).toList();
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
        Flexible(
          child: Column(
            children: widget.children.map((element) {
              int index = widget.children.indexOf(element);
              return Container(
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
                  child: OutlinedButton(
                    onPressed: () {
                      setState(() {
                        _userPollChoice = index;
                      });
                      widget.onVote!(index);
                    },
                    style: OutlinedButton.styleFrom(
                      primary: Colors.green,
                      padding: EdgeInsets.all(5.0),
                      side: BorderSide(
                        color: widget.outlineColor,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0),
                      ),
                    ),
                    child: Text(element.option, style: widget.pollStyle),
                  ),
                ),
              );
            }).toList(),
          ),
        )
      ],
    );
  }

  /// pollCreator creates view for the creator of the polls,
  /// to see poll activities
  Widget pollCreator(context) {
    var sortedKeys = valueList;

    //sort valueList
    sortedKeys.sort((a, b) => a.compareTo(b));
    double current = 0;

    for (var i = 0; i < sortedKeys.length; i++) {
      double s = double.parse(sortedKeys[i].toString());
      if (sortedKeys[i] >= current) {
        current = s;
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
        Flexible(
          child: Column(
            children: widget.children.map((element) {
              int index = widget.children.indexOf(element);
              return Container(
                margin: EdgeInsets.fromLTRB(3, 3, 10, 3),
                width: double.infinity,
                child: LinearPercentIndicator(
                    animation: true,
                    lineHeight: 38.0,
                    animationDuration: 500,
                    percent: PollMath.getPerc(valueList, index + 1),
                    center: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(choiceList[index],
                                style: this.highest == valueList[index]
                                    ? widget.leadingPollStyle
                                    : widget.pollStyle),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                        Text(
                            PollMath.getMainPerc(
                                valueList,
                                        index + 1)
                                    .toString() +
                                "%",
                            style: this.highest == valueList[index]
                                ? widget.leadingPollStyle
                                : widget.pollStyle)
                      ],
                    ),
                    barRadius: Radius.circular(widget.barRadius),
                    progressColor: this.highest == valueList[index]
                        ? widget.leadingBackgroundColor
                        : widget.onVoteBackgroundColor),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  /// voteCasted created view for user to see votes they casted including other peoples vote
  Widget voteCasted(context) {
    /// Fix by AksharPrasanna
    // this.v1 = widget.children[0][1];
    // this.v2 = widget.children[1][1];
    // if (this.c3 != null) this.v3 = widget.children[2][1];
    // if (this.c4 != null) this.v4 = widget.children[3][1];
    // if (this.c5 != null) this.v5 = widget.children[4][1];
    // if (this.c6 != null) this.v6 = widget.children[5][1];
    // if (this.c7 != null) this.v7 = widget.children[6][1];
    // if (this.c8 != null) this.v8 = widget.children[7][1];

    var sortedKeys = valueList;
    //sort valueList
    sortedKeys.sort((a, b) => a.compareTo(b));

    double current = 0;

    for (var i = 0; i < sortedKeys.length; i++) {
      double s = double.parse(sortedKeys[i].toString());
      if (sortedKeys[i]>= current) {
        current = s;
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
        Flexible(
          child: Column(
            children: widget.children.map((element) {
              int index = widget.children.indexOf(element);
              return Container(
                margin: EdgeInsets.fromLTRB(3, 3, 10, 3),
                width: double.infinity,
                child: LinearPercentIndicator(
                  animation: true,
                  lineHeight: 38.0,
                  animationDuration: 500,
                  percent: PollMath.getPerc(valueList, index + 1),
                  center: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(choiceList[index].toString(),
                              style: this.highest == valueList[index]
                                  ? widget.leadingPollStyle
                                  : widget.pollStyle),
                          SizedBox(
                            width: 10,
                          ),
                          myOwnChoice(widget.userChoice, index + 1)
                        ],
                      ),
                      Text(
                          PollMath.getMainPerc(
                                      valueList,
                                      index + 1)
                                  .toString() +
                              "%",
                          style: this.highest == valueList[index]
                              ? widget.leadingPollStyle
                              : widget.pollStyle)
                    ],
                  ),
                  barRadius: Radius.circular(widget.barRadius),
                  progressColor: this.highest == valueList[index]
                      ? widget.leadingBackgroundColor
                      : widget.onVoteBackgroundColor,
                ),
              );
            }).toList(),
          ),
        )
      ],
    );
  }
}
