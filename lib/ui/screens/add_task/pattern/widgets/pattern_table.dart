import 'package:flutter/material.dart';
import 'package:grade/ui/utils/constants/app_colors.dart';
import 'package:postgres/postgres.dart';

class PatternTable extends StatelessWidget {
  final PostgreSQLResult result;

  const PatternTable({
    super.key,
    required this.result,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: DataTable(
        dataRowHeight: 60,
        columns: _buildColumns(),
        rows: _buildRows(context),
      ),
    );
  }

  List<DataColumn> _buildColumns() {
    final List<String> columns = [];
    for (var element in result.columnDescriptions) {
      columns.add(element.columnName);
    }

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
    for (var row in result) {
      List<DataCell> dataCellList = [];
      for (var element in row) {
        dataCellList.add(
          DataCell(
            Text(
              element.toString(),
              overflow: TextOverflow.fade,
              style: const TextStyle(
                color: AppColors.grey3,
              ),
            ),
          ),
        );
      }

      dataRowList.add(
        DataRow(
          cells: dataCellList,
        ),
      );
    }
    return dataRowList;
  }
}
