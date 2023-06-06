part of 'teacher_info_bloc.dart';

@immutable
abstract class TeacherInfoEvent {}

class TeacherInfoGetTeachersEvent implements TeacherInfoEvent {}

class TeacherInfoOpenInitialEvent implements TeacherInfoEvent {}

class TeacherInfoLastNameChangedEvent implements TeacherInfoEvent {
  final String lastName;

  TeacherInfoLastNameChangedEvent(this.lastName);
}

class TeacherInfoFirstNameChangedEvent implements TeacherInfoEvent {
  final String firstName;

  TeacherInfoFirstNameChangedEvent(this.firstName);
}

class TeacherInfoSecondNameChangedEvent implements TeacherInfoEvent {
  final String secondName;

  TeacherInfoSecondNameChangedEvent(this.secondName);
}
