/// does the maths for Polls
class PollMath {
  static double getMainPerc(List<double> valueList, choice) {
    double div = 0.0;
    var slot = <double>[];

    valueList.map((element) {
      slot.add(element);
    }).toList();

    valueList.map((element){
      int index = valueList.indexOf(element);
      double sum = slot.map((value) => value).fold(0, (a, b) => a + b);
      div = sum == 0 ? 0.0 : (100 / sum) * slot[index];
    }).toList();
    return div;
  }

  static double getPerc(List<double> valueList, int choice) {

    double div = 0.0;
    var slot = <double>[];

    valueList.map((element) {
      slot.add(element);
    }).toList();

    valueList.map((element){
      int index = valueList.indexOf(element);
      double sum = slot.map((value) => value).fold(0, (a, b) => a + b);
      div = sum == 0 ? 0.0 : (1 / sum) * slot[index];
    }).toList();
    return div;
  }
}
