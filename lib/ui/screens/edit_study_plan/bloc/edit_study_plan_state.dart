// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'edit_study_plan_bloc.dart';

@immutable
abstract class EditStudyPlanState {}

class EditPlanInitialState extends EditStudyPlanState {
  final bool isEmptyFields;
  final String recordBookId;
  final String studyPlanIdFrom;
  final String studyPlanIdTo;
  final String year;

  EditPlanInitialState({
    this.isEmptyFields = false,
    required this.recordBookId,
    required this.studyPlanIdFrom,
    required this.studyPlanIdTo,
    required this.year,
  });

  EditPlanInitialState copyWith({
    bool? isEmptyFields,
    String? recordBookId,
    String? studyPlanIdFrom,
    String? studyPlanIdTo,
    String? year,
  }) {
    return EditPlanInitialState(
      isEmptyFields: isEmptyFields ?? this.isEmptyFields,
      recordBookId: recordBookId ?? this.recordBookId,
      studyPlanIdFrom: studyPlanIdFrom ?? this.studyPlanIdFrom,
      studyPlanIdTo: studyPlanIdTo ?? this.studyPlanIdTo,
      year: year ?? this.year,
    );
  }
}

class EditPlanInProgressState extends EditStudyPlanState {}

class EditPlanSuccessState extends EditStudyPlanState {}

class EditPlanErrorState extends EditStudyPlanState {}
