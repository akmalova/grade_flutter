import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grade/domain/model/page_model.dart';
import 'package:grade/ui/screens/home/bloc/pages/pages_bloc.dart';
import 'package:grade/ui/utils/constants/app_colors.dart';

class PagesTable extends StatelessWidget {
  final List<PageModel> pages;

  const PagesTable({super.key, required this.pages});

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: _buildColumns(),
      rows: _buildRows(context),
    );
  }

  List<DataColumn> _buildColumns() {
    final List<String> columns = [
      'Тип страницы',
      'Название страницы',
      'Название хранимой функции',
      'Список параметров',
      '',
    ];
    List<DataColumn> dataColumnList = [];
    for (String column in columns) {
      dataColumnList.add(
        DataColumn(
          label: Expanded(
            child: Text(
              column,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.grey3,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }
    return dataColumnList;
  }

  List<DataRow> _buildRows(BuildContext context) {
    List<DataRow> dataRowList = [];
    for (int i = 0; i < pages.length; i++) {
      dataRowList.add(
        DataRow(
          cells: <DataCell>[
            DataCell(
              Text(
                pages[i].type,
                style: const TextStyle(
                  color: AppColors.grey3,
                ),
              ),
            ),
            DataCell(
              Text(
                pages[i].pageName,
                style: const TextStyle(
                  color: AppColors.grey3,
                ),
              ),
            ),
            DataCell(
              Text(
                pages[i].functionName,
                style: const TextStyle(
                  color: AppColors.grey3,
                ),
              ),
            ),
            DataCell(
              Text(
                pages[i].parameters.toString(),
                style: const TextStyle(
                  color: AppColors.grey3,
                ),
              ),
            ),
            DataCell(
              TextButton(
                onPressed: () {
                  context.read<PagesBloc>().add(PagesDeleteEvent(i));
                },
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                ),
                child: const Text(
                  'Удалить',
                  style: TextStyle(
                    color: AppColors.red,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
    return dataRowList;
  }
}
