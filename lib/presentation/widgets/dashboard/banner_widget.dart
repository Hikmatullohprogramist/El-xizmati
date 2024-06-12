import 'package:flutter/material.dart';
import 'package:onlinebozor/presentation/widgets/image/rounded_cached_network_image_widget.dart';

class BannerWidget extends StatelessWidget {
  const BannerWidget({
    super.key,
    required this.imageId,
  });

  final String imageId;

  @override
  Widget build(BuildContext context) {
    return RoundedCachedNetworkImage(imageId: imageId);
  }
}
