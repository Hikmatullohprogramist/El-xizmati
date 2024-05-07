import 'package:flutter/material.dart';
import 'package:onlinebozor/core/colors/color_extension.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';

class ProductOrService extends StatelessWidget {
  final VoidCallback invoke;
  final String title;
  final Widget image;
  final Color color;
  final Color startColorGradient;
  final Color endColorGradient;

  const ProductOrService(
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
        child: Container(
          width: 129,
          height: 56,
          decoration: ShapeDecoration(
            gradient: LinearGradient(
              begin: Alignment(0.00, 1.00),
              end: Alignment(0, -1),
              colors: [startColorGradient, endColorGradient],
            ),
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 0.50, color: color),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Stack(children: [
              Positioned(
                  left: 8,
                  top: 8,
                  child:
                      title.w(700).s(16).c(context.colors.textPrimaryInverse)),
              Container(
                // margin: EdgeInsets.only(right: 0.5, bottom: 0.5),
                padding: EdgeInsets.all(2),
                alignment: Alignment.bottomRight,
                child: image,
              )
            ]),
          ),
        ));
  }
}
