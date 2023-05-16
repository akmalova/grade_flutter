part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class HomePageOpenedEvent implements HomeEvent {}

class HomeUnlockDisciplineEvent implements HomeEvent {}

class HomeChangeAccessEvent implements HomeEvent {}

class HomeTransferTeacherDataEvent implements HomeEvent {}

class HomeEditStudyPlanEvent implements HomeEvent {}

class HomeAddPageEvent implements HomeEvent {}

class HomeDeletePageEvent implements HomeEvent {}


class HomePatternEvent implements HomeEvent {
  final PageModel pageModel;

  HomePatternEvent(this.pageModel);
}

class HomeMenuPressedEvent implements HomeEvent {}
