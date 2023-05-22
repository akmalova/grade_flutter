import 'package:flutter/material.dart';
import 'package:grade/domain/model/teacher_model.dart';
import 'package:grade/ui/utils/constants/app_colors.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

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
    // TODO:
    // TeacherDataSource teacherDataSource = TeacherDataSource(teachers: teachers);
    // return SfDataGrid(
    //   allowSorting: true,
    //   allowColumnsResizing: true,
    //   columnResizeMode: ColumnResizeMode.onResizeEnd,
    //   source: teacherDataSource,
    //   columns: _buildColumns(),
    // );
    return SingleChildScrollView(
      child: DataTable(
        dataRowHeight: 60,
        columns: _buildColumns(),
        rows: _buildRows(context),
      ),
    );
  }

  // List<GridColumn> _buildColumns() {
  //   final List<String> columns = [
  //     'Фамилия',
  //     'Имя',
  //     'Отчество',
  //     'Факультет',
  //     'Должность',
  //     'Почта',
  //     '',
  //   ];
  //   List<GridColumn> dataColumnList = [];
  //   for (String column in columns) {
  //     dataColumnList.add(
  //       GridColumn(
  //         columnName: column,
  //         label: Container(
  //           padding: EdgeInsets.all(16.0),
  //           alignment: Alignment.centerRight,
  //           child: Text(
  //             column,
  //             style: const TextStyle(
  //               fontWeight: FontWeight.bold,
  //               color: AppColors.grey3,
  //             ),
  //             textAlign: TextAlign.center,
  //           ),
  //         ),
  //       ),
  //     );
  //   }
  //   return dataColumnList;
  // }

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

// class TeacherDataSource extends DataGridSource {
//   List<DataGridRow> _teachers = [];

//   TeacherDataSource({required List<TeacherModel> teachers}) {
//     _teachers = teachers
//         .map<DataGridRow>(
//           (e) => DataGridRow(
//             cells: [
//               DataGridCell<String>(columnName: 'Фамилия', value: e.lastName),
//               DataGridCell<String>(columnName: 'Имя', value: e.firstName),
//               DataGridCell<String>(columnName: 'Отчество', value: e.secondName),
//               DataGridCell<String>(
//                   columnName: 'Факультет', value: e.facultyName),
//               DataGridCell<String>(
//                   columnName: 'Должность', value: e.jobPositionName),
//               DataGridCell<String>(columnName: 'Почта', value: e.email),
//               DataGridCell<Widget>(
//                 columnName: '',
//                 value: TextButton(
//                   onPressed: () {
//                     // onPressed(teacher);
//                   },
//                   style: ButtonStyle(
//                     overlayColor: MaterialStateProperty.all(Colors.transparent),
//                   ),
//                   child: const Text(
//                     'Выбрать',
//                     style: TextStyle(
//                       color: AppColors.blue,
//                       fontSize: 14,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         )
//         .toList();
//   }

//   @override
//   List<DataGridRow> get rows => _teachers;

//   @override
//   DataGridRowAdapter? buildRow(DataGridRow row) {
//     return DataGridRowAdapter(
//       cells: row.getCells().map<Widget>(
//         (dataGridCell) {
//           return Container(
//             alignment: Alignment.center,
//             padding: const EdgeInsets.all(16.0),
//             child: Text(
//               dataGridCell.value.toString(),
//               style: const TextStyle(
//                 color: AppColors.grey3,
//               ),
//               overflow: TextOverflow.ellipsis,
//             ),
//           );
//         },
//       ).toList(),
//     );
//   }
// }
