part of 'change_access_bloc.dart';

@immutable
abstract class ChangeAccessEvent {}

class ChangeAccessGetTeachersEvent implements ChangeAccessEvent {}

class ChangeAccessPerformEvent implements ChangeAccessEvent {
  final int id;

  ChangeAccessPerformEvent(this.id);
}

class ChangeAccessOpenInitialEvent implements ChangeAccessEvent {}

class ChangeAccessLastNameChangedEvent implements ChangeAccessEvent {
  final String lastName;

  ChangeAccessLastNameChangedEvent(this.lastName);
}

class ChangeAccessFirstNameChangedEvent implements ChangeAccessEvent {
  final String firstName;

  ChangeAccessFirstNameChangedEvent(this.firstName);
}

class ChangeAccessSecondNameChangedEvent implements ChangeAccessEvent {
  final String secondName;

  ChangeAccessSecondNameChangedEvent(this.secondName);
}

class ChangeAccessUserRoleChangedEvent implements ChangeAccessEvent {
  final String userRole;

  ChangeAccessUserRoleChangedEvent(this.userRole);
}
