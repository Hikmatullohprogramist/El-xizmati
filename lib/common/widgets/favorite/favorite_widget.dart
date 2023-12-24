import 'package:flutter/material.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';

import '../../gen/assets/assets.gen.dart';

class AppFavoriteWidget extends StatefulWidget {
   AppFavoriteWidget(
      {super.key,
      required this.isSelected,
      required this.invoke,this.beChange = true});

  final bool isSelected;
  final VoidCallback invoke;
  bool beChange ;

  @override
  State<StatefulWidget> createState() => _AppFavoriteWidget();
}

class _AppFavoriteWidget extends State<AppFavoriteWidget> {
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
        if (widget.beChange) {
          setState(() {
            _isSelected = !_isSelected;
          });
        }
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
