import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grade/domain/model/study_plan_model.dart';
import 'package:grade/domain/repository/grade_repository.dart';
import 'package:postgres/postgres.dart';

part 'edit_study_plan_event.dart';
part 'edit_study_plan_state.dart';

class EditStudyPlanBloc extends Bloc<EditStudyPlanEvent, EditStudyPlanState> {
  final GradeRepository gradeRepository;
  late String recordBookId;
  late String studyPlanIdFrom;
  late String studyPlanIdTo;
  late String year;

  EditStudyPlanBloc(this.gradeRepository)
      : super(
          EditPlanInitialState(
            recordBookId: '',
            studyPlanIdFrom: '',
            studyPlanIdTo: '',
            year: '',
          ),
        ) {
    on<EditPlanGetPlansEvent>(_getPlans);
    on<EditPlanPerformEvent>(_perform);
    on<EditPlanOpenInitialEvent>(_openInitial);
    on<EditPlanRecordBookChangedEvent>(_recordBookChanged);
    on<EditPlanStudyPlanFromChangedEvent>(_studyPlanFromChanged);
    on<EditPlanStudyPlanToChangedEvent>(_studyPlanToChanged);
    on<EditPlanYearChangedEvent>(_yearChanged);
  }

  Future<void> _getPlans(EditPlanGetPlansEvent event, Emitter emit) async {
    try {
      final previousState = state as EditPlanInitialState;
      emit(EditPlanInProgressState());

      if (previousState.recordBookId.isEmpty ||
          previousState.studyPlanIdFrom.isEmpty ||
          previousState.studyPlanIdTo.isEmpty ||
          previousState.year.isEmpty) {
        emit(previousState.copyWith(isEmptyFields: true));
      } else {
        recordBookId = previousState.recordBookId;
        studyPlanIdFrom = previousState.studyPlanIdFrom;
        studyPlanIdTo = previousState.studyPlanIdTo;
        year = previousState.year;

        final result = await gradeRepository.getPlans(
          previousState.recordBookId,
        );
        if (result.isNotEmpty) {
          emit(EditPlanGetPlansSuccessState(result));
        } else {
          emit(EditPlanPlansNotFoundState());
        }
      }
    } on PostgreSQLException catch (e) {
      emit(EditPlanErrorState());
      debugPrint(e.toString());
    }
  }

  Future<void> _perform(EditPlanPerformEvent event, Emitter emit) async {
    try {
      emit(EditPlanInProgressState());

      final result = await gradeRepository.editStudyPlan(
        recordBookId,
        studyPlanIdFrom,
        studyPlanIdTo,
        year,
      );
      
      if (result != -1) {
        emit(EditPlanSuccessState());
      } else {
        emit(EditPlanErrorState());
      }
    } on PostgreSQLException catch (e) {
      emit(EditPlanErrorState());
      debugPrint(e.toString());
    }
  }

  void _openInitial(EditPlanOpenInitialEvent event, Emitter emit) {
    emit(
      EditPlanInitialState(
        recordBookId: '',
        studyPlanIdFrom: '',
        studyPlanIdTo: '',
        year: '',
      ),
    );
  }

  void _recordBookChanged(
      EditPlanRecordBookChangedEvent event, Emitter emit) async {
    final previuosState = state as EditPlanInitialState;
    emit(previuosState.copyWith(recordBookId: event.recordBookId));
  }

  void _studyPlanFromChanged(
      EditPlanStudyPlanFromChangedEvent event, Emitter emit) async {
    final previuosState = state as EditPlanInitialState;
    emit(previuosState.copyWith(studyPlanIdFrom: event.studyPlanIdFrom));
  }

  void _studyPlanToChanged(
      EditPlanStudyPlanToChangedEvent event, Emitter emit) async {
    final previuosState = state as EditPlanInitialState;
    emit(previuosState.copyWith(studyPlanIdTo: event.studyPlanIdTo));
  }

  void _yearChanged(EditPlanYearChangedEvent event, Emitter emit) async {
    final previuosState = state as EditPlanInitialState;
    emit(previuosState.copyWith(year: event.year));
  }
}
