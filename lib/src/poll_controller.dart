part of '../polls.dart';

class PollController extends ChangeNotifier {
  var children = <PollOption>[];
  bool hasVoted = false;
  bool makeChange = false;

  void updatePollOption(int index) {

    if (children.isNotEmpty) {
      children[index].value += 1;
      makeChange = true;
      hasVoted = true;
    }
    notifyListeners();
  }

  void revertChangeBoolean() {
    makeChange = false;
    notifyListeners();
  }
}
