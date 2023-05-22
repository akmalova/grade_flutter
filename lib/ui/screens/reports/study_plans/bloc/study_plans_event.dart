part of 'study_plans_bloc.dart';

@immutable
abstract class StudyPlansEvent {}

class StudyPlansPerformEvent implements StudyPlansEvent {}

class StudyPlansOpenInitialEvent implements StudyPlansEvent {}

class StudyPlansRecordBookChangedEvent implements StudyPlansEvent {
  final String recordBookId;

  StudyPlansRecordBookChangedEvent(this.recordBookId);
}
