import 'package:flutter/material.dart';
import 'package:grade/ui/utils/constants/app_colors.dart';

class SideMenuSubitem extends StatefulWidget {
  final String title;
  final Function() onTap;

  const SideMenuSubitem({super.key, required this.title, required this.onTap});

  @override
  State<SideMenuSubitem> createState() => _SideMenuSubitemState();
}

class _SideMenuSubitemState extends State<SideMenuSubitem> {
  bool _isActive = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onHover: (value) {
        setState(() {
          _isActive = value;
        });
      },
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 5,
        ),
        child: Text(
          widget.title,
          style: TextStyle(
            color: _isActive ? AppColors.blue : AppColors.black,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
