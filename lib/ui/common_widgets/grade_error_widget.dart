import 'package:flutter/material.dart';
import 'package:grade/ui/utils/constants/app_colors.dart';
import 'package:grade/ui/common_widgets/grade_button.dart';

class GradeErrorWidget extends StatelessWidget {
  final String title;
  final String description;
  final Function() onTap;

  const GradeErrorWidget({
    super.key,
    this.title = 'Ошибка',
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 500,
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.all(Radius.circular(15)),
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            offset: Offset(0, 4),
            color: AppColors.greyShadow,
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error,
            color: AppColors.red,
            size: 80,
          ),
          const SizedBox(height: 15),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.red,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 15),
          const Divider(),
          const SizedBox(height: 15),
          GradeButton(
            title: 'Вернуться',
            onTap: onTap,
          )
        ],
      ),
    );
  }
}
