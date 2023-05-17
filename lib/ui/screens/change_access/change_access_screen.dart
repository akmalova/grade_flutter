import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grade/ui/screens/change_access/bloc/change_access_bloc.dart';
import 'package:grade/ui/screens/change_access/widgets/teachers_table.dart';
import 'package:grade/ui/utils/constants/app_colors.dart';
import 'package:grade/ui/common_widgets/grade_app_bar.dart';
import 'package:grade/ui/common_widgets/grade_button.dart';
import 'package:grade/ui/common_widgets/grade_container.dart';
import 'package:grade/ui/common_widgets/grade_error_widget.dart';
import 'package:grade/ui/common_widgets/grade_success_widget.dart';
import 'package:grade/ui/common_widgets/text_field_row.dart';

class ChangeAccessScreen extends StatefulWidget {
  const ChangeAccessScreen({super.key});

  @override
  State<ChangeAccessScreen> createState() => _ChangeAccessScreenState();
}

class _ChangeAccessScreenState extends State<ChangeAccessScreen> {
  late double textWidth;
  late double textFieldWidth;

  @override
  Widget build(BuildContext context) {
    _getWidth(context);
    return Scaffold(
      appBar: const GradeAppBar(title: 'Изменить право доступа преподавателя'),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: BlocBuilder<ChangeAccessBloc, ChangeAccessState>(
            builder: (context, state) {
              if (state is ChangeAccessInProgressState) {
                return const CircularProgressIndicator(
                  color: Colors.blue,
                );
              } else if (state is ChangeAccessSuccessState) {
                return GradeSuccessWidget(
                  description: 'Право доступа преподавателя успешно изменено',
                  onTap: () {
                    context
                        .read<ChangeAccessBloc>()
                        .add(ChangeAccessOpenInitialEvent());
                  },
                );
              } else if (state is ChangeAccessErrorState) {
                return GradeErrorWidget(
                  description:
                      'Не удалось изменить право доступа преподавателя',
                  onTap: () {
                    context
                        .read<ChangeAccessBloc>()
                        .add(ChangeAccessOpenInitialEvent());
                  },
                );
              } else if (state is ChangeAccessTeachersNotFoundState) {
                return GradeErrorWidget(
                  description: 'Не удалось найти преподавателей с таким ФИО',
                  onTap: () {
                    context
                        .read<ChangeAccessBloc>()
                        .add(ChangeAccessOpenInitialEvent());
                  },
                );
              } else if (state is ChangeAccessGetTeachersSuccessState) {
                return GradeContainer(
                  child: TeachersTable(
                    teachers: state.teachers,
                    onPressed: (teacher) {
                      context
                          .read<ChangeAccessBloc>()
                          .add(ChangeAccessPerformEvent(teacher.id));
                    },
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
                              .read<ChangeAccessBloc>()
                              .add(ChangeAccessLastNameChangedEvent(value));
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
                              .read<ChangeAccessBloc>()
                              .add(ChangeAccessFirstNameChangedEvent(value));
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
                              .read<ChangeAccessBloc>()
                              .add(ChangeAccessSecondNameChangedEvent(value));
                        },
                        textFieldWidth: textFieldWidth,
                        textWidth: textWidth,
                      ),
                      const SizedBox(height: 15),
                      TextFieldRow(
                        title: 'Введите право доступа',
                        hint: 'Право доступа',
                        onChanged: (value) {
                          context
                              .read<ChangeAccessBloc>()
                              .add(ChangeAccessUserRoleChangedEvent(value));
                        },
                        textFieldWidth: textFieldWidth,
                        textWidth: textWidth,
                      ),
                      const SizedBox(height: 10),
                      if (state is ChangeAccessInitialState && state.isEmptyFields)
                        const Text(
                          'Поля должны быть заполнены',
                          style: TextStyle(
                            color: AppColors.red,
                            fontSize: 13,
                          ),
                        ),
                      const SizedBox(height: 10),
                      GradeButton(
                        title: 'Готово',
                        onTap: () {
                          context.read<ChangeAccessBloc>().add(
                                ChangeAccessGetTeachersEvent(),
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
