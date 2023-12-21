import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/assets/assets.gen.dart';
import 'package:onlinebozor/common/widgets/ad/price_widget.dart';
import 'package:onlinebozor/data/responses/user_ad/user_ad_response.dart';
import 'package:onlinebozor/domain/mappers/ad_enum_mapper.dart';

import '../../constants.dart';

class UserAdWidget extends StatelessWidget {
  const UserAdWidget({
    super.key,
    required this.listenerAddressEdit,
    required this.listener,
    required this.response,
  });

  final UserAdResponse response;
  final VoidCallback listenerAddressEdit;
  final VoidCallback listener;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: listener,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                      width: 80,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(width: 0.50, color: Color(0xFFE5E9F3)),
                        color: Color(0xFFF6F7FC),
                      ),
                      child: CachedNetworkImage(
                        imageUrl:
                            "${Constants.baseUrlForImage}${response.main_photo ?? ""}",
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
                      )),
                  SizedBox(width: 12),
                  Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                          Flexible(
                            child: (response.name ?? "")
                                .w(600)
                                .s(14)
                                .c(Color(0xFF41455E))
                                .copyWith(
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis),
                          ),
                          IconButton(
                              onPressed: listenerAddressEdit,
                              icon: Assets.images.icMoreVert
                                  .svg(width: 24, height: 24)),
                        ],
                      ),
                      SizedBox(height: 27),
                      Row(
                        children: [
                          "Miqdori:".w(400).s(12).c(Color(0xFF9EABBE)),
                          SizedBox(width: 2),
                          "1".w(500).s(12).c(Color(0xFF41455E)),
                          Flexible(
                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child: AppPriceWidget(
                                      price: response.price ?? 0,
                                      toPrice: response.to_price ?? 0,
                                      fromPrice: response.from_price ?? 0,
                                      currency:
                                          response.currency.toCurrency())))
                          // "473 769 560 сум".w(700).s(12).c(Color(0xFF5C6AC3))
                        ],
                      ),
                      SizedBox(height: 8),
                          (response.name ?? "*")
                          .w(400)
                          .s(12)
                          .c(Color(0xFF9EABBE))
                          .copyWith(
                              maxLines: 1, overflow: TextOverflow.ellipsis)
                    ],
                  ))
                ],
              ),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(width: 1, color: Color(0xFFDADDE5)),
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Assets.images.icEye.svg(
                              height: 12,
                              width: 12,
                              color: context.colors.iconGrey),
                          SizedBox(width: 8),
                          (response.view ?? 0)
                              .toString()
                              .w(600)
                              .s(10)
                              .c(Color(0xFF41455E))
                        ]),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(width: 1, color: Color(0xFFDADDE5)),
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Assets.images.icLiked.svg(
                              height: 12,
                              width: 12,
                              color: context.colors.iconGrey),
                          SizedBox(width: 8),
                          (response.selected ?? 0)
                              .toString()
                              .w(600)
                              .s(10)
                              .c(Color(0xFF41455E))
                        ]),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(width: 1, color: Color(0xFFDADDE5)),
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Assets.images.icCall.svg(
                              height: 12,
                              width: 12,
                              color: context.colors.iconGrey),
                          SizedBox(width: 8),
                          (response.phone_view ?? 0)
                              .toString()
                              .w(600)
                              .s(10)
                              .c(Color(0xFF41455E))
                        ]),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(width: 1, color: Color(0xFFDADDE5)),
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Assets.images.icSms.svg(
                              height: 12,
                              width: 12,
                              color: context.colors.iconGrey),
                          SizedBox(width: 8),
                          (response.message_number ?? 0)
                              .toString()
                              .w(600)
                              .s(10)
                              .c(Color(0xFF41455E))
                        ]),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
