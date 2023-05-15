import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grade/domain/model/page_types.dart';
import 'package:grade/ui/screens/add_page/widgets/types_dropdown_button.dart';
import 'package:grade/ui/screens/home/bloc/pages/pages_bloc.dart';
import 'package:grade/ui/utils/constants/app_colors.dart';
import 'package:grade/ui/common_widgets/grade_app_bar.dart';
import 'package:grade/ui/common_widgets/grade_button.dart';
import 'package:grade/ui/common_widgets/grade_container.dart';
import 'package:grade/ui/common_widgets/grade_error_widget.dart';
import 'package:grade/ui/common_widgets/grade_success_widget.dart';
import 'package:grade/ui/common_widgets/text_field_row.dart';

class AddPageScreen extends StatefulWidget {
  const AddPageScreen({super.key});

  @override
  State<AddPageScreen> createState() => _AddPageScreenState();
}

class _AddPageScreenState extends State<AddPageScreen> {
  late double textWidth;
  late double textFieldWidth;

  @override
  void initState() {
    context.read<PagesBloc>().add(PagesOpenSaveInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _getWidth(context);
    return Scaffold(
      appBar: const GradeAppBar(title: 'Добавить задачу'),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: BlocBuilder<PagesBloc, PagesState>(
            builder: (context, state) {
              if (state is PagesSaveSuccessState) {
                return GradeSuccessWidget(
                  description: 'Задача успешно добавлена',
                  onTap: () {
                    context.read<PagesBloc>().add(PagesGetDataEvent());
                    context.read<PagesBloc>().add(PagesOpenSaveInitialEvent());
                  },
                );
              } else if (state is PagesSaveErrorState) {
                return GradeErrorWidget(
                  description: 'Не удалось добавить задачу',
                  onTap: () {
                    context.read<PagesBloc>().add(PagesGetDataEvent());
                    context.read<PagesBloc>().add(PagesOpenSaveInitialEvent());
                  },
                );
              } else if (state is PagesSaveInitialState) {
                return GradeContainer(
                  width: 650,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: textWidth,
                              child: const Text(
                                'Выберите тип задачи',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            const SizedBox(width: 15),
                            TypesDropdownButton(
                              dropdownValue: state.page.type,
                              onChanged: (String? value) {
                                context.read<PagesBloc>().add(
                                      PagesTypeChangedEvent(
                                        value ?? PageTypes.students,
                                      ),
                                    );
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        TextFieldRow(
                          title: 'Введите название задачи',
                          hint: 'Очистить и разблокировать дисциплину',
                          onChanged: (value) {
                            context
                                .read<PagesBloc>()
                                .add(PagesNameChangedEvent(value));
                          },
                          textFieldWidth: textFieldWidth,
                          textWidth: textWidth,
                        ),
                        const SizedBox(height: 15),
                        TextFieldRow(
                          title: 'Введите название хранимой функции',
                          hint: 'discipline_clear',
                          onChanged: (value) {
                            context
                                .read<PagesBloc>()
                                .add(PagesFunctionNameChangedEvent(value));
                          },
                          textFieldWidth: textFieldWidth,
                          textWidth: textWidth,
                        ),
                        const SizedBox(height: 15),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.page.parameters.length,
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextFieldRow(
                                  title: 'Введите подпись к параметру',
                                  hint: 'Введите идентификатор дисциплины',
                                  onChanged: (value) {
                                    context.read<PagesBloc>().add(
                                          PagesParametersTitlesChangedEvent(
                                            index,
                                            value,
                                          ),
                                        );
                                  },
                                  textFieldWidth: textFieldWidth,
                                  textWidth: textWidth,
                                ),
                                const SizedBox(height: 15),
                                TextFieldRow(
                                  title: 'Введите название параметра',
                                  hint: 'id',
                                  onChanged: (value) {
                                    context.read<PagesBloc>().add(
                                          PagesParametersChangedEvent(
                                            index,
                                            value,
                                          ),
                                        );
                                  },
                                  textFieldWidth: textFieldWidth,
                                  textWidth: textWidth,
                                ),
                                const SizedBox(height: 15),
                              ],
                            );
                          },
                        ),
                        Row(
                          children: [
                            SizedBox(width: textWidth + 15),
                            GradeButton(
                              title: 'Добавить параметр',
                              titleColor: AppColors.blue,
                              backgroundColor: AppColors.lightBlue,
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 20,
                              ),
                              onTap: () {
                                context
                                    .read<PagesBloc>()
                                    .add(PagesParameterAddedEvent());
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            SizedBox(width: textWidth + 15),
                            GradeButton(
                              title: 'Удалить параметр',
                              titleColor: AppColors.red,
                              backgroundColor: AppColors.lightRed,
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 25,
                              ),
                              onTap: () {
                                context
                                    .read<PagesBloc>()
                                    .add(PagesParameterDeletedEvent());
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        if (state.isEmptyFields)
                          const Center(
                            child: Text(
                              'Поля должны быть заполнены',
                              style: TextStyle(
                                color: AppColors.red,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        const SizedBox(height: 10),
                        Center(
                          child: GradeButton(
                            title: 'Готово',
                            onTap: () async {
                              context.read<PagesBloc>().add(PagesSaveEvent());
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return const CircularProgressIndicator(color: Colors.blue);
              }
            },
          ),
        ),
      ),
    );
  }

  void _getWidth(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > 670) {
      textWidth = 235;
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
