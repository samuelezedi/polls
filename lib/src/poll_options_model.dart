part of '../polls.dart';

class PollOption extends Equatable {
  final String option;
  final double value;

  PollOption({required this.option, required this.value});

  @override
  List<Object?> get props => [
    option,
    value,
  ];

}