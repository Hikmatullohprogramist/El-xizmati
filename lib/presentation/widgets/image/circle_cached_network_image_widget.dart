import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/core/cache/CustomCacheManager.dart';
import 'package:onlinebozor/presentation/support/colors/color_extension.dart';
import 'package:onlinebozor/data/datasource/network/constants/constants.dart';

class CircleCachedNetworkImage extends StatelessWidget {
  const CircleCachedNetworkImage({
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
          shape: BoxShape.circle,
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
        decoration: BoxDecoration(
          color: context.primaryContainer,
          shape: BoxShape.circle,
        ),
        child:
            placeHolderIcon != null ? Center(child: placeHolderIcon) : Center(),
      ),
      errorWidget: (context, url, error) => Container(
        decoration: BoxDecoration(
          color: context.primaryContainer,
          shape: BoxShape.circle,
        ),
        child: errorIcon != null ? Center(child: errorIcon) : Center(),
      ),
    );
  }
}
