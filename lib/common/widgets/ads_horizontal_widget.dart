import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/constants.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/widgets/ads_property_widget.dart';
import 'package:onlinebozor/common/widgets/ads_route_widget.dart';
import 'package:onlinebozor/common/widgets/ads_status_widget.dart';
import 'package:onlinebozor/common/widgets/favorite_widget.dart';
import 'package:onlinebozor/domain/model/ads/ads_response.dart';

import '../gen/assets/assets.gen.dart';

class AppAdsHorizontalWidget extends StatelessWidget {
  const AppAdsHorizontalWidget({
    super.key,
    this.onClickFavorite,
    this.onClick,
  });

  final Function(String adsResponse)? onClick;
  final Function(String adsResponse)? onClickFavorite;

  // final AdsResponse? adsResponse;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          onClick!("onClick in AppAdsHorizontalWidget");
        },
        child: SizedBox(
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
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                    AppAdsStatusWidget(adsStatusType: AdsStatusType.standard),
                    Align(
                        alignment: Alignment.topRight,
                        child: AppFavoriteWidget(
                          isSelected: true,
                          onEvent: () {
                            onClickFavorite!(
                                "AppFavoriteWidget in Ads Horizontal Widget");
                          },
                        ))
                  ])),
              SizedBox(height: 12),
              "Kitob sotaman  yaqinda olingan, Kitob sotaman  yaqinda olingan "
                  .w(400)
                  .s(10)
                  .c(context.colors.textPrimary)
                  .copyWith(maxLines: 2),
              SizedBox(height: 22),
              "20-30 ".w(700).s(10),
              SizedBox(height: 14),
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Assets.images.icLocation.svg(width: 12, height: 12),
                SizedBox(width: 4),
                Expanded(
                  child: "Namangan viloyat Pop tumani"
                      .w(400)
                      .s(10)
                      .c(context.colors.textSecondary)
                      .copyWith(
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                      ),
                )
              ]),
              SizedBox(height: 12),
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                AppAdsRouterWidget(adsRouteType: RouteType.PRIVATE),
                SizedBox(width: 5),
                AppAdsPropertyWidget(adsPropertyType: PropertyStatus.USED)
              ])
            ],
          ),
        ));
  }
}
