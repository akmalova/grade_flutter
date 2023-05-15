part of 'unlock_discipline_bloc.dart';

@immutable
abstract class UnlockDisciplineEvent {}

class UnlockDisciplinePerformEvent implements UnlockDisciplineEvent {
  // final String id;

  // UnlockDisciplinePerformEvent(this.id);
}

class UnlockDisciplineOpenInitialEvent implements UnlockDisciplineEvent {}

class UnlockDisciplineIdChangedEvent implements UnlockDisciplineEvent {
  final String id;

  UnlockDisciplineIdChangedEvent(this.id);
}
