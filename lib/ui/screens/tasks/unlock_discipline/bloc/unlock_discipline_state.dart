part of 'unlock_discipline_bloc.dart';

@immutable
abstract class UnlockDisciplineState {}

class UnlockDisciplineInitialState extends UnlockDisciplineState {
  final bool isEmptyFields;
  final String id;

  UnlockDisciplineInitialState({required this.id, this.isEmptyFields = false});
}

class UnlockDisciplineInProgressState extends UnlockDisciplineState {}

class UnlockDisciplineSuccessState extends UnlockDisciplineState {
  final int rowCount;

  UnlockDisciplineSuccessState(this.rowCount);
}

class UnlockDisciplineErrorState extends UnlockDisciplineState {
  final String error;

  UnlockDisciplineErrorState(this.error);
}
