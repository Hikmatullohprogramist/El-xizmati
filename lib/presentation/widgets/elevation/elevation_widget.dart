import 'package:flutter/widgets.dart';
import 'package:onlinebozor/presentation/support/extensions/color_extension.dart';

class ElevationWidget extends StatelessWidget {
  final Color? backgroundColor;
  final Color? shadowColor;
  final double shadowSpreadRadius;
  final double shadowBlurRadius;
  final double shadowOffsetDx;
  final double shadowOffsetDy;
  final double leftMargin;
  final double topMargin;
  final double rightMargin;
  final double bottomMargin;
  final double topLeftRadius;
  final double topRightRadius;
  final double bottomLeftRadius;
  final double bottomRightRadius;
  final Widget child;

  const ElevationWidget({
    super.key,
    required this.child,
    this.backgroundColor,
    this.shadowColor,
    this.shadowSpreadRadius = 0.5,
    this.shadowBlurRadius = 0.5,
    this.shadowOffsetDx = 0.0,
    this.shadowOffsetDy = 0.0,
    this.leftMargin = 0,
    this.topMargin = 0,
    this.rightMargin = 0,
    this.bottomMargin = 0,
    this.topLeftRadius = 0,
    this.topRightRadius = 0,
    this.bottomLeftRadius = 0,
    this.bottomRightRadius = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: leftMargin,
        top: topMargin,
        right: rightMargin,
        bottom: bottomMargin,
      ),
      decoration: BoxDecoration(
        color: backgroundColor ?? context.elevatedColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(topLeftRadius),
          topRight: Radius.circular(topRightRadius),
          bottomLeft: Radius.circular(bottomLeftRadius),
          bottomRight: Radius.circular(bottomRightRadius),
        ),
        boxShadow: [
          BoxShadow(
            color: shadowColor ?? context.textPrimary.withOpacity(0.1),
            spreadRadius: shadowSpreadRadius,
            blurRadius: shadowSpreadRadius,
            offset: Offset(shadowOffsetDx, shadowOffsetDy),
          ),
        ],
      ),
      child: child,
    );
  }
}
