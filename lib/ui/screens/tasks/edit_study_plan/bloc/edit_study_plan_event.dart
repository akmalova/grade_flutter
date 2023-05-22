part of 'edit_study_plan_bloc.dart';

@immutable
abstract class EditStudyPlanEvent {}

class EditPlanPerformEvent implements EditStudyPlanEvent {}

class EditPlanOpenInitialEvent implements EditStudyPlanEvent {}

class EditPlanRecordBookChangedEvent implements EditStudyPlanEvent {
  final String recordBookId;

  EditPlanRecordBookChangedEvent(this.recordBookId);
}

class EditPlanStudyPlanToChangedEvent implements EditStudyPlanEvent {
  final String studyPlanIdTo;

  EditPlanStudyPlanToChangedEvent(this.studyPlanIdTo);
}

class EditPlanStudyPlanFromChangedEvent implements EditStudyPlanEvent {
  final String studyPlanIdFrom;

  EditPlanStudyPlanFromChangedEvent(this.studyPlanIdFrom);
}

class EditPlanYearChangedEvent implements EditStudyPlanEvent {
  final String year;

  EditPlanYearChangedEvent(this.year);
}
