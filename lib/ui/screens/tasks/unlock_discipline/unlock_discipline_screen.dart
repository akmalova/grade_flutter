import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grade/ui/common_widgets/grade_app_bar.dart';
import 'package:grade/ui/common_widgets/grade_button.dart';
import 'package:grade/ui/common_widgets/grade_container.dart';
import 'package:grade/ui/common_widgets/grade_error_widget.dart';
import 'package:grade/ui/common_widgets/grade_text_field.dart';
import 'package:grade/ui/common_widgets/grade_success_widget.dart';
import 'package:grade/ui/screens/tasks/unlock_discipline/bloc/unlock_discipline_bloc.dart';
import 'package:grade/ui/utils/constants/app_colors.dart';

class UnlockDisciplineScreen extends StatelessWidget {
  const UnlockDisciplineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GradeAppBar(title: 'Очистить и разблокировать дисциплину'),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: BlocBuilder<UnlockDisciplineBloc, UnlockDisciplineState>(
            builder: (context, state) {
              if (state is UnlockDisciplineInProgressState) {
                return const CircularProgressIndicator(
                  color: AppColors.blue,
                );
              } else if (state is UnlockDisciplineSuccessState) {
                return GradeSuccessWidget(
                  description:
                      'Дисциплина успешно очищена и разблокирована\nУдалено ${state.rowCount} записей',
                  onTap: () {
                    context
                        .read<UnlockDisciplineBloc>()
                        .add(UnlockDisciplineOpenInitialEvent());
                  },
                );
              } else if (state is UnlockDisciplineErrorState) {
                return GradeErrorWidget(
                  description:
                      'Не удалось очистить и разблокировать дисциплину',
                  onTap: () {
                    context
                        .read<UnlockDisciplineBloc>()
                        .add(UnlockDisciplineOpenInitialEvent());
                  },
                );
              } else {
                return GradeContainer(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Введите номер ведомости',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 15),
                      GradeTextField(
                        onChanged: (value) {
                          context
                              .read<UnlockDisciplineBloc>()
                              .add(UnlockDisciplineIdChangedEvent(value));
                        },
                        hintText: 'Номер ведомости',
                      ),
                      const SizedBox(height: 10),
                      if (state is UnlockDisciplineInitialState && state.isEmptyFields)
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
                          context.read<UnlockDisciplineBloc>().add(
                                UnlockDisciplinePerformEvent(),
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
}
