import 'package:flutter/material.dart';
import 'package:grade/domain/model/study_plan_model.dart';
import 'package:grade/ui/utils/constants/app_colors.dart';

class StudyPlansTable extends StatelessWidget {
  final List<StudyPlanModel> studyPlans;

  const StudyPlansTable({
    super.key,
    required this.studyPlans,
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
      'Почта',
      'Фамилия',
      'Имя',
      'Отчество',
      'Внешний id рабочего плана',
      'Год',
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
    for (StudyPlanModel studyPlan in studyPlans) {
      dataRowList.add(
        DataRow(
          cells: <DataCell>[
            DataCell(
              Text(
                studyPlan.email,
                overflow: TextOverflow.fade,
                style: const TextStyle(
                  color: AppColors.grey3,
                ),
              ),
            ),
            DataCell(
              Text(
                studyPlan.lastName,
                overflow: TextOverflow.fade,
                style: const TextStyle(
                  color: AppColors.grey3,
                ),
              ),
            ),
            DataCell(
              Text(
                studyPlan.firstName,
                overflow: TextOverflow.fade,
                style: const TextStyle(
                  color: AppColors.grey3,
                ),
              ),
            ),
            DataCell(
              Text(
                studyPlan.secondName,
                overflow: TextOverflow.fade,
                style: const TextStyle(
                  color: AppColors.grey3,
                ),
              ),
            ),
            DataCell(
              Text(
                studyPlan.studyPlanId.toString(),
                overflow: TextOverflow.fade,
                style: const TextStyle(
                  color: AppColors.grey3,
                ),
              ),
            ),
            DataCell(
              Text(
                studyPlan.year.toString(),
                overflow: TextOverflow.fade,
                style: const TextStyle(
                  color: AppColors.grey3,
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
