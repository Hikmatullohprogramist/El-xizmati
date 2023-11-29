import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/extensions/currency_extensions.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/widgets/ad/ad_property_widget.dart';
import 'package:onlinebozor/common/widgets/ad/ad_route_widget.dart';
import 'package:onlinebozor/common/widgets/ad/ad_status_widget.dart';
import 'package:onlinebozor/common/widgets/ad/ad_type_widget.dart';
import 'package:onlinebozor/common/widgets/favorite/favorite_widget.dart';
import 'package:onlinebozor/domain/mapper/ad_enum_mapper.dart';
import 'package:onlinebozor/common/enum/enums.dart';
import 'package:onlinebozor/domain/model/ad.dart';

import '../../constants.dart';
import '../../gen/assets/assets.gen.dart';

class AppAdHorizontalWidget extends StatelessWidget {
  const AppAdHorizontalWidget({
    super.key,
    required this.onClickFavorite,
    required this.onClick,
    required this.result,
  });

  final Ad result;
  final Function(Ad result) onClick;
  final Function(Ad result) onClickFavorite;

  @override
  Widget build(BuildContext context) {
    var formatter = NumberFormat('###,000');
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
                      imageUrl: "${Constants.baseUrlForImage}${result.photo}",
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
                      placeholder: (context, url) => Center(),
                      errorWidget: (context, url, error) =>
                          Center(child: Icon(Icons.error)),
                    ),
                    AppAdStatusWidget(adsStatusType: AdStatusType.standard),
                    Align(
                        alignment: Alignment.topRight,
                        child: AppFavoriteWidget(
                          isSelected: result.favorite,
                          onEvent: () {
                            onClickFavorite(result);
                          },
                        )),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: AppAdTypeWidget(adType: result.adTypeStatus.adType()),
                    )
                  ])),
              SizedBox(height: 12),
              SizedBox(
                height: 32,
                child: (result.name)
                    .w(400)
                    .s(13)
                    .c(context.colors.textPrimary)
                    .copyWith(maxLines: 2)
                    .copyWith(maxLines: 2, overflow: TextOverflow.ellipsis),
              ),
              SizedBox(height: 6),
              if (result.price == 0)
                "${formatter.format(result.toPrice).replaceAll(',', ' ')}-${formatter.format(result.fromPrice).replaceAll(',', ' ')} ${Currency.uzb.getName}"
                    .w(700)
                    .s(15)
                    .copyWith(maxLines: 1, overflow: TextOverflow.ellipsis)
              else
                "${formatter.format(result.price).replaceAll(',', ' ')} ${Currency.uzb.getName}"
                    .w(700)
                    .s(15)
                    .copyWith(maxLines: 1, overflow: TextOverflow.ellipsis),
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
                    isHorizontal: true, adRouteType: result.adRouteType),
                SizedBox(width: 2),
                AppAdPropertyWidget(
                    isHorizontal: true, adPropertyType: result.adPropertyStatus)
              ])
            ],
          ),
        ));
  }
}
