part of 'pages_bloc.dart';

@immutable
abstract class PagesEvent {}

class PagesGetDataEvent implements PagesEvent {}

class PagesSaveEvent implements PagesEvent {}

class PagesTypeChangedEvent extends PagesEvent {
  final String pageType;

  PagesTypeChangedEvent(this.pageType);
}

class PagesSectionChangedEvent extends PagesEvent {
  final String pageSection;

   PagesSectionChangedEvent(this.pageSection);
}

class PagesNameChangedEvent extends PagesEvent {
  final String pageName;

  PagesNameChangedEvent(this.pageName);
}

class PagesFunctionNameChangedEvent extends PagesEvent {
  final String functionName;

  PagesFunctionNameChangedEvent(this.functionName);
}

class PagesParametersTitlesChangedEvent extends PagesEvent {
  final int index;
  final String parameterTitle;

  PagesParametersTitlesChangedEvent(this.index, this.parameterTitle);
}

class PagesParametersChangedEvent extends PagesEvent {
  final int index;
  final String parameter;

  PagesParametersChangedEvent(this.index, this.parameter);
}

class PagesParameterAddedEvent extends PagesEvent {}

class PagesParameterDeletedEvent extends PagesEvent {}

class PagesDeleteEvent implements PagesEvent {
  final int index;

  PagesDeleteEvent(this.index);
}

class PagesOpenSaveInitialEvent implements PagesEvent {}
