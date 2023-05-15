import 'package:flutter/material.dart';
import 'package:grade/ui/utils/constants/app_colors.dart';

class GradeTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final double? width;
  final void Function(String)? onChanged;

  const GradeTextField({
    super.key,
    this.controller,
    required this.hintText,
    this.width,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      constraints: const BoxConstraints(maxWidth: 300, minWidth: 100),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.grey,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide.none,
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(color: AppColors.transparent),
          ),
          hintText: hintText,
          hintStyle: const TextStyle(
            fontSize: 14,
            color: AppColors.grey4,
          ),
        ),
      ),
    );
  }
}
