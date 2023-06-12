part of 'change_access_bloc.dart';

@immutable
abstract class ChangeAccessState {}

class ChangeAccessInitialState extends ChangeAccessState {
  final bool isEmptyFields;
  final String lastName;
  final String firstName;
  final String secondName;
  final String userRole;

  ChangeAccessInitialState({
    this.isEmptyFields = false,
    required this.lastName,
    required this.firstName,
    required this.secondName,
    required this.userRole,
  });

  ChangeAccessInitialState copyWith({
    bool? isEmptyFields,
    String? lastName,
    String? firstName,
    String? secondName,
    String? userRole,
  }) {
    return ChangeAccessInitialState(
      isEmptyFields: isEmptyFields ?? this.isEmptyFields,
      lastName: lastName ?? this.lastName,
      firstName: firstName ?? this.firstName,
      secondName: secondName ?? this.secondName,
      userRole: userRole ?? this.userRole,
    );
  }
}

class ChangeAccessGetTeachersSuccessState extends ChangeAccessState {
  final List<TeacherModel> teachers;

  ChangeAccessGetTeachersSuccessState(this.teachers);
}

class ChangeAccessInProgressState extends ChangeAccessState {}

class ChangeAccessSuccessState extends ChangeAccessState {}

class ChangeAccessErrorState extends ChangeAccessState {
  final String error;

  ChangeAccessErrorState(this.error);
}

class ChangeAccessTeachersNotFoundState extends ChangeAccessState {}
