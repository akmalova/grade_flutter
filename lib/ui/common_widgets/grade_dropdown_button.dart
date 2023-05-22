import 'package:flutter/material.dart';

class GradeDropdownButton extends StatefulWidget {
  final String dropdownValue;
  final Function(String?) onChanged;
  final List<String> values;

  const GradeDropdownButton({
    Key? key,
    required this.dropdownValue,
    required this.onChanged,
    required this.values,
  }) : super(key: key);

  @override
  State<GradeDropdownButton> createState() => _GradeDropdownButtonState();
}

class _GradeDropdownButtonState extends State<GradeDropdownButton> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: widget.dropdownValue,
      underline: Container(),
      items: widget.values.map<DropdownMenuItem<String>>(
        (String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          );
        },
      ).toList(),
      onChanged: widget.onChanged,
    );
  }
}
