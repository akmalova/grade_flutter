part of 'transfer_teacher_data_bloc.dart';

@immutable
abstract class TransferTeacherDataEvent {}

class TransferDataPerformEvent implements TransferTeacherDataEvent {}

class TransferDataOpenInitialEvent implements TransferTeacherDataEvent {}

class TransferDataTeacherIdFromChangedEvent
    implements TransferTeacherDataEvent {
  final String teacherIdFrom;

  TransferDataTeacherIdFromChangedEvent(this.teacherIdFrom);
}

class TransferDataTeacherIdToChangedEvent implements TransferTeacherDataEvent {
  final String teacherIdTo;

  TransferDataTeacherIdToChangedEvent(this.teacherIdTo);
}
