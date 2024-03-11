import 'package:flutter/material.dart';

class ChipAddItem extends StatelessWidget {
  const ChipAddItem({
    super.key,
    required this.onClicked,
  });

  final Function() onClicked;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onClicked();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          border: Border.all(width: 1, color: Color(0xFF5C6AC4)),
        ),
        child: Icon(Icons.add),
      ),
    );
  }
}
