import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grade/ui/screens/delete_page/widgets/pages_table.dart';
import 'package:grade/ui/screens/home/bloc/pages/pages_bloc.dart';
import 'package:grade/ui/common_widgets/grade_app_bar.dart';
import 'package:grade/ui/common_widgets/grade_container.dart';
import 'package:grade/ui/common_widgets/grade_error_widget.dart';
import 'package:grade/ui/common_widgets/grade_success_widget.dart';

class DeletePageScreen extends StatefulWidget {
  const DeletePageScreen({super.key});

  @override
  State<DeletePageScreen> createState() => _DeletePageScreenState();
}

class _DeletePageScreenState extends State<DeletePageScreen> {
  @override
  void initState() {
    context.read<PagesBloc>().add(PagesGetDataEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GradeAppBar(title: 'Удалить страницу'),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: BlocBuilder<PagesBloc, PagesState>(
            builder: (context, state) {
              if (state is PagesGetDataSuccessState) {
                return state.pages.isEmpty
                    ? const Text(
                        'Страницы не найдены',
                      )
                    : GradeContainer(
                        child: SingleChildScrollView(
                          child: PagesTable(pages: state.pages),
                        ),
                      );
              } else if (state is PagesDeleteSuccessState) {
                return GradeSuccessWidget(
                  description: 'Страница успешно удалена',
                  onTap: () {
                    context.read<PagesBloc>().add(PagesGetDataEvent());
                  },
                );
              } else if (state is PagesDeleteErrorState) {
                return GradeErrorWidget(
                  description: 'Не удалось удалить страницу',
                  onTap: () {
                    context.read<PagesBloc>().add(PagesGetDataEvent());
                  },
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
}
