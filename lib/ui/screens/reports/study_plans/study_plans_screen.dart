import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grade/ui/common_widgets/grade_text_field.dart';
import 'package:grade/ui/screens/reports/study_plans/bloc/study_plans_bloc.dart';
import 'package:grade/ui/screens/reports/study_plans/widgets/study_plans_table.dart';
import 'package:grade/ui/utils/constants/app_colors.dart';
import 'package:grade/ui/common_widgets/grade_app_bar.dart';
import 'package:grade/ui/common_widgets/grade_button.dart';
import 'package:grade/ui/common_widgets/grade_container.dart';
import 'package:grade/ui/common_widgets/grade_error_widget.dart';

class StudyPlansScreen extends StatefulWidget {
  const StudyPlansScreen({super.key});

  @override
  State<StudyPlansScreen> createState() => _StudyPlansScreenState();
}

class _StudyPlansScreenState extends State<StudyPlansScreen> {
  late double textWidth;
  late double textFieldWidth;

  @override
  Widget build(BuildContext context) {
    _getWidth(context);
    return Scaffold(
      appBar: const GradeAppBar(title: 'Рабочие планы студента'),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: BlocBuilder<StudyPlansBloc, StudyPlansState>(
            builder: (context, state) {
              if (state is StudyPlansInProgressState) {
                return const CircularProgressIndicator(color: Colors.blue);
              } else if (state is StudyPlansSuccessState) {
                return GradeContainer(
                  child: StudyPlansTable(studyPlans: state.studyPlans),
                );
              } else if (state is StudyPlansNotFoundState) {
                return GradeErrorWidget(
                  description: 'Не удалось найти рабочие планы студента',
                  onTap: () {
                    context
                        .read<StudyPlansBloc>()
                        .add(StudyPlansOpenInitialEvent());
                  },
                );
              } else if (state is StudyPlansErrorState) {
                return GradeErrorWidget(
                  description: 'Не удалось получить рабочие планы студента',
                  errorText: state.error,
                  onTap: () {
                    context
                        .read<StudyPlansBloc>()
                        .add(StudyPlansOpenInitialEvent());
                  },
                );
              }else {
                return GradeContainer(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Введите номер зачетной книжки',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 15),
                      GradeTextField(
                        onChanged: (value) {
                          context
                              .read<StudyPlansBloc>()
                              .add(StudyPlansRecordBookChangedEvent(value));
                        },
                        hintText: 'Номер зачетной книжки',
                      ),
                      const SizedBox(height: 10),
                      if (state is StudyPlansInitialState &&
                          state.isEmptyFields)
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
                              .read<StudyPlansBloc>()
                              .add(StudyPlansPerformEvent());
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
