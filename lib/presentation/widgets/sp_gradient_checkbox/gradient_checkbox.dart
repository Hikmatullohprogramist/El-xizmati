import 'package:flutter/material.dart';

class GradientCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;

  const GradientCheckbox({super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: Container(
        decoration: BoxDecoration(
          gradient: value
              ? LinearGradient(
            colors: const [Color(0xFF703EDB), Color(0xFF9A6AFF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )
              : null,
          borderRadius: BorderRadius.circular(3),
          border: !value? Border.all(
            color: Color(0xFF525252),
            width: 2,
          ):null,
        ),
        width: 20,
        height: 20,
        child: value
            ? Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 10,
                    )
            : null,
      ),
    );
  }
}