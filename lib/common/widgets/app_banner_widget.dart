import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/domain/model/banner/banner_response.dart';

class AppBannerWidget extends StatelessWidget {
  const AppBannerWidget({super.key, required this.list});

  final List<BannerResponse> list;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(autoPlay: true, aspectRatio: 2 / 1),
      items: list.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              child: CachedNetworkImage(
                imageUrl:
                    "https://api.online-bozor.uz/uploads/images/${i.image ?? ""}",
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.fill,
                        colorFilter: ColorFilter.mode(
                            Colors.white, BlendMode.colorBurn)),
                  ),
                ),
                placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
