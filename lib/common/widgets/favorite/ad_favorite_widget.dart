import 'package:flutter/material.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';

import '../../gen/assets/assets.gen.dart';

class AdFavoriteWidget extends StatefulWidget {
  const AdFavoriteWidget({
    super.key,
    required this.isSelected,
    required this.invoke,
    this.isChangeAvailable = true,
  });

  final bool isSelected;
  final VoidCallback invoke;
  final bool isChangeAvailable;

  @override
  State<StatefulWidget> createState() => _AdFavoriteWidget();
}

class _AdFavoriteWidget extends State<AdFavoriteWidget> {
  bool _isSelected = false;

  @override
  void initState() {
    super.initState();
    _isSelected = widget.isSelected;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.invoke();
        if (widget.isChangeAvailable) {
          setState(() {
            _isSelected = !_isSelected;
          });
        }
      },
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(4),
        height: 30,
        width: 30,
        decoration: BoxDecoration(
          border: Border.all(
            color: context.colors.textPrimaryInverse.withAlpha(150),
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(8),
          color: _isSelected
              ? context.colors.buttonPrimary
              : context.colors.textPrimaryInverse,
        ),
        child: _isSelected
            ? Assets.images.icFavoriteRemove.svg()
            : Assets.images.icFavoriteAdd.svg(),
      ),
    );
  }
}
