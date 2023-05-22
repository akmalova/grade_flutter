part of 'delete_page_bloc.dart';

@immutable
abstract class DeletePageState {}

class DeletePageInitialState extends DeletePageState {}

class DeletePageInProgressState extends DeletePageState {}

class DeletePageGetDataState extends DeletePageState {
  final List<PageModel> pages;

  DeletePageGetDataState(this.pages);
}
