import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/constants.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/widgets/ad/ad_property_widget.dart';
import 'package:onlinebozor/common/widgets/ad/ad_route_widget.dart';
import 'package:onlinebozor/common/widgets/ad/ad_status_widget.dart';
import 'package:onlinebozor/common/widgets/favorite_widget.dart';
import 'package:onlinebozor/domain/model/ad/ad_response.dart';

import '../../gen/assets/assets.gen.dart';

class AppAdHorizontalWidget extends StatelessWidget {
  const AppAdHorizontalWidget({
    super.key,
    required this.onClickFavorite,
    required this.onClick,
    required this.result,
  });

  final AdResponse result;
  final Function(AdResponse result) onClick;
  final Function(AdResponse result) onClickFavorite;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          onClick(result);
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
                      imageUrl:
                          "${Constants.baseUrlForImage}${result.photos?.first.image ?? ''}",
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
                          Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                          Center(child: Icon(Icons.error)),
                    ),
                    AppAdStatusWidget(adsStatusType: AdsStatusType.standard),
                    Align(
                        alignment: Alignment.topRight,
                        child: AppFavoriteWidget(
                          isSelected: false,
                          onEvent: () {
                            onClickFavorite(result);
                          },
                        ))
                  ])),
              SizedBox(height: 12),
              SizedBox(
                height: 28,
                child: (result.name ?? "")
                    .w(400)
                    .s(13)
                    .c(context.colors.textPrimary)
                    .copyWith(maxLines: 2),
              ),
              SizedBox(height: 22),
              if (result.price == 0)
                "${result.from_price}-${result.from_price} so'm".w(700).s(15)
              else
                "${result.price.toString()} so'm".w(700).s(15),
              SizedBox(height: 14),
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Assets.images.icLocation.svg(width: 12, height: 12),
                SizedBox(width: 4),
                Expanded(
                  child: "${result.region} ${result.district}"
                      .w(400)
                      .s(12)
                      .c(context.colors.textSecondary)
                      .copyWith(
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                      ),
                )
              ]),
              SizedBox(height: 12),
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                AppAdRouterWidget(
                    adsRouteType: result.route_type ?? RouteType.PRIVATE),
                SizedBox(width: 5),
                AppAdPropertyWidget(
                    adsPropertyType:
                        result.property_status ?? PropertyStatus.USED)
              ])
            ],
          ),
        ));
  }
}
