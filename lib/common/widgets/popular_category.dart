import 'package:flutter/material.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';

class AppPopularCategory extends StatelessWidget {
  const AppPopularCategory(
      {super.key, required this.title, required this.image});

  final String title;
  final Widget image;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        width: 129,
        height: 132,
        decoration: BoxDecoration(
          color: Color(0xFFF6F7FC),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(width: 0.50, color: Color(0xFFE5E9F3)),
        ),
        child: Column(
          children: [
            Container(
              width: 72,
              height: 72,
              margin: EdgeInsets.symmetric(horizontal: 28, vertical: 12),
              decoration: ShapeDecoration(
                color: Color(0xFFDFE2E9),
                shape: OvalBorder(),
              ),
              child: image,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                  color: Color(0x28AEB2CD),
                  borderRadius: BorderRadius.circular(6)),
              child: Center(child: title.w(400).s(12)),
            )
          ],
        ),
      ),
    );
  }
}
