import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/constants.dart';
import 'package:onlinebozor/common/extensions/currency_extensions.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/widgets/ad/ad_property_widget.dart';
import 'package:onlinebozor/common/widgets/ad/ad_status_widget.dart';
import 'package:onlinebozor/common/widgets/favorite_widget.dart';

import '../../../data/model/ads/ad/ad_response.dart';
import '../../enum/ad_enum.dart';
import '../../gen/assets/assets.gen.dart';
import 'ad_route_widget.dart';

class AppAdWidget extends StatelessWidget {
  const AppAdWidget({
    super.key,
    this.onClickFavorite,
    this.onClick,
    required this.result,
  });

  final AdResponse result;
  final Function(AdResponse result)? onClick;
  final Function(AdResponse result)? onClickFavorite;

  @override
  Widget build(BuildContext context) {
    var formatter = NumberFormat('###,000');
    return InkWell(
        onTap: () {
          onClick!(result);
        },
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  width: double.infinity,
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
                      placeholder: (context, url) => Center(),
                      errorWidget: (context, url, error) =>
                          Center(child: Icon(Icons.error)),
                    ),
                    AppAdStatusWidget(adsStatusType: AdStatusType.standard),
                    Align(
                        alignment: Alignment.topRight,
                        child: AppFavoriteWidget(
                          isSelected: false,
                          onEvent: () {
                            onClickFavorite!(result);
                          },
                        ))
                  ])),
              SizedBox(height: 12),
              SizedBox(
                height: 32,
                child: (result.name ?? "")
                    .w(400)
                    .s(13)
                    .c(context.colors.textPrimary)
                    .copyWith(maxLines: 2, overflow: TextOverflow.ellipsis),
              ),
              SizedBox(height: 6),
              if (result.price == 0)
                "${formatter.format(result.to_price).replaceAll(',', ' ')}-${formatter.format(result.from_price).replaceAll(',', ' ')} ${Currency.UZB.getName}"
                    .w(700)
                    .s(15)
                    .copyWith(maxLines: 1, overflow: TextOverflow.ellipsis)
              else
                "${formatter.format(result.price).replaceAll(',', ' ')} ${Currency.UZB.getName}"
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
              Row(mainAxisAlignment: MainAxisAlignment.start, children: const [
                AppAdRouterWidget(
                    isHorizontal: false,
                    adRouteType:AdRouteType.business),
                SizedBox(width: 5),
                AppAdPropertyWidget(
                    isHorizontal: false,
                    adsPropertyType:
                       AdPropertyStatuses.used)
              ])
            ],
          ),
        ));
  }
}
