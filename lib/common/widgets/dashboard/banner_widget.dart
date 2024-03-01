import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/enum/enums.dart';
import 'package:shimmer/shimmer.dart';

import '../../../data/responses/banner/banner_response.dart';

class BannerWidget extends StatelessWidget {
  const BannerWidget(
      {super.key, required this.list, required this.loadingState});

  final List<BannerResponse> list;
  final LoadingState loadingState;

  @override
  Widget build(BuildContext context) {
    if (loadingState.name == "success") {
      return bannerWidget();
    } else {
      return shimmer();
    }
  }

  Widget bannerWidget() {
    return CarouselSlider(
      options:
          CarouselOptions(autoPlay: true, height: 140, viewportFraction: 1),
      items: list.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              child: CachedNetworkImage(
                imageUrl:
                    "https://api.online-bozor.uz/uploads/images/${i.image ?? ""}",
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(0),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.fill,
                      colorFilter:
                          ColorFilter.mode(Colors.white, BlendMode.colorBurn),
                    ),
                  ),
                ),
                placeholder: (context, url) => Center(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            );
          },
        );
      }).toList(),
    );
  }
  Widget shimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[350]!,
      highlightColor: Colors.grey[200]!,
      child: Container(
          height: 140,
          decoration: BoxDecoration(
              color: Color(0xFFF6F7FC), borderRadius: BorderRadius.circular(10))
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceAround,
          //     children: [
          //       Column(
          //         mainAxisAlignment: MainAxisAlignment.spaceAround,
          //        children: [
          //          Container(width: 120,height: 25,color: Colors.blue,),
          //          Container(width: 120,height: 25,color: Colors.blue,),
          //          Container(width: 120,height: 25,color: Colors.blue,),
          //
          //        ],
          //       ),
          //       Container(width: 120,height: 100,color: Colors.amber,)
          //
          //     ],
          //   ),
          ),
    );
  }
}
