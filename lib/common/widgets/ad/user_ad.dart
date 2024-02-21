import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/assets/assets.gen.dart';
import 'package:onlinebozor/common/vibrator/vibrator_extension.dart';
import 'package:onlinebozor/common/widgets/ad/list_price_text_widget.dart';
import 'package:onlinebozor/common/widgets/ad/user_ad_stats_widget.dart';
import 'package:onlinebozor/data/responses/user_ad/user_ad_response.dart';
import 'package:onlinebozor/domain/mappers/ad_enum_mapper.dart';

import '../../constants.dart';

class UserAdWidget extends StatelessWidget {
  const UserAdWidget({
    super.key,
    required this.onActionClicked,
    required this.onItemClicked,
    required this.response,
  });

  final UserAdResponse response;
  final VoidCallback onActionClicked;
  final VoidCallback onItemClicked;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: EdgeInsets.only(left: 12, top: 12, right: 12),
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(width: 1, color: Color(0xFFE5E9F3)),
      ),
      child: InkWell(
          onTap: onItemClicked,
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 110,
                    height: 110,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(width: 0.50, color: Color(0xFFE5E9F3)),
                      color: Color(0xFFF6F7FC),
                    ),
                    child: _getAdImageWidget(),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          (response.name ?? "")
                              .w(600)
                              .s(14)
                              .c(Color(0xFF41455E))
                              .copyWith(
                              maxLines: 3, overflow: TextOverflow.ellipsis),
                          SizedBox(height: 4),
                          (response.category?.name ?? "*")
                              .w(500)
                              .s(14)
                              .c(Color(0xFF9EABBE))
                              .copyWith(
                              maxLines: 1, overflow: TextOverflow.ellipsis),
                          SizedBox(height: 12),
                          Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: ListPriceTextWidget(
                                price: response.price ?? 0,
                                toPrice: response.to_price ?? 0,
                                fromPrice: response.from_price ?? 0,
                                currency: response.currency.toCurrency()),
                          ),
                        ],
                      ))
                ],
              ),
              SizedBox(height: 2),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  AdStatsWidget(
                      icon: Assets.images.icViewCount, count: response.view),
                  SizedBox(width: 8),
                  AdStatsWidget(
                      icon: Assets.images.icFavoriteRemove,
                      count: response.selected),
                  SizedBox(width: 6),
                  AdStatsWidget(
                      icon: Assets.images.icCall, count: response.phone_view),
                  SizedBox(width: 6),
                  AdStatsWidget(
                      icon: Assets.images.icAdMessage,
                      count: response.message_number),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            onPressed: () {
                              onActionClicked();
                              vibrateAsHapticFeedback();
                            },
                            icon: Assets.images.icMoreVert
                                .svg(width: 24, height: 24)),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 6)
            ],
          )),
    );
  }

  Widget _getAdImageWidget() {
    return CachedNetworkImage(
      imageUrl: "${Constants.baseUrlForImage}${response.main_photo ?? ""}",
      imageBuilder: (context, imageProvider) =>
          Container(
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
      errorWidget: (context, url, error) => Center(child: Icon(Icons.error)),
    );
  }
}
