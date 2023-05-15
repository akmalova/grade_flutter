import 'package:flutter/material.dart';
import 'package:grade/ui/utils/constants/app_colors.dart';

class GradeContainer extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? heigth;

  const GradeContainer({
    super.key,
    required this.child,
    this.width,
    this.heigth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: heigth,
      width: width,
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            offset: Offset(0, 4),
            color: AppColors.greyShadow,
          ),
        ],
      ),
      padding: const EdgeInsets.all(40),
      child: child,
    );
  }
}
