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

// ignore: must_be_immutable
class Polls extends StatefulWidget {
  Polls(
      {required this.children,
      required this.question,
      this.hasVoted,
      this.userId,
      this.controller,
      this.onVote,
      this.outlineColor = Colors.blue,
      this.backgroundColor = Colors.blueGrey,
      this.onVoteBackgroundColor = Colors.blue,
      this.leadingPollStyle,
      this.pollStyle,
      this.iconColor = Colors.black,
      this.leadingBackgroundColor = Colors.blueGrey,
      this.getHighest,
      this.barRadius = 10,
      this.userChoiceIcon,
      this.showLogger = true,
      Key? key})
      : super(key: key);

  final String? userId;
  final double barRadius;

  final Text question;
  final Widget? userChoiceIcon;

  final bool? hasVoted;
  final bool showLogger;

  final PollHighest? getHighest;
  final PollOnVote? onVote;
  List<PollOption> children;
  final PollController? controller;

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
  int? _userPollChoice;

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

  bool hasVoted = false;

  @override
  void initState() {
    super.initState();

    _controller = widget.controller;
    if (_controller == null) _controller = PollController();
    _controller!.children = widget.children;
    hasVoted = widget.hasVoted ?? _controller!.hasVoted;

    _controller?.addListener(() {
      if (_controller!.makeChange) {
        hasVoted = _controller!.hasVoted;
        _updateView();
      }
    });

    _reCalibrate();
  }

  void _updateView() {
    widget.children = _controller!.children;
    _controller!.revertChangeBoolean();
    _reCalibrate();
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

    if (widget.showLogger) logger.i([widget.question, widget.children]);
  }

  @override
  Widget build(BuildContext context) {
    if (!hasVoted) {
      //user can cast vote with this widget
      return voterWidget(context);
    } else {
      //user can view his votes with this widget
      return voteCasted(context);
    }
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
        Column(
          children: widget.children.map((element) {
            int index = widget.children.indexOf(element);
            return Container(
              width: double.infinity,
              padding: EdgeInsets.only(bottom: 10),
              child: Container(
                margin: EdgeInsets.all(0),
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(0),
                height: 38,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: widget.backgroundColor,
                ),
                child: OutlinedButton(
                  onPressed: () {
                    setState(() {
                      _userPollChoice = index;
                    });
                    _controller!.updatePollOption(index);
                    double total = PollMethods.getTotalVotes(valueList);
                    print('here');
                    print(widget.children);
                    widget.onVote!(widget.children[index], index + 1, total);
                  },
                  style: OutlinedButton.styleFrom(
                    primary: widget.outlineColor,
                    padding: EdgeInsets.all(5.0),
                    side: BorderSide(
                      color: widget.outlineColor,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(widget.barRadius),
                    ),
                  ),
                  child: Text(element.option, style: widget.pollStyle),
                ),
              ),
            );
          }).toList(),
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
        Column(
          children: widget.children.map((element) {
            int index = widget.children.indexOf(element);
            return Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              width: double.infinity,
              child: LinearPercentIndicator(
                padding: EdgeInsets.zero,
                animation: true,
                lineHeight: 38.0,
                animationDuration: 500,
                percent: PollMethods.getViewPercentage(valueList, index + 1, 1),
                center: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
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
                          userChoice(
                              _userPollChoice,
                              index + 1,
                              widget.userChoiceIcon ??
                                  Icon(
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
                ),
                barRadius: Radius.circular(widget.barRadius),
                progressColor: this.highest == valueList[index]
                    ? widget.leadingBackgroundColor
                    : widget.onVoteBackgroundColor,
              ),
            );
          }).toList(),
        )
      ],
    );
  }
}
