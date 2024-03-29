import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grade/domain/model/teacher_model.dart';
import 'package:grade/domain/repository/grade_repository.dart';

part 'change_access_event.dart';
part 'change_access_state.dart';

class ChangeAccessBloc extends Bloc<ChangeAccessEvent, ChangeAccessState> {
  final GradeRepository gradeRepository;
  late String userRole;

  ChangeAccessBloc(this.gradeRepository)
      : super(
          ChangeAccessInitialState(
            lastName: '',
            firstName: '',
            secondName: '',
            userRole: '2',
          ),
        ) {
    on<ChangeAccessGetTeachersEvent>(_getTeachers);
    on<ChangeAccessPerformEvent>(_perform);
    on<ChangeAccessOpenInitialEvent>(_openInitial);
    on<ChangeAccessLastNameChangedEvent>(_lastNameChanged);
    on<ChangeAccessFirstNameChangedEvent>(_firstNameChanged);
    on<ChangeAccessSecondNameChangedEvent>(_secondNameChanged);
    on<ChangeAccessUserRoleChangedEvent>(_userRoleChanged);
  }

  Future<void> _getTeachers(
      ChangeAccessGetTeachersEvent event, Emitter emit) async {
    try {
      final previuosState = state as ChangeAccessInitialState;
      emit(ChangeAccessInProgressState());
      if (previuosState.lastName.isEmpty &&
          previuosState.firstName.isEmpty &&
          previuosState.secondName.isEmpty) {
        emit(previuosState.copyWith(isEmptyFields: true));
      } else {
        userRole = previuosState.userRole;
        final result = await gradeRepository.getTeachers(
          previuosState.lastName,
          previuosState.firstName,
          previuosState.secondName,
        );
        if (result.isNotEmpty) {
          emit(ChangeAccessGetTeachersSuccessState(result));
        } else {
          emit(ChangeAccessTeachersNotFoundState());
        }
      }
    } catch (e) {
      List<int> bytes = e.toString().codeUnits;
      String error = utf8.decode(bytes);
      debugPrint(error);
      emit(ChangeAccessErrorState(error));
    }
  }

  Future<void> _perform(ChangeAccessPerformEvent event, Emitter emit) async {
    try {
      emit(ChangeAccessInProgressState());
      await gradeRepository.changeAccess(event.id, userRole);
      emit(ChangeAccessSuccessState());
    } catch (e) {
      List<int> bytes = e.toString().codeUnits;
      String error = utf8.decode(bytes);
      debugPrint(error);
      emit(ChangeAccessErrorState(error));
    }
  }

  void _openInitial(ChangeAccessOpenInitialEvent event, Emitter emit) async {
    emit(
      ChangeAccessInitialState(
        lastName: '',
        firstName: '',
        secondName: '',
        userRole: '2',
      ),
    );
  }

  void _lastNameChanged(
      ChangeAccessLastNameChangedEvent event, Emitter emit) async {
    final previuosState = state as ChangeAccessInitialState;
    emit(previuosState.copyWith(lastName: event.lastName));
  }

  void _firstNameChanged(
      ChangeAccessFirstNameChangedEvent event, Emitter emit) async {
    final previuosState = state as ChangeAccessInitialState;
    emit(previuosState.copyWith(firstName: event.firstName));
  }

  void _secondNameChanged(
      ChangeAccessSecondNameChangedEvent event, Emitter emit) async {
    final previuosState = state as ChangeAccessInitialState;
    emit(previuosState.copyWith(secondName: event.secondName));
  }

  void _userRoleChanged(
      ChangeAccessUserRoleChangedEvent event, Emitter emit) async {
    final previuosState = state as ChangeAccessInitialState;
    emit(previuosState.copyWith(userRole: event.userRole));
  }
}
