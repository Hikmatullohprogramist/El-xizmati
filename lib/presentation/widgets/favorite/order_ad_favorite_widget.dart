import 'package:flutter/material.dart';
import 'package:El_xizmati/core/gen/assets/assets.gen.dart';
import 'package:flutter/services.dart';

class OrderAdFavoriteWidget extends StatelessWidget {
  const OrderAdFavoriteWidget({
    super.key,
    required this.isFavorite,
    required this.onClicked,
    this.size = 32,
  });

  final bool isFavorite;
  final VoidCallback onClicked;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(6),
        onTap: () {
          onClicked();
          HapticFeedback.lightImpact();
        },
        child: Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              width: 1,
              color: Color(0xFFDFE2E9),
            ),
          ),
          height: size,
          width: size,
          child: isFavorite
              ? Assets.images.icFavoriteRemove.svg(color: Colors.red)
              : Assets.images.icFavoriteAdd.svg(),
        ),
      ),
    );
  }
}
