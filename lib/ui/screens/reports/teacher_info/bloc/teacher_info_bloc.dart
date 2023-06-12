import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grade/domain/model/teacher_model.dart';
import 'package:grade/domain/repository/grade_repository.dart';

part 'teacher_info_event.dart';
part 'teacher_info_state.dart';

class TeacherInfoBloc extends Bloc<TeacherInfoEvent, TeacherInfoState> {
  final GradeRepository gradeRepository;

  TeacherInfoBloc(this.gradeRepository)
      : super(
          TeacherInfoInitialState(
            lastName: '',
            firstName: '',
            secondName: '',
          ),
        ) {
    on<TeacherInfoGetTeachersEvent>(_getTeachers);
    on<TeacherInfoOpenInitialEvent>(_openInitial);
    on<TeacherInfoLastNameChangedEvent>(_lastNameChanged);
    on<TeacherInfoFirstNameChangedEvent>(_firstNameChanged);
    on<TeacherInfoSecondNameChangedEvent>(_secondNameChanged);
  }

  Future<void> _getTeachers(
      TeacherInfoGetTeachersEvent event, Emitter emit) async {
    try {
      final previuosState = state as TeacherInfoInitialState;
      emit(TeacherInfoInProgressState());
      if (previuosState.lastName.isEmpty &&
          previuosState.firstName.isEmpty &&
          previuosState.secondName.isEmpty) {
        emit(previuosState.copyWith(isEmptyFields: true));
      } else {
        final result = await gradeRepository.getTeachers(
          previuosState.lastName,
          previuosState.firstName,
          previuosState.secondName,
        );
        if (result.isNotEmpty) {
          emit(TeacherInfoGetTeachersSuccessState(result));
        } else {
          emit(TeacherInfoTeachersNotFoundState());
        }
      }
    } catch (e) {
      List<int> bytes = e.toString().codeUnits;
      String error = utf8.decode(bytes);
      debugPrint(error);
      emit(TeacherInfoErrorState(error));
    }
  }

  void _openInitial(TeacherInfoOpenInitialEvent event, Emitter emit) async {
    emit(
      TeacherInfoInitialState(
        lastName: '',
        firstName: '',
        secondName: '',
      ),
    );
  }

  void _lastNameChanged(
      TeacherInfoLastNameChangedEvent event, Emitter emit) async {
    final previuosState = state as TeacherInfoInitialState;
    emit(previuosState.copyWith(lastName: event.lastName));
  }

  void _firstNameChanged(
      TeacherInfoFirstNameChangedEvent event, Emitter emit) async {
    final previuosState = state as TeacherInfoInitialState;
    emit(previuosState.copyWith(firstName: event.firstName));
  }

  void _secondNameChanged(
      TeacherInfoSecondNameChangedEvent event, Emitter emit) async {
    final previuosState = state as TeacherInfoInitialState;
    emit(previuosState.copyWith(secondName: event.secondName));
  }
}
