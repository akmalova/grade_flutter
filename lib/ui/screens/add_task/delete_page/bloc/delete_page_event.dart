part of 'delete_page_bloc.dart';

@immutable
abstract class DeletePageEvent {}

class DeletePageGetDataEvent implements DeletePageEvent {}

class DeletePageDeleteEvent implements DeletePageEvent {
  final int index;

  DeletePageDeleteEvent(this.index);
}
