import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BannerWidget extends StatelessWidget {
  const BannerWidget({
    super.key,
    required this.imageUrl,
  });

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: "https://api.online-bozor.uz/uploads/images/$imageUrl",
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0),
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.fill,
            colorFilter: ColorFilter.mode(Colors.white, BlendMode.colorBurn),
          ),
        ),
      ),
      placeholder: (context, url) => Center(),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }
}
