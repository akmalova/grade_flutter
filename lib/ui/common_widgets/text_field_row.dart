import 'package:flutter/material.dart';
import 'package:grade/ui/common_widgets/grade_text_field.dart';

class TextFieldRow extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController? controller;
  final double textFieldWidth;
  final double textWidth;
  final void Function(String)? onChanged;

  const TextFieldRow({
    super.key,
    required this.title,
    required this.hint,
    this.controller,
    required this.textFieldWidth,
    required this.textWidth,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: textWidth,
          child: Text(
            title,
            textAlign: TextAlign.right,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(width: 15),
        GradeTextField(
          controller: controller,
          onChanged: onChanged,
          hintText: hint,
          width: textFieldWidth,
        ),
      ],
    );
  }
}
