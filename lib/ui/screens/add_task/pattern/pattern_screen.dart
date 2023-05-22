import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grade/domain/model/page_model.dart';
import 'package:grade/ui/screens/add_task/pattern/bloc/pattern_bloc.dart';
import 'package:grade/ui/common_widgets/grade_app_bar.dart';
import 'package:grade/ui/common_widgets/grade_button.dart';
import 'package:grade/ui/common_widgets/grade_container.dart';
import 'package:grade/ui/common_widgets/grade_error_widget.dart';
import 'package:grade/ui/common_widgets/grade_success_widget.dart';
import 'package:grade/ui/common_widgets/text_field_row.dart';

class PatternScreen extends StatelessWidget {
  final PageModel page;
  final List<TextEditingController> _controllers = [];
  late final double textWidth;
  late final double textFieldWidth;

  PatternScreen({super.key, required this.page});

  @override
  Widget build(BuildContext context) {
    context.read<PatternBloc>().add(PatternOpenInitialEvent());
    for (int i = 0; i < page.parameters.length; i++) {
      _controllers.add(TextEditingController());
    }
    _getWidth(context);
    return Scaffold(
      appBar: GradeAppBar(title: page.pageName),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: BlocBuilder<PatternBloc, PatternState>(
            builder: (context, state) {
              if (state is PatternInProgressState) {
                return const CircularProgressIndicator(color: Colors.blue);
              } else if (state is PatternSuccessState) {
                return GradeSuccessWidget(
                  description:
                      'Запрос успешно выполнен. Результат: ${state.result}',
                  onTap: () {
                    for (TextEditingController controller in _controllers) {
                      controller.clear();
                    }
                    context.read<PatternBloc>().add(PatternOpenInitialEvent());
                  },
                );
              } else if (state is PatternErrorState) {
                return GradeErrorWidget(
                  description: 'Не удалось выполнить запрос',
                  onTap: () {
                    for (TextEditingController controller in _controllers) {
                      controller.clear();
                    }
                    context.read<PatternBloc>().add(PatternOpenInitialEvent());
                  },
                );
              } else {
                return GradeContainer(
                    width: 625,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: page.parameters.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  TextFieldRow(
                                    title: page.parametersTitles[index],
                                    hint: page.parameters[index],
                                    controller: _controllers[index],
                                    textFieldWidth: textFieldWidth,
                                    textWidth: textWidth,
                                  ),
                                  const SizedBox(height: 15),
                                ],
                              );
                            },
                          ),
                          GradeButton(
                            title: 'Готово',
                            onTap: () {
                              List<String> values = [];
                              for (TextEditingController controller
                                  in _controllers) {
                                values.add(controller.text.trim());
                              }
                              context.read<PatternBloc>().add(
                                    PatternPerformEvent(
                                      functionName: page.functionName,
                                      parameters: page.parameters,
                                      values: values,
                                    ),
                                  );
                            },
                          ),
                        ],
                      ),
                    ));
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
