import 'package:flutter/material.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';

import '../gen/assets/assets.gen.dart';

class AppFavoriteWidget extends StatefulWidget {
  const AppFavoriteWidget(
      {super.key, required this.isSelected, required this.onEvent});

  final bool isSelected;
  final VoidCallback onEvent;

  @override
  State<StatefulWidget> createState() => _AppFavoriteWidget();
}

class _AppFavoriteWidget extends State<AppFavoriteWidget> {
  bool _isSelected = false;

  @override
  void initState() {
    _isSelected = widget.isSelected;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onEvent();
        setState(() {
          _isSelected = !_isSelected;
        });
      },
      child: Container(
        margin: EdgeInsets.all(8),
        height: 32,
        width: 32,
        padding: EdgeInsets.all(6),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: _isSelected
                ? context.colors.buttonPrimary
                : context.colors.textPrimaryInverse),
        child: _isSelected
            ? Assets.images.icLiked.svg()
            : Assets.images.icLike.svg(),
      ),
    );
  }
}
