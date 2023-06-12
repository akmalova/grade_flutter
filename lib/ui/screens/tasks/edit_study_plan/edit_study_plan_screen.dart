import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grade/ui/screens/tasks/edit_study_plan/bloc/edit_study_plan_bloc.dart';
import 'package:grade/ui/utils/constants/app_colors.dart';
import 'package:grade/ui/common_widgets/grade_app_bar.dart';
import 'package:grade/ui/common_widgets/grade_button.dart';
import 'package:grade/ui/common_widgets/grade_container.dart';
import 'package:grade/ui/common_widgets/grade_error_widget.dart';
import 'package:grade/ui/common_widgets/grade_success_widget.dart';
import 'package:grade/ui/common_widgets/text_field_row.dart';

class EditStudyPlanScreen extends StatefulWidget {
  const EditStudyPlanScreen({super.key});

  @override
  State<EditStudyPlanScreen> createState() => _EditStudyPlanScreenState();
}

class _EditStudyPlanScreenState extends State<EditStudyPlanScreen> {
  late double textWidth;
  late double textFieldWidth;

  @override
  Widget build(BuildContext context) {
    _getWidth(context);
    return Scaffold(
      appBar: const GradeAppBar(title: 'Редактировать рабочий план студента'),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: BlocBuilder<EditStudyPlanBloc, EditStudyPlanState>(
            builder: (context, state) {
              if (state is EditPlanInProgressState) {
                return const CircularProgressIndicator(color: Colors.blue);
              } else if (state is EditPlanSuccessState) {
                return GradeSuccessWidget(
                  description: 'Рабочий план успешно отредактирован',
                  onTap: () {
                    context
                        .read<EditStudyPlanBloc>()
                        .add(EditPlanOpenInitialEvent());
                  },
                );
              } else if (state is EditPlanErrorState) {
                return GradeErrorWidget(
                  description: 'Не удалось отредактировать рабочий план',
                  errorText: state.error,
                  onTap: () {
                    context
                        .read<EditStudyPlanBloc>()
                        .add(EditPlanOpenInitialEvent());
                  },
                );
              } else {
                return GradeContainer(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFieldRow(
                        title: 'Введите номер зачетной книжки',
                        hint: 'Номер зачетной книжки',
                        onChanged: (value) {
                          context
                              .read<EditStudyPlanBloc>()
                              .add(EditPlanRecordBookChangedEvent(value));
                        },
                        textFieldWidth: textFieldWidth,
                        textWidth: textWidth,
                      ),
                      const SizedBox(height: 15),
                      TextFieldRow(
                        title:
                            'Введите id рабочего плана, который нужно отредактировать',
                        hint: 'Идентификатор рабочего плана',
                        onChanged: (value) {
                          context
                              .read<EditStudyPlanBloc>()
                              .add(EditPlanStudyPlanFromChangedEvent(value));
                        },
                        textFieldWidth: textFieldWidth,
                        textWidth: textWidth,
                      ),
                      const SizedBox(height: 15),
                      TextFieldRow(
                        title:
                            'Введите id рабочего плана, который нужно установить',
                        hint: 'Идентификатор рабочего плана',
                        onChanged: (value) {
                          context
                              .read<EditStudyPlanBloc>()
                              .add(EditPlanStudyPlanToChangedEvent(value));
                        },
                        textFieldWidth: textFieldWidth,
                        textWidth: textWidth,
                      ),
                      const SizedBox(height: 15),
                      TextFieldRow(
                        title: 'Введите учебный год',
                        hint: 'Учебный год',
                        onChanged: (value) {
                          context
                              .read<EditStudyPlanBloc>()
                              .add(EditPlanYearChangedEvent(value));
                        },
                        textFieldWidth: textFieldWidth,
                        textWidth: textWidth,
                      ),
                      const SizedBox(height: 10),
                      if (state is EditPlanInitialState && state.isEmptyFields)
                        const Text(
                          'Поля должны быть заполнены',
                          style: TextStyle(
                            color: AppColors.red,
                            fontSize: 13,
                          ),
                        ),
                      const SizedBox(height: 10),
                      GradeButton(
                        title: 'Выполнить',
                        onTap: () {
                          context
                              .read<EditStudyPlanBloc>()
                              .add(EditPlanPerformEvent());
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
