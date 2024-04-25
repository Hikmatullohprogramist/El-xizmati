import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/constants.dart';
import 'package:onlinebozor/common/widgets/image/rectangle_cached_network_image_widget.dart';

class BannerWidget extends StatelessWidget {
  const BannerWidget({
    super.key,
    required this.imageId,
  });

  final String imageId;

  @override
  Widget build(BuildContext context) {
    return RectangleCachedNetworkImage(imageId: imageId);
  }
}
