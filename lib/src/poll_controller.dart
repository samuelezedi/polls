part of '../polls.dart';

class PollController extends ChangeNotifier {
  var children = <PollOption>[];
  bool makeChange = false;

  void updatePollOption(int index) {

    if (children.isNotEmpty) {
      children[index].value += 1;
      makeChange = true;
    }
    notifyListeners();
  }

  void revertChangeBoolean() {
    makeChange = false;
    notifyListeners();
  }
}
