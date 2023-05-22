part of 'study_plans_bloc.dart';

@immutable
abstract class StudyPlansState {}

class StudyPlansInitialState extends StudyPlansState {
  final bool isEmptyFields;
  final String recordBookId;

  StudyPlansInitialState({
    this.isEmptyFields = false,
    required this.recordBookId,
  });

  StudyPlansInitialState copyWith({
    bool? isEmptyFields,
    String? recordBookId,
  }) {
    return StudyPlansInitialState(
      isEmptyFields: isEmptyFields ?? this.isEmptyFields,
      recordBookId: recordBookId ?? this.recordBookId,
    );
  }
}

class StudyPlansInProgressState extends StudyPlansState {}

class StudyPlansSuccessState extends StudyPlansState {
  final List<StudyPlanModel> studyPlans;

  StudyPlansSuccessState(this.studyPlans);
}

class StudyPlansErrorState extends StudyPlansState {}
