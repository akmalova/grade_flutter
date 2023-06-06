import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grade/ui/screens/reports/teacher_info/bloc/teacher_info_bloc.dart';
import 'package:grade/ui/screens/tasks/change_access/widgets/teachers_table.dart';
import 'package:grade/ui/utils/constants/app_colors.dart';
import 'package:grade/ui/common_widgets/grade_app_bar.dart';
import 'package:grade/ui/common_widgets/grade_button.dart';
import 'package:grade/ui/common_widgets/grade_container.dart';
import 'package:grade/ui/common_widgets/grade_error_widget.dart';
import 'package:grade/ui/common_widgets/text_field_row.dart';

class TeacherInfoScreen extends StatefulWidget {
  const TeacherInfoScreen({super.key});

  @override
  State<TeacherInfoScreen> createState() => _TeacherInfoScreenState();
}

class _TeacherInfoScreenState extends State<TeacherInfoScreen> {
  late double textWidth;
  late double textFieldWidth;

  @override
  Widget build(BuildContext context) {
    _getWidth(context);
    return Scaffold(
      appBar: const GradeAppBar(title: 'Поиск информации о преподавателях'),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: BlocBuilder<TeacherInfoBloc, TeacherInfoState>(
            builder: (context, state) {
              if (state is TeacherInfoInProgressState) {
                return const CircularProgressIndicator(
                  color: Colors.blue,
                );
              } else if (state is TeacherInfoErrorState) {
                return GradeErrorWidget(
                  description: 'Не удалось выполнить поиск',
                  onTap: () {
                    context
                        .read<TeacherInfoBloc>()
                        .add(TeacherInfoOpenInitialEvent());
                  },
                );
              } else if (state is TeacherInfoTeachersNotFoundState) {
                return GradeErrorWidget(
                  description: 'Не удалось найти преподавателей с таким ФИО',
                  onTap: () {
                    context
                        .read<TeacherInfoBloc>()
                        .add(TeacherInfoOpenInitialEvent());
                  },
                );
              } else if (state is TeacherInfoGetTeachersSuccessState) {
                return GradeContainer(
                  child: TeachersTable(
                    teachers: state.teachers,
                    needButton: false,
                  ),
                );
              } else {
                return GradeContainer(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFieldRow(
                        title: 'Введите фамилию преподавателя',
                        hint: 'Фамилия',
                        onChanged: (value) {
                          context
                              .read<TeacherInfoBloc>()
                              .add(TeacherInfoLastNameChangedEvent(value));
                        },
                        textFieldWidth: textFieldWidth,
                        textWidth: textWidth,
                      ),
                      const SizedBox(height: 15),
                      TextFieldRow(
                        title: 'Введите имя преподавателя',
                        hint: 'Имя',
                        onChanged: (value) {
                          context
                              .read<TeacherInfoBloc>()
                              .add(TeacherInfoFirstNameChangedEvent(value));
                        },
                        textFieldWidth: textFieldWidth,
                        textWidth: textWidth,
                      ),
                      const SizedBox(height: 15),
                      TextFieldRow(
                        title: 'Введите отчество преподавателя',
                        hint: 'Отчество',
                        onChanged: (value) {
                          context
                              .read<TeacherInfoBloc>()
                              .add(TeacherInfoSecondNameChangedEvent(value));
                        },
                        textFieldWidth: textFieldWidth,
                        textWidth: textWidth,
                      ),
                      const SizedBox(height: 10),
                      if (state is TeacherInfoInitialState &&
                          state.isEmptyFields)
                        const Text(
                          'Хотя бы одно из полей должно быть заполнено',
                          style: TextStyle(
                            color: AppColors.red,
                            fontSize: 13,
                          ),
                        ),
                      const SizedBox(height: 10),
                      GradeButton(
                        title: 'Найти преподавателей',
                        onTap: () {
                          context.read<TeacherInfoBloc>().add(
                                TeacherInfoGetTeachersEvent(),
                              );
                        },
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  void _getWidth(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > 660) {
      textWidth = 230;
      textFieldWidth = 300;
    } else if (screenWidth > 560) {
      textWidth = 180;
      textFieldWidth = 250;
    } else {
      textWidth = 150;
      textFieldWidth = 210;
    }
  }
}
