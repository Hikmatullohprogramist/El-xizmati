import 'package:flutter/material.dart';

import '../../gen/assets/assets.gen.dart';

class AddAdPickImageWidget extends StatelessWidget {
  const AddAdPickImageWidget({
    super.key,
    required this.onAddClicked,
  });

  final Function() onAddClicked;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onAddClicked(),
      child: Container(
        height: 96,
        width: 96,
        decoration: BoxDecoration(
          color: Color(0XFFFBFAFF),
          borderRadius: BorderRadius.circular(10),
          shape: BoxShape.rectangle,
          border: Border.all(
            color: Color(0xFFDFE2E9),
            width: 1,
          ),
        ),
        child: IconButton(
          onPressed: () => onAddClicked(),
          icon: Assets.images.icAddImage.svg(height: 32, width: 32),
        ),
      ),
    );
  }
}
