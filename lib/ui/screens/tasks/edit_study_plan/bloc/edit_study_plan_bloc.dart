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
      final previuosState = state as EditPlanInitialState;
      emit(EditPlanInProgressState());
      if (previuosState.recordBookId.isEmpty ||
          previuosState.studyPlanIdFrom.isEmpty ||
          previuosState.studyPlanIdTo.isEmpty ||
          previuosState.year.isEmpty) {
        emit(previuosState.copyWith(isEmptyFields: true));
      } else {
        await gradeRepository.editStudyPlan(
          previuosState.recordBookId,
          previuosState.studyPlanIdFrom,
          previuosState.studyPlanIdTo,
          previuosState.year,
        );
        emit(EditPlanSuccessState());
      }
    } catch (e) {
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
