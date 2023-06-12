import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grade/domain/repository/grade_repository.dart';

part 'unlock_discipline_event.dart';
part 'unlock_discipline_state.dart';

class UnlockDisciplineBloc
    extends Bloc<UnlockDisciplineEvent, UnlockDisciplineState> {
  final GradeRepository gradeRepository;

  UnlockDisciplineBloc(this.gradeRepository)
      : super(UnlockDisciplineInitialState(id: '')) {
    on<UnlockDisciplinePerformEvent>(_perform);
    on<UnlockDisciplineOpenInitialEvent>(_openInitial);
    on<UnlockDisciplineIdChangedEvent>(_idChanged);
  }

  Future<void> _perform(
      UnlockDisciplinePerformEvent event, Emitter emit) async {
    try {
      final previousState = state as UnlockDisciplineInitialState;
      emit(UnlockDisciplineInProgressState());
      if (previousState.id.isEmpty) {
        emit(
          UnlockDisciplineInitialState(
            isEmptyFields: true,
            id: previousState.id,
          ),
        );
      } else {
        final result = await gradeRepository.unlockDiscipline(previousState.id);
        emit(UnlockDisciplineSuccessState(result));
      }
    } catch (e) {
      List<int> bytes = e.toString().codeUnits;
      String error = utf8.decode(bytes);
      debugPrint(error);
      emit(UnlockDisciplineErrorState(error));
    }
  }

  void _openInitial(
      UnlockDisciplineOpenInitialEvent event, Emitter emit) async {
    emit(UnlockDisciplineInitialState(id: ''));
  }

  void _idChanged(UnlockDisciplineIdChangedEvent event, Emitter emit) async {
    emit(UnlockDisciplineInitialState(id: event.id));
  }
}
