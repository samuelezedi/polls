library polls;

import 'package:logger/logger.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter/material.dart';
import 'package:polls/src/poll_methods.dart';
import 'package:polls/src/widgets/global.dart';
import 'package:equatable/equatable.dart';

part 'src/poll_options_model.dart';
part 'src/declarations.dart';
part 'src/poll_enums.dart';
part 'src/poll_controller.dart';


class Polls extends StatefulWidget {
  /// Polls contruct by default get view for voting
  Polls({
    required this.children,
    required this.question,
    required this.voteData,
    required this.currentUser,
    required this.creatorID,
    this.controller,
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
    this.userChoiceIcon,
  });

  /// this takes the question on the poll
  final Text question;

  ///this determines what type of view user should see
  ///if its creator, or view requiring you to vote or view showing your vote
  final PollType? viewType;

  final PollController? controller;

  ///this takes in vote data which should be a Map
  /// with this, polls widget determines what type of view the user should see
  final Map? voteData;

  final String? currentUser;

  final String? creatorID;

  /// this takes in poll options array
  List<PollOption> children;

  /// this call back returns user choice after voting
  final PollCallBack? onVote;

  /// this is takes in current user choice
  final int? userChoice;

  final Widget? userChoiceIcon;

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
  var logger = Logger();
  PollController? _controller;
  late int _userPollChoice;

  var choiceList = <String>[];
  var userChoiceList = <String>[];
  var valueList = <double>[];
  var userValueList = <double>[];

  /// style
  late TextStyle pollStyle;
  late TextStyle leadingPollStyle;

  ///colors setting for polls widget
  Color? outlineColor;
  Color? backgroundColor;
  Color? onVoteBackgroundColor;
  Color? iconColor;
  Color? leadingBackgroundColor;

  double highest = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller = widget.controller;
    if (_controller == null) _controller = PollController();
    _controller!.children = widget.children;

    _controller?.addListener(() {
      if (_controller!.makeChange) {
        _updateView();
      }
    });

    _reCalibrate();
  }

  void _updateView() {
    widget.children = _controller!.children;
    _controller!.revertChangeBoolean();
    _reCalibrate();
    setState(() {});
  }

  void _reCalibrate() {
    choiceList.clear();
    userChoiceList.clear();
    valueList.clear();

    /// if polls style is null, it sets default pollstyle and leading pollstyle
    this.pollStyle = widget.pollStyle ??
        TextStyle(color: Colors.black, fontWeight: FontWeight.w300);
    this.leadingPollStyle = widget.leadingPollStyle ??
        TextStyle(color: Colors.black, fontWeight: FontWeight.w800);

    widget.children.map((e) {
      choiceList.add(e.option);
      userChoiceList.add(e.option);
      valueList.add(e.value);
    }).toList();

    logger.i(widget.children);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.viewType == null) {
      PollType viewType =
          (widget.voteData?.containsKey(widget.currentUser) ?? false)
              ? PollType.readOnly
              : widget.currentUser == widget.creatorID
                  ? PollType.creator
                  : PollType.voter;
      if (viewType == PollType.voter) {
        //user can cast vote with this widget
        return voterWidget(context);
      }
      if (viewType == PollType.creator) {
        //mean this is the creator of the polls and cannot vote
        if (widget.allowCreatorVote) {
          return voterWidget(context);
        }
        return pollCreator(context);
      }

      if (viewType == PollType.readOnly) {
        //user can view his votes with this widget
        return voteCasted(context);
      }
    } else {
      if (widget.viewType == PollType.voter) {
        //user can cast vote with this widget
        return voterWidget(context);
      }
      if (widget.viewType == PollType.creator) {
        //mean this is the creator of the polls and cannot vote
        if (widget.allowCreatorVote) {
          return voterWidget(context);
        }
        return pollCreator(context);
      }

      if (widget.viewType == PollType.readOnly) {
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
                      _controller!.updatePollOption(index);
                      widget.getTotal!(PollMethods.getTotalVotes(valueList).toStringAsFixed(1));
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
    var sortedKeys = <double>[];

    valueList.map((e) {
      sortedKeys.add(e);
    }).toList();

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
    widget.getHighest!(highest.toStringAsFixed(1));

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
                    percent:
                        PollMethods.getViewPercentage(valueList, index + 1, 1),
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
                            PollMethods.getViewPercentage(
                                        valueList, index + 1, 100)
                                    .toStringAsFixed(1) +
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

    var sortedKeys = <double>[];

    valueList.map((e) {
      sortedKeys.add(e);
    }).toList();

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
    widget.getHighest!(highest.toStringAsFixed(1));
    
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
                  percent:
                      PollMethods.getViewPercentage(valueList, index + 1, 1),
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
                          myOwnChoice(widget.userChoice, index + 1, widget.userChoiceIcon??Icon(
                            Icons.check_circle_outline,
                            color: Colors.white,
                            size: 17,
                          ))
                        ],
                      ),
                      Text(
                          PollMethods.getViewPercentage(
                                      valueList, index + 1, 100)
                                  .toStringAsFixed(1) +
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
