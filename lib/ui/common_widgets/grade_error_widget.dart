import 'package:flutter/material.dart';
import 'package:grade/ui/utils/constants/app_colors.dart';
import 'package:grade/ui/common_widgets/grade_button.dart';

class GradeErrorWidget extends StatefulWidget {
  final String title;
  final String? errorText;
  final String description;
  final Function() onTap;

  const GradeErrorWidget({
    super.key,
    this.title = 'Ошибка',
    this.errorText,
    required this.description,
    required this.onTap,
  });

  @override
  State<GradeErrorWidget> createState() => _GradeErrorWidgetState();
}

class _GradeErrorWidgetState extends State<GradeErrorWidget> {
  late bool _isErrorOpened;

  @override
  void initState() {
    _isErrorOpened = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.error,
            color: AppColors.red,
            size: 80,
          ),
          const SizedBox(height: 15),
          Text(
            widget.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.red,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            widget.description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          if (widget.errorText != null)
            Column(
              children: [
                const SizedBox(height: 5),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _isErrorOpened = !_isErrorOpened;
                    });
                  },
                  child: Text(
                    '${_isErrorOpened ? 'Скрыть' : 'Показать'} подробности',
                  ),
                ),
                const SizedBox(height: 5),
                if (_isErrorOpened)
                  Text(
                    widget.errorText!,
                  ),
              ],
            ),
          const SizedBox(height: 15),
          const Divider(),
          const SizedBox(height: 15),
          GradeButton(
            title: 'Вернуться',
            onTap: widget.onTap,
          )
        ],
      ),
    );
  }
}
