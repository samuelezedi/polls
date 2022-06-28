/// does the maths for Polls
class PollMethods {
  static double getViewPercentage(List<double> valueList, choice, int byValue) {
    double div = 0.0;
    var slot = <double>[];
    double sum = 0.0;

    valueList.map((element) {
      slot.add(element);
    }).toList();

    valueList.map((element){
      sum = slot.map((value) => value).fold(0, (a, b) => a + b);

    }).toList();
    div = sum == 0 ? 0.0 : (byValue / sum) * slot[choice-1];
    return div;
  }

  static getTotalVotes(List<double> valueList) {
    double sum = 0.0;

    sum = valueList.map((value) => value).fold(0, (a, b) => a + b);

    return sum;
  }
}
