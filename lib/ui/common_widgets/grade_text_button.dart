import 'package:flutter/material.dart';
import 'package:grade/ui/utils/constants/app_colors.dart';

class GradeTextButton extends StatefulWidget {
  final String title;
  final IconData icon;
  final Function() onTap;

  const GradeTextButton({
    super.key,
    required this.title,
    required this.onTap,
    required this.icon,
  });

  @override
  State<GradeTextButton> createState() => _GradeTextButtonState();
}

class _GradeTextButtonState extends State<GradeTextButton> {
  bool _isActive = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      onHover: (value) {
        setState(() {
          _isActive = value;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        child: Row(
          children: [
            Icon(
              widget.icon,
              color: _isActive ? AppColors.blue : AppColors.grey3,
            ),
            const SizedBox(width: 26),
            Text(
              widget.title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: _isActive ? AppColors.blue : AppColors.grey3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
