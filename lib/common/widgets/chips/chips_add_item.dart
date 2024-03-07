import 'package:flutter/material.dart';

class ChipsAddItem extends StatelessWidget {
  const ChipsAddItem({
    super.key,
    required this.onChipClicked,
  });

  final Function() onChipClicked;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChipClicked();
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
