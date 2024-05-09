import 'dart:io';

import 'package:flutter/material.dart';
import 'package:onlinebozor/core/gen/assets/assets.gen.dart';
import 'package:onlinebozor/presentation/support/vibrator/vibrator_extension.dart';
import 'package:onlinebozor/domain/models/image/uploadable_file.dart';
import 'package:onlinebozor/presentation/widgets/image/rounded_cached_network_image_widget.dart';

class AdImageListImageWidget extends StatelessWidget {
  const AdImageListImageWidget({
    super.key,
    required this.index,
    required this.uploadableFile,
    required this.onImageClicked,
    required this.onRemoveClicked,
  });

  final int index;
  final UploadableFile uploadableFile;
  final Function() onImageClicked;
  final Function(UploadableFile uploadableFile) onRemoveClicked;

  @override
  Widget build(BuildContext context) {
    return Stack(
      key: ValueKey(uploadableFile),
      children: [
        InkWell(
          key: ValueKey(uploadableFile),
          onTap: () {
            onImageClicked();
            vibrateAsHapticFeedback();
          },
          child: Container(
            height: 82,
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
              child: uploadableFile.isNotUploaded()
                  ? Image.file(
                      File(uploadableFile.xFile?.path ?? ""),
                      fit: BoxFit.cover,
                    )
                  : RoundedCachedNetworkImage(imageId: uploadableFile.id!),
            ),
          ),
        ),
        Positioned(
          top: 6,
          right: 6,
          child: InkWell(
            onTap: () {
              onRemoveClicked(uploadableFile);
              vibrateAsHapticFeedback();
            },
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
              child: Assets.images.icRemove.svg(
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
