import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grade/domain/repository/grade_repository.dart';
import 'package:postgres/postgres.dart';

part 'transfer_teacher_data_event.dart';
part 'transfer_teacher_data_state.dart';

class TransferTeacherDataBloc
    extends Bloc<TransferTeacherDataEvent, TransferTeacherDataState> {
  final GradeRepository gradeRepository;

  TransferTeacherDataBloc(this.gradeRepository)
      : super(
          TransferDataInitialState(
            teacherIdFrom: '',
            teacherIdTo: '',
          ),
        ) {
    on<TransferDataPerformEvent>(_perform);
    on<TransferDataOpenInitialEvent>(_openInitial);
    on<TransferDataTeacherIdFromChangedEvent>(_teacherIdFromChanged);
    on<TransferDataTeacherIdToChangedEvent>(_teacherIdToChanged);
  }

  Future<void> _perform(TransferDataPerformEvent event, Emitter emit) async {
    try {
      final previousState = state as TransferDataInitialState;
      emit(TransferDataInProgressState());
      if (previousState.teacherIdFrom.isEmpty ||
          previousState.teacherIdTo.isEmpty) {
        emit(previousState.copyWith(isEmptyFields: true));
      } else {
        final result = await gradeRepository.transferTeacherData(
          previousState.teacherIdFrom,
          previousState.teacherIdTo,
        );
        emit(TransferDataSuccessState(result));
      }
    } on PostgreSQLException catch (e) {
      emit(TransferDataErrorState());
      debugPrint(e.toString());
    }
  }

  void _openInitial(TransferDataOpenInitialEvent event, Emitter emit) {
    emit(
      TransferDataInitialState(
        teacherIdFrom: '',
        teacherIdTo: '',
      ),
    );
  }

  void _teacherIdFromChanged(
      TransferDataTeacherIdFromChangedEvent event, Emitter emit) async {
    final previuosState = state as TransferDataInitialState;
    emit(previuosState.copyWith(teacherIdFrom: event.teacherIdFrom));
  }

  void _teacherIdToChanged(
      TransferDataTeacherIdToChangedEvent event, Emitter emit) async {
    final previuosState = state as TransferDataInitialState;
    emit(previuosState.copyWith(teacherIdTo: event.teacherIdTo));
  }
}
