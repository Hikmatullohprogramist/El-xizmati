import 'package:flutter/material.dart';

class AppCommodityAndService extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget title;
  final Widget image;
  final Color color;
  final Color startColorGradient;
  final Color endColorGradient;

  const AppCommodityAndService(
      {required this.title,
      required this.image,
      required this.color,
      required this.startColorGradient,
      required this.endColorGradient,
      required this.onPressed,
      super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: Container(
            width: double.infinity,
            height: 180,
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
                ),
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
