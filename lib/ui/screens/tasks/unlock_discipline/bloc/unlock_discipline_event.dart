part of 'unlock_discipline_bloc.dart';

@immutable
abstract class UnlockDisciplineEvent {}

class UnlockDisciplinePerformEvent implements UnlockDisciplineEvent {}

class UnlockDisciplineOpenInitialEvent implements UnlockDisciplineEvent {}

class UnlockDisciplineIdChangedEvent implements UnlockDisciplineEvent {
  final String id;

  UnlockDisciplineIdChangedEvent(this.id);
}
