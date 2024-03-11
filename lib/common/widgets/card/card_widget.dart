import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../gen/assets/assets.gen.dart';

class CardWidget extends StatelessWidget {
  const CardWidget(
      {super.key,
      required this.listener,
      required this.image,
      required this.listenerEdit});

  final VoidCallback listener;
  final VoidCallback listenerEdit;
  final String image;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: listener,
      child: Stack(
        children: [
          Container(
            height: 160,
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: CachedNetworkImage(
              imageUrl: "${Constants.baseUrlForImage}$image",
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.fill,
                    colorFilter: ColorFilter.mode(
                      Colors.grey,
                      BlendMode.colorBurn,
                    ),
                  ),
                ),
              ),
              placeholder: (context, url) => Center(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: IconButton(
                icon: Assets.images.icSetting.svg(height: 24, width: 24),
                onPressed: listenerEdit,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
