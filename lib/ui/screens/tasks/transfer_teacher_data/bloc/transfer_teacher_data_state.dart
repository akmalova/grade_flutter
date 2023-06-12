part of 'transfer_teacher_data_bloc.dart';

@immutable
abstract class TransferTeacherDataState {}

class TransferDataInitialState extends TransferTeacherDataState {
  final bool isEmptyFields;
  final String teacherIdFrom;
  final String teacherIdTo;

  TransferDataInitialState({
    this.isEmptyFields = false,
    required this.teacherIdFrom,
    required this.teacherIdTo,
  });

  TransferDataInitialState copyWith({
    bool? isEmptyFields,
    String? teacherIdFrom,
    String? teacherIdTo,
  }) {
    return TransferDataInitialState(
      isEmptyFields: isEmptyFields ?? this.isEmptyFields,
      teacherIdFrom: teacherIdFrom ?? this.teacherIdFrom,
      teacherIdTo: teacherIdTo ?? this.teacherIdTo,
    );
  }
}

class TransferDataInProgressState extends TransferTeacherDataState {}

class TransferDataSuccessState extends TransferTeacherDataState {
  final int result;

  TransferDataSuccessState(this.result);
}

class TransferDataErrorState extends TransferTeacherDataState {
  final String error;

  TransferDataErrorState(this.error);
}
