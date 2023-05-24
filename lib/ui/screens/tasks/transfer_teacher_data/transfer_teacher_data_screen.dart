import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grade/ui/screens/tasks/transfer_teacher_data/bloc/transfer_teacher_data_bloc.dart';
import 'package:grade/ui/utils/constants/app_colors.dart';
import 'package:grade/ui/common_widgets/grade_app_bar.dart';
import 'package:grade/ui/common_widgets/grade_button.dart';
import 'package:grade/ui/common_widgets/grade_container.dart';
import 'package:grade/ui/common_widgets/grade_error_widget.dart';
import 'package:grade/ui/common_widgets/grade_success_widget.dart';
import 'package:grade/ui/common_widgets/text_field_row.dart';

class TransferTeacherDataScreen extends StatefulWidget {
  const TransferTeacherDataScreen({super.key});

  @override
  State<TransferTeacherDataScreen> createState() =>
      _TransferTeacherDataScreenState();
}

class _TransferTeacherDataScreenState extends State<TransferTeacherDataScreen> {
  late double textWidth;
  late double textFieldWidth;

  @override
  Widget build(BuildContext context) {
    _getWidth(context);
    return Scaffold(
      appBar: const GradeAppBar(title: 'Объединить аккаунты преподавателя'),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: BlocBuilder<TransferTeacherDataBloc, TransferTeacherDataState>(
            builder: (context, state) {
              if (state is TransferDataInProgressState) {
                return const CircularProgressIndicator(color: Colors.blue);
              } else if (state is TransferDataSuccessState) {
                return GradeSuccessWidget(
                  description:
                      'Аккаунты преподавателя успешно объединены',
                  onTap: () {
                    context
                        .read<TransferTeacherDataBloc>()
                        .add(TransferDataOpenInitialEvent());
                  },
                );
              } else if (state is TransferDataErrorState) {
                return GradeErrorWidget(
                  description: 'Не удалось объеднить аккаунты преподавателя',
                  onTap: () {
                    context
                        .read<TransferTeacherDataBloc>()
                        .add(TransferDataOpenInitialEvent());
                  },
                );
              } else {
                return GradeContainer(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFieldRow(
                        title:
                            'Введите номер карточки аккаунта, который нужно удалить',
                        hint: 'Номер карточки',
                        onChanged: (value) {
                          context.read<TransferTeacherDataBloc>().add(
                              TransferDataTeacherIdFromChangedEvent(value));
                        },
                        textFieldWidth: textFieldWidth,
                        textWidth: textWidth,
                      ),
                      const SizedBox(height: 15),
                      TextFieldRow(
                        title:
                            'Введите номер карточки аккаунта, который нужно оставить',
                        hint: 'Номер карточки',
                        onChanged: (value) {
                          context
                              .read<TransferTeacherDataBloc>()
                              .add(TransferDataTeacherIdToChangedEvent(value));
                        },
                        textFieldWidth: textFieldWidth,
                        textWidth: textWidth,
                      ),
                      const SizedBox(height: 10),
                      if (state is TransferDataInitialState &&
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
                        title: 'Готово',
                        onTap: () {
                          context
                              .read<TransferTeacherDataBloc>()
                              .add(TransferDataPerformEvent());
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
