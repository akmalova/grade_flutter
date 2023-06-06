part of 'teacher_info_bloc.dart';

@immutable
abstract class TeacherInfoState {}

class TeacherInfoInitialState extends TeacherInfoState {
  final bool isEmptyFields;
  final String lastName;
  final String firstName;
  final String secondName;

  TeacherInfoInitialState({
    this.isEmptyFields = false,
    required this.lastName,
    required this.firstName,
    required this.secondName,
  });

  TeacherInfoInitialState copyWith({
    bool? isEmptyFields,
    String? lastName,
    String? firstName,
    String? secondName,
  }) {
    return TeacherInfoInitialState(
      isEmptyFields: isEmptyFields ?? this.isEmptyFields,
      lastName: lastName ?? this.lastName,
      firstName: firstName ?? this.firstName,
      secondName: secondName ?? this.secondName,
    );
  }
}

class TeacherInfoGetTeachersSuccessState extends TeacherInfoState {
  final List<TeacherModel> teachers;

  TeacherInfoGetTeachersSuccessState(this.teachers);
}

class TeacherInfoInProgressState extends TeacherInfoState {}

class TeacherInfoErrorState extends TeacherInfoState {}

class TeacherInfoTeachersNotFoundState extends TeacherInfoState {}

