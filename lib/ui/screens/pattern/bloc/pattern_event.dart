part of 'pattern_bloc.dart';

@immutable
abstract class PatternEvent {}

class PatternPerformEvent implements PatternEvent {
  final String functionName;
  final List<String> parameters;
  final List<String> values;

  PatternPerformEvent({
    required this.parameters,
    required this.values,
    required this.functionName,
  });
}

class PatternOpenInitialEvent implements PatternEvent {}
