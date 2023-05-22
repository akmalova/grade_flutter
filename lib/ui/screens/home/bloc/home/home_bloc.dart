import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grade/domain/locator/locator.dart';
import 'package:grade/domain/model/page_model.dart';
import 'package:grade/domain/repository/grade_repository.dart';
import 'package:side_effect_bloc/side_effect_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';
part 'home_command.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState>
    with SideEffectBlocMixin<HomeState, HomeCommand> {
  HomeBloc() : super(HomeInitialState()) {
    on<HomePageOpenedEvent>(_pageOpened);
    on<HomeUnlockDisciplineEvent>(_unlockDiscipline);
    on<HomeChangeAccessEvent>(_changeAccess);
    on<HomeTransferTeacherDataEvent>(_transferTeacherData);
    on<HomeEditStudyPlanEvent>(_editStudyPlan);
    on<HomeStudyPlansEvent>(_studyPlans);
    on<HomeAddPageEvent>(_addPage);
    on<HomeDeletePageEvent>(_deletePage);
    on<HomePatternEvent>(_pattern);
    on<HomeMenuPressedEvent>(_menuPressed);
  }

  Future<void> _pageOpened(HomePageOpenedEvent event, Emitter emit) async {
    emit(HomeInProgressState());
    final jsonString = await File('./config.json').readAsString();
    final json = jsonDecode(jsonString);
    getIt<GradeRepository>().connect(
      host: json['host'],
      port: json['port'],
      databaseName: json['databaseName'],
      username: json['username'],
      password: json['password'],
    );
    emit(HomeDataLoadedState());
  }

  void _unlockDiscipline(HomeUnlockDisciplineEvent event, Emitter emit) {
    emit(HomeUnlockDisciplineState());
  }

  void _changeAccess(HomeChangeAccessEvent event, Emitter emit) {
    emit(HomeChangeAccessState());
  }

  void _transferTeacherData(HomeTransferTeacherDataEvent event, Emitter emit) {
    emit(HomeTransferTeacherDataState());
  }

  void _editStudyPlan(HomeEditStudyPlanEvent event, Emitter emit) {
    emit(HomeEditStudyPlanState());
  }

  void _studyPlans(HomeStudyPlansEvent event, Emitter emit) {
    emit(HomeStudyPlansState());
  }

  void _addPage(HomeAddPageEvent event, Emitter emit) {
    emit(HomeAddPageState());
  }

  void _deletePage(HomeDeletePageEvent event, Emitter emit) {
    emit(HomeDeletePageState());
  }

  void _pattern(HomePatternEvent event, Emitter emit) {
    emit(HomePatternState(event.pageModel));
  }

  void _menuPressed(HomeMenuPressedEvent event, Emitter emit) {
    produceSideEffect(HomeChangeMenuCommand());
  }
}
