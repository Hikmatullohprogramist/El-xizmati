import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/constants.dart';

class OrderDetailImageWidget extends StatelessWidget {
  const OrderDetailImageWidget({
    super.key,
    required this.imageId,
    required this.onClicked,
  });

  final String imageId;
  final Function(String imageId) onClicked;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      padding: EdgeInsets.only(left: 6, top: 0, right: 0),
      child: InkWell(
        onTap: () => onClicked(imageId),
        child: _getAdImageWidget(),
      ),
    );
  }

  Widget _getAdImageWidget() {
    return CachedNetworkImage(
      imageUrl: "${Constants.baseUrlForImage}$imageId",
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.white, BlendMode.colorBurn),
          ),
        ),
      ),
      placeholder: (context, url) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
      errorWidget: (context, url, error) => Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(6)),
        child: Center(child: Icon(Icons.error)),
      ),
    );
  }
}
