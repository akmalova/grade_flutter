import 'package:flutter/material.dart';
import 'package:grade/domain/model/teacher_model.dart';
import 'package:grade/ui/utils/constants/app_colors.dart';

class TeachersTable extends StatelessWidget {
  final List<TeacherModel> teachers;
  final Function(TeacherModel) onPressed;

  const TeachersTable({
    super.key,
    required this.teachers,
    required this.onPressed,
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
    final List<String> columns = [
      'Фамилия',
      'Имя',
      'Отчество',
      'Факультет',
      'Должность',
      'Почта',
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
    for (TeacherModel teacher in teachers) {
      dataRowList.add(
        DataRow(
          cells: <DataCell>[
            DataCell(
              Text(
                teacher.lastName,
                overflow: TextOverflow.fade,
                style: const TextStyle(
                  color: AppColors.grey3,
                ),
              ),
            ),
            DataCell(
              Text(
                teacher.firstName,
                overflow: TextOverflow.fade,
                style: const TextStyle(
                  color: AppColors.grey3,
                ),
              ),
            ),
            DataCell(
              Text(
                teacher.secondName,
                overflow: TextOverflow.fade,
                style: const TextStyle(
                  color: AppColors.grey3,
                ),
              ),
            ),
            DataCell(
              Text(
                teacher.facultyName,
                overflow: TextOverflow.fade,
                style: const TextStyle(
                  color: AppColors.grey3,
                ),
              ),
            ),
            DataCell(
              Text(
                teacher.jobPositionName,
                overflow: TextOverflow.fade,
                style: const TextStyle(
                  color: AppColors.grey3,
                ),
              ),
            ),
            DataCell(
              Text(
                teacher.email,
                overflow: TextOverflow.clip,
                style: const TextStyle(
                  color: AppColors.grey3,
                ),
              ),
            ),
            DataCell(
              TextButton(
                onPressed: () {
                  onPressed(teacher);
                },
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                ),
                child: const Text(
                  'Выбрать',
                  style: TextStyle(
                    color: AppColors.blue,
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
