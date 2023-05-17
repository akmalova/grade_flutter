import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grade/domain/repository/grade_repository.dart';
import 'package:postgres/postgres.dart';

part 'edit_study_plan_event.dart';
part 'edit_study_plan_state.dart';

class EditStudyPlanBloc extends Bloc<EditStudyPlanEvent, EditStudyPlanState> {
  final GradeRepository gradeRepository;

  EditStudyPlanBloc(this.gradeRepository)
      : super(
          EditPlanInitialState(
            recordBookId: '',
            studyPlanIdFrom: '',
            studyPlanIdTo: '',
            year: '',
          ),
        ) {
    on<EditPlanPerformEvent>(_perform);
    on<EditPlanOpenInitialEvent>(_openInitial);
    on<EditPlanRecordBookChangedEvent>(_recordBookChanged);
    on<EditPlanStudyPlanFromChangedEvent>(_studyPlanFromChanged);
    on<EditPlanStudyPlanToChangedEvent>(_studyPlanToChanged);
    on<EditPlanYearChangedEvent>(_yearChanged);
  }

  Future<void> _perform(EditPlanPerformEvent event, Emitter emit) async {
    try {
      final previousState = state as EditPlanInitialState;
      emit(EditPlanInProgressState());
      if (previousState.recordBookId.isEmpty ||
          previousState.studyPlanIdFrom.isEmpty ||
          previousState.studyPlanIdTo.isEmpty ||
          previousState.year.isEmpty) {
        emit(previousState.copyWith(isEmptyFields: true));
      } else {
        final result = await gradeRepository.editStudyPlan(
          previousState.recordBookId,
          previousState.studyPlanIdFrom,
          previousState.studyPlanIdTo,
          previousState.year,
        );
        if (result != -1) {
          emit(EditPlanSuccessState());
        } else {
          emit(EditPlanErrorState());
        }
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
