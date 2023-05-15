import 'package:flutter/material.dart';

class TypesDropdownButton extends StatefulWidget {
  final String dropdownValue;
  final Function(String?) onChanged;

  const TypesDropdownButton({
    super.key,
    required this.dropdownValue,
    required this.onChanged,
  });

  @override
  State<TypesDropdownButton> createState() => _TypesDropdownButtonState();
}

class _TypesDropdownButtonState extends State<TypesDropdownButton> {
  final List<String> list = ['Студенты', 'Преподаватели', 'Дисциплины'];
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: widget.dropdownValue,
      underline: Container(),
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
        );
      }).toList(),
      onChanged: widget.onChanged,
    );
  }
}
