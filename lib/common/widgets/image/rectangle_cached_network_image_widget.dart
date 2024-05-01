import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/cache/CustomCacheManager.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';

import '../../constants.dart';

class RectangleCachedNetworkImage extends StatelessWidget {
  const RectangleCachedNetworkImage({
    super.key,
    required this.imageId,
    this.imageWidth,
    this.imageHeight,
    this.placeHolderIcon,
    this.errorIcon,
  });

  final String imageId;
  final double? imageHeight;
  final double? imageWidth;
  final Widget? placeHolderIcon;
  final Widget? errorIcon;

  @override
  Widget build(BuildContext context) {
    var actualUrl = imageId.contains("https://") || imageId.contains("http://")
        ? imageId
        : "${Constants.baseUrlForImage}$imageId";

    return CachedNetworkImage(
      width: imageWidth,
      height: imageHeight,
      imageUrl: actualUrl,
      cacheManager: CustomCacheManager.imageCacheManager,
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
        decoration: BoxDecoration(color: context.primaryContainer),
        child:
            placeHolderIcon != null ? Center(child: placeHolderIcon) : Center(),
      ),
      errorWidget: (context, url, error) => Container(
        decoration: BoxDecoration(color: context.primaryContainer),
        child: errorIcon != null ? Center(child: errorIcon) : Center(),
      ),
    );
  }
}
