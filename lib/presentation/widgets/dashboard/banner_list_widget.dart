import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:El_xizmati/domain/models/banner/banner_image.dart';
import 'package:El_xizmati/presentation/widgets/dashboard/banner_widget.dart';
import 'package:El_xizmati/presentation/widgets/elevation/elevation_widget.dart';

class BannerListWidget extends StatelessWidget {
  final List<BannerImage> banners;

  const BannerListWidget({
    super.key,
    required this.banners,
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        height: 140,
        viewportFraction: 1,
      ),
      items: banners.map((banner) {
        return Builder(
          builder: (BuildContext context) {
            return ElevationWidget(
              topLeftRadius: 16,
              topRightRadius: 16,
              bottomLeftRadius: 16,
              bottomRightRadius: 16,
              leftMargin: 16,
              topMargin: 12,
              rightMargin: 20,
              bottomMargin: 2,
              child: BannerWidget(imageId: banner.imageId),
            );
          },
        );
      }).toList(),
    );
  }
}
