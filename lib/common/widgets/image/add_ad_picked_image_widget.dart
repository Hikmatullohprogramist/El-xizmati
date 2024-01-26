import 'dart:io';

import 'package:flutter/material.dart';

import '../../gen/assets/assets.gen.dart';

class AddAdPickedImageWidget extends StatelessWidget {
  const AddAdPickedImageWidget({
    super.key,
    required this.imagePath,
    required this.onImageClicked,
    required this.onRemoveClicked,
  });

  final String imagePath;
  final Function() onImageClicked;
  final Function(String imagePath) onRemoveClicked;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: () => onImageClicked(),
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
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              // This should match the Container's borderRadius
              child: Image.file(
                File(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: InkWell(
            onTap: () => onRemoveClicked(imagePath),
            child: Container(
              height: 24,
              width: 24,
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Color(0xE6B94747),
                borderRadius: BorderRadius.all(Radius.circular(8)),
                border: Border.all(
                  color: Colors.white,
                  width: 0.5,
                ),
                shape: BoxShape.rectangle,
              ),
              child: Assets.images.icClose.svg(
                fit: BoxFit.fill,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
