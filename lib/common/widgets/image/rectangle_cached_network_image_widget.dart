import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';

import '../../constants.dart';

class RectangleCachedNetworkImage extends StatelessWidget {
  const RectangleCachedNetworkImage({
    super.key,
    required this.imageId,
    this.imageWidth,
    this.imageHeight,
    this.isShowError = false,
  });

  final String imageId;
  final double? imageHeight;
  final double? imageWidth;
  final bool isShowError;

  @override
  Widget build(BuildContext context) {
    var actualUrl = imageId.contains("https://") || imageId.contains("http://")
        ? imageId
        : "${Constants.baseUrlForImage}$imageId";

    return CachedNetworkImage(
      width: imageWidth,
      height: imageHeight,
      imageUrl: actualUrl,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
            // colorFilter: ColorFilter.mode(
            //   Colors.white,
            //   BlendMode.colorBurn,
            // ),
          ),
        ),
      ),
      placeholder: (context, url) => Container(
        decoration: BoxDecoration(color: context.cardColor),
      ),
      errorWidget: (context, url, error) => Container(
        decoration: BoxDecoration(color: context.cardColor),
        child: isShowError ? Center(child: Icon(Icons.error)) : Center(),
      ),
    );
  }
}
