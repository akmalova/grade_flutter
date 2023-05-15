import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grade/domain/locator/locator.dart';
import 'package:grade/domain/repository/grade_repository.dart';
import 'package:grade/ui/screens/add_page/add_page_screen.dart';
import 'package:grade/ui/screens/change_access/bloc/change_access_bloc.dart';
import 'package:grade/ui/screens/change_access/change_access_screen.dart';
import 'package:grade/ui/screens/delete_page/bloc/delete_page_bloc.dart';
import 'package:grade/ui/screens/delete_page/delete_page_screen.dart';
import 'package:grade/ui/screens/home/bloc/home/home_bloc.dart';
import 'package:grade/ui/screens/pattern/bloc/pattern_bloc.dart';
import 'package:grade/ui/screens/pattern/pattern_screen.dart';
import 'package:grade/ui/screens/transfer_teacher_data/bloc/transfer_teacher_data_bloc.dart';
import 'package:grade/ui/screens/transfer_teacher_data/transfer_teacher_data_screen.dart';
import 'package:grade/ui/screens/unlock_discipline/bloc/unlock_discipline_bloc.dart';
import 'package:grade/ui/screens/unlock_discipline/unlock_discipline_screen.dart';
import 'package:grade/ui/common_widgets/grade_app_bar.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeUnlockDisciplineState) {
          return BlocProvider(
            create: (context) => UnlockDisciplineBloc(getIt<GradeRepository>()),
            child: const UnlockDisciplineScreen(),
          );
        } else if (state is HomeChangeAccessState) {
          return BlocProvider(
            create: (context) => ChangeAccessBloc(getIt<GradeRepository>()),
            child: const ChangeAccessScreen(),
          );
        } else if (state is HomeTransferTeacherDataState) {
          return BlocProvider(
            create: (context) =>
                TransferTeacherDataBloc(getIt<GradeRepository>()),
            child: TransferTeacherDataScreen(),
          );
        } else if (state is HomeAddPageState) {
          return const AddPageScreen();
        } else if (state is HomeDeletePageState) {
          return BlocProvider(
            create: (context) => DeletePageBloc(),
            child: const DeletePageScreen(),
          );
        } else if (state is HomePatternState) {
          return BlocProvider(
            create: (context) => PatternBloc(getIt<GradeRepository>()),
            child: PatternScreen(page: state.pageModel),
          );
        } else {
          return const Scaffold(
            appBar: GradeAppBar(title: ''),
            body: Center(
              child: Text(
                'Выберите пункт в меню слева',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          );
        }
      },
    );
  }
}