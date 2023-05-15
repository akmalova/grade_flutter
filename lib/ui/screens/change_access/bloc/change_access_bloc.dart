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
        emit(
          ChangeAccessInitialState(
            isEmptyFields: true,
            lastName: previuosState.lastName,
            firstName: previuosState.firstName,
            secondName: previuosState.secondName,
            userRole: previuosState.userRole,
          ),
        );
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
      await gradeRepository.changeAccess(event.id, userRole);
      emit(ChangeAccessSuccessState());
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
    emit(
      ChangeAccessInitialState(
        lastName: event.lastName,
        firstName: previuosState.firstName,
        secondName: previuosState.secondName,
        userRole: previuosState.userRole,
      ),
    );
  }

  void _firstNameChanged(
      ChangeAccessFirstNameChangedEvent event, Emitter emit) async {
    final previuosState = state as ChangeAccessInitialState;
    emit(ChangeAccessInitialState(
      lastName: previuosState.lastName,
      firstName: event.firstName,
      secondName: previuosState.secondName,
      userRole: previuosState.userRole,
    ));
  }

  void _secondNameChanged(
      ChangeAccessSecondNameChangedEvent event, Emitter emit) async {
    final previuosState = state as ChangeAccessInitialState;
    emit(
      ChangeAccessInitialState(
        lastName: previuosState.lastName,
        firstName: previuosState.firstName,
        secondName: event.secondName,
        userRole: previuosState.userRole,
      ),
    );
  }

  void _userRoleChanged(
      ChangeAccessUserRoleChangedEvent event, Emitter emit) async {
    final previuosState = state as ChangeAccessInitialState;
    emit(
      ChangeAccessInitialState(
        lastName: previuosState.lastName,
        firstName: previuosState.firstName,
        secondName: previuosState.secondName,
        userRole: event.userRole,
      ),
    );
  }
}
