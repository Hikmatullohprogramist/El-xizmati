import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/constants.dart';
import 'package:onlinebozor/common/widgets/ads_property_widget.dart';
import 'package:onlinebozor/common/widgets/ads_route_widget.dart';
import 'package:onlinebozor/common/widgets/ads_status_widget.dart';
import 'package:onlinebozor/common/widgets/favorite_widget.dart';

import '../gen/assets/assets.gen.dart';

class AppAdsHorizontalWidget extends StatelessWidget {
  const AppAdsHorizontalWidget(
      {super.key,
      required this.title,
      required this.price,
      required this.location,
      required this.adsStatusType,
      required this.adsPropertyType,
      required this.adsRouteType});

  final Widget title;
  final Widget price;
  final Widget location;
  final AdsStatusType adsStatusType;
  final AdsPropertyType adsPropertyType;
  final AdsRouteType adsRouteType;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 342,
      width: 140,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              width: 140,
              height: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(width: 0.50, color: Color(0xFFE5E9F3)),
                color: Color(0xFFF6F7FC),
              ),
              child: Stack(children: [
                CachedNetworkImage(
                  imageUrl: "http://via.placeholder.com/200x150",
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                              Colors.white, BlendMode.colorBurn)),
                    ),
                  ),
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
                AppAdsStatusWidget(adsStatusType: adsStatusType),
                Align(
                    alignment: Alignment.topRight,
                    child: AppFavoriteWidget(
                      isSelected: true,
                      onEvent: () {},
                    ))
              ])),
          SizedBox(height: 12),
          title,
          SizedBox(height: 22),
          price,
          SizedBox(height: 14),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Assets.images.icLocation.svg(width: 12, height: 12),
            SizedBox(width: 4),
            Expanded(child: location)
          ]),
          SizedBox(height: 12),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            AppAdsRouterWidget(adsRouteType: adsRouteType),
            SizedBox(width: 5),
            AppAdsPropertyWidget(adsPropertyType: adsPropertyType)
          ])
        ],
      ),
    );
  }
}
