import 'package:flutter/material.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';

class AppProductAndService extends StatelessWidget {
  final VoidCallback invoke;
  final String title;
  final Widget image;
  final Color color;
  final Color startColorGradient;
  final Color endColorGradient;

  const AppProductAndService(
      {required this.title,
      required this.image,
      required this.color,
      required this.startColorGradient,
      required this.endColorGradient,
      required this.invoke,
      super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: invoke,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: Container(
            width: double.infinity,
            height: 200,
            decoration: ShapeDecoration(
              gradient: LinearGradient(
                begin: Alignment(0.00, 1.00),
                end: Alignment(0, -1),
                colors: [startColorGradient, endColorGradient],
              ),
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 0.50, color: color),
                borderRadius: BorderRadius.circular(6),
              ),
              shadows: const [
                BoxShadow(
                  color: Color(0x196B7194),
                  blurRadius: 0,
                  offset: Offset(0, 0),
                  spreadRadius: 0,
                ),
                BoxShadow(
                  color: Color(0x196B7194),
                  blurRadius: 2,
                  offset: Offset(0, 1),
                  spreadRadius: 0,
                ),
                BoxShadow(
                  color: Color(0x166B7194),
                  blurRadius: 3,
                  offset: Offset(0, 3),
                  spreadRadius: 0,
                ),
                BoxShadow(
                  color: Color(0x0C6B7194),
                  blurRadius: 4,
                  offset: Offset(0, 6),
                  spreadRadius: 0,
                ),
                BoxShadow(
                  color: Color(0x026B7194),
                  blurRadius: 5,
                  offset: Offset(0, 11),
                  spreadRadius: 0,
                ),
                BoxShadow(
                  color: Color(0x006B7194),
                  blurRadius: 5,
                  offset: Offset(0, 18),
                  spreadRadius: 0,
                )
              ],
            ),
            child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Stack(children: [
                Positioned(
                    left: 8,
                    top: 8,
                    child: title
                        .w(700)
                        .s(20)
                        .c(context.colors.textPrimaryInverse)),
                Container(
                  alignment: Alignment.bottomRight,
                  child: image,
                )
              ]),
            ),
          ),
        ));
  }
}
