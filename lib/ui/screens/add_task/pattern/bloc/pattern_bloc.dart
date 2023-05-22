import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grade/domain/repository/grade_repository.dart';
import 'package:postgres/postgres.dart';

part 'pattern_event.dart';
part 'pattern_state.dart';

class PatternBloc extends Bloc<PatternEvent, PatternState> {
  final GradeRepository gradeRepository;

  PatternBloc(this.gradeRepository) : super(PatternInitialState()) {
    on<PatternPerformEvent>(_perform);
    on<PatternOpenInitialEvent>(_openInitital);
  }

  Future<void> _perform(PatternPerformEvent event, Emitter emit) async {
    try {
      emit(PatternInProgressState());
      final result = await gradeRepository.request(
        event.functionName,
        event.parameters,
        event.values,
      );
      emit(PatternSuccessState(result));
    } on PostgreSQLException catch (e) {
      emit(PatternErrorState());
      debugPrint(e.toString());
    }
  }

  Future<void> _openInitital(
      PatternOpenInitialEvent event, Emitter emit) async {
    emit(PatternInitialState());
  }
}
