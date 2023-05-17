import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grade/domain/model/teacher_model.dart';
import 'package:grade/domain/repository/grade_repository.dart';
import 'package:postgres/postgres.dart';

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
            userRole: '',
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
      if (previuosState.lastName.isEmpty ||
          previuosState.firstName.isEmpty ||
          previuosState.secondName.isEmpty ||
          previuosState.userRole.isEmpty) {
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
    } on PostgreSQLException catch (e) {
      emit(ChangeAccessErrorState());
      debugPrint(e.toString());
    }
  }

  Future<void> _perform(ChangeAccessPerformEvent event, Emitter emit) async {
    try {
      emit(ChangeAccessInProgressState());
      final result = await gradeRepository.changeAccess(event.id, userRole);
      
      if (result != -1) {
        emit(ChangeAccessSuccessState());
      } else {
        emit(ChangeAccessErrorState());
      }
    } on PostgreSQLException catch (e) {
      emit(ChangeAccessErrorState());
      debugPrint(e.toString());
    }
  }

  void _openInitial(ChangeAccessOpenInitialEvent event, Emitter emit) async {
    emit(
      ChangeAccessInitialState(
        lastName: '',
        firstName: '',
        secondName: '',
        userRole: '',
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
