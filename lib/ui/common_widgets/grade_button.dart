import 'package:flutter/material.dart';
import 'package:grade/ui/utils/constants/app_colors.dart';

class GradeButton extends StatelessWidget {
  final String title;
  final Function() onTap;
  final Color? backgroundColor;
  final Color? titleColor;
  final EdgeInsets? padding;

  const GradeButton({
    super.key,
    required this.title,
    required this.onTap,
    this.backgroundColor,
    this.titleColor,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding:
            padding ?? const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
        decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.blue,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            color: titleColor ?? AppColors.white,
          ),
        ),
      ),
    );
  }
}
