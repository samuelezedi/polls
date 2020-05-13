
class Type {
  const Type(this.value);

  static  const CREATOR = 1;
  static  const NOT_VOTED = 2;
  static const  VOTED = 3;

  /// All the possible values for the [Type] enumeration.
  static List<int> get values => [CREATOR, NOT_VOTED, VOTED];

  final dynamic value;
}