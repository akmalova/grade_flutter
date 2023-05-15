import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grade/domain/repository/grade_repository.dart';
import 'package:postgres/postgres.dart';

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
    } on PostgreSQLException catch (e) {
      emit(UnlockDisciplineErrorState());
      debugPrint(e.toString());
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
