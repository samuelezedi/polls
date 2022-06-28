part of '../polls.dart';

class PollOption extends Equatable {
  String option;
  double value;

  PollOption({required this.option, required this.value});

  @override
  List<Object?> get props => [
    option,
    value,
  ];

}