part of 'pattern_bloc.dart';

@immutable
abstract class PatternState {}

class PatternInitialState extends PatternState {}

class PatternInProgressState extends PatternState {}

class PatternSuccessState extends PatternState {
  final dynamic result;

  PatternSuccessState(this.result);
}

class PatternErrorState extends PatternState {
  final String error;

  PatternErrorState(this.error);
}
