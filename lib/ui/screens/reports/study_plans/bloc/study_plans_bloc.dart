import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grade/domain/model/study_plan_model.dart';
import 'package:grade/domain/repository/grade_repository.dart';

part 'study_plans_event.dart';
part 'study_plans_state.dart';

class StudyPlansBloc extends Bloc<StudyPlansEvent, StudyPlansState> {
  final GradeRepository gradeRepository;

  StudyPlansBloc(this.gradeRepository)
      : super(StudyPlansInitialState(recordBookId: '')) {
    on<StudyPlansPerformEvent>(_perform);
    on<StudyPlansOpenInitialEvent>(_openInitial);
    on<StudyPlansRecordBookChangedEvent>(_recordBookChanged);
  }

  Future<void> _perform(StudyPlansPerformEvent event, Emitter emit) async {
    try {
      final previousState = state as StudyPlansInitialState;
      emit(StudyPlansInProgressState());

      if (previousState.recordBookId.isEmpty) {
        emit(previousState.copyWith(isEmptyFields: true));
      } else {
        final result = await gradeRepository.getPlans(
          previousState.recordBookId,
        );
        if (result.isNotEmpty) {
          emit(StudyPlansSuccessState(result));
        } else {
          emit(StudyPlansNotFoundState());
        }
      }
    } catch (e) {
      List<int> bytes = e.toString().codeUnits;
      String error = utf8.decode(bytes);
      debugPrint(error);
      emit(StudyPlansErrorState(error));
    }
  }

  void _openInitial(StudyPlansOpenInitialEvent event, Emitter emit) {
    emit(StudyPlansInitialState(recordBookId: ''));
  }

  void _recordBookChanged(
      StudyPlansRecordBookChangedEvent event, Emitter emit) async {
    final previuosState = state as StudyPlansInitialState;
    emit(previuosState.copyWith(recordBookId: event.recordBookId));
  }
}
