import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/presentation/widgets/dashboard/banner_widget.dart';

import '../../../data/datasource/network/responses/banner/banner_response.dart';

class BannerListWidget extends StatelessWidget {
  const BannerListWidget({super.key, required this.list});

  final List<BannerResponse> list;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        height: 140,
        viewportFraction: 1,
      ),
      items: list.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return BannerWidget(imageId: i.image ?? "");
          },
        );
      }).toList(),
    );
  }
}
