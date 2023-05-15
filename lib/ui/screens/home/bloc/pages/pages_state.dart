part of 'pages_bloc.dart';

@immutable
abstract class PagesState {}

class PagesInitialState extends PagesState {}

class PagesSaveInitialState extends PagesState {
  final bool isEmptyFields;
 final PageModel page;

  PagesSaveInitialState({
    required this.page,
    this.isEmptyFields = false,
  });
}

class PagesGetDataInProgressState extends PagesState {}

class PagesGetDataSuccessState extends PagesState {
  final List<PageModel> pages;
  final List<PageModel> studentsPages;
  final List<PageModel> teachersPages;
  final List<PageModel> disciplinesPages;

  PagesGetDataSuccessState({
    required this.pages,
    required this.studentsPages,
    required this.teachersPages,
    required this.disciplinesPages,
  });
}

class PagesSaveInProgressState extends PagesState {}

class PagesSaveSuccessState extends PagesState {}

class PagesSaveErrorState extends PagesState {}

class PagesDeleteInProgressState extends PagesState {}

class PagesDeleteSuccessState extends PagesState {}

class PagesDeleteErrorState extends PagesState {}
