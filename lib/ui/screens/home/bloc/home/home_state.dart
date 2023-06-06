part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitialState extends HomeState {}

class HomeInProgressState extends HomeState {}

class HomeDataLoadedState extends HomeState {}

class HomeUnlockDisciplineState extends HomeState {}

class HomeChangeAccessState extends HomeState {}

class HomeTransferTeacherDataState extends HomeState {}

class HomeEditStudyPlanState extends HomeState {}

class HomeTeacherInfoState extends HomeState {}

class HomeStudyPlansState extends HomeState {}

class HomeAddPageState extends HomeState {}

class HomeDeletePageState extends HomeState {}

class HomePatternState extends HomeState {
  final PageModel pageModel;

  HomePatternState(this.pageModel);
}
