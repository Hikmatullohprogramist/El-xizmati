import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:El_xizmati/core/gen/assets/assets.gen.dart';
import 'package:El_xizmati/presentation/support/extensions/color_extension.dart';

class AdFavoriteWidget extends StatelessWidget {
  const AdFavoriteWidget({
    super.key,
    required this.isSelected,
    required this.onClicked,
    this.isChangeAvailable = true,
  });

  final bool isSelected;
  final VoidCallback onClicked;
  final bool isChangeAvailable;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onClicked();
        HapticFeedback.lightImpact();
      },
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(4),
        height: 30,
        width: 30,
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected
                ? context.textPrimaryInverse.withAlpha(100)
                : context.colors.buttonPrimary.withAlpha(150),
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(8),
          color: isSelected
              ? context.colors.buttonPrimary
              : context.textPrimaryInverse,
        ),
        child: isSelected
            ? Assets.images.icFavoriteRemove.svg()
            : Assets.images.icFavoriteAdd.svg(),
      ),
    );
  }
}
