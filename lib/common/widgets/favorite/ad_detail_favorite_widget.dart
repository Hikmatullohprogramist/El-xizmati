import 'package:flutter/material.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';

import '../../gen/assets/assets.gen.dart';

class AdDetailFavoriteWidget extends StatefulWidget {
  const AdDetailFavoriteWidget({
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

class _AdFavoriteWidget extends State<AdDetailFavoriteWidget> {
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
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.all(10),
        height: 56,
        width: 56,
        child: _isSelected
            ? Assets.images.icFavoriteRemoveDetail.svg()
            : Assets.images.icFavoriteAddDetail.svg(),
      ),
    );
  }
}
