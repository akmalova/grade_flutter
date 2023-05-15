import 'package:flutter/material.dart';
import 'package:grade/ui/utils/constants/app_colors.dart';

class SideMenuItem extends StatelessWidget {
  final String title;
  final Widget icon;
  final List<Widget> children;

  const SideMenuItem({
    super.key,
    required this.title,
    required this.icon,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: AppColors.transparent),
      child: ExpansionTile(
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        tilePadding: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 20,
        ),
        collapsedIconColor: AppColors.grey3,
        collapsedTextColor: AppColors.grey3,
        iconColor: AppColors.grey3,
        textColor: AppColors.grey3,
        leading: icon,
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
          ),
        ),
        children: children,
      ),
    );
  }
}
