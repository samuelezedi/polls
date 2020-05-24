
/// does the maths for Polls
class PollMath {

  getMainPerc(v1,v2,v3,v4, choice) {
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

  List getPerc(v1,v2,v3,v4, choice) {
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
