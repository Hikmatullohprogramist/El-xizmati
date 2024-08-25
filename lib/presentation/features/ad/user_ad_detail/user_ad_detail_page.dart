import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:El_xizmati/presentation/support/extensions/color_extension.dart';
import 'package:El_xizmati/presentation/support/cubit/base_page.dart';
import 'package:El_xizmati/core/extensions/text_extensions.dart';
import 'package:El_xizmati/core/gen/assets/assets.gen.dart';
import 'package:El_xizmati/domain/mappers/common_mapper_exts.dart';
import 'package:El_xizmati/domain/models/ad/user_ad.dart';
import 'package:El_xizmati/presentation/router/app_router.dart';
import 'package:El_xizmati/presentation/widgets/ad/detail/detail_price_text_widget.dart';
import 'package:El_xizmati/presentation/widgets/app_bar/default_app_bar.dart';
import 'package:El_xizmati/presentation/widgets/image/rounded_cached_network_image_widget.dart';
import 'package:El_xizmati/presentation/widgets/loading/loader_state_widget.dart';

import 'user_ad_detail_cubit.dart';

@RoutePage()
class UserAdDetailPage extends BasePage<UserAdDetailCubit, UserAdDetailState, UserAdDetailEvent> {
  const UserAdDetailPage({super.key, required this.userAd});

  final UserAd userAd;

  @override
  void onWidgetCreated(BuildContext context) {
    cubit(context).setInitialParams(userAd);
  }

  @override
  Widget onWidgetBuild(BuildContext context, UserAdDetailState state) {
    return Scaffold(
      appBar: DefaultAppBar(
        titleText: "",
        titleTextColor: context.textPrimary,
        backgroundColor: context.backgroundGreyColor,
        onBackPressed: () => context.router.pop(),
      ),
      backgroundColor: context.backgroundGreyColor,
      body: LoaderStateWidget(
        isFullScreen: true,
        loadingState: state.loadState,
        successBody: _buildSuccessBody(context, state),
        onRetryClicked: () => cubit(context).getUserAdDetail(),
      ),
    );
  }

  Widget _buildSuccessBody(BuildContext context, UserAdDetailState state) {
    return ListView(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      children: [
        SizedBox(height: 20),
        _buildImageList(context, state),
        SizedBox(height: 16),
        _buildTitleBlock(context, state),
        SizedBox(height: 16),
        _buildStatsBlock(context, state),
        SizedBox(height: 20)
      ],
    );
  }

  Widget _buildImageList(BuildContext context, UserAdDetailState state) {
    return Container(
      color: context.cardColor,
      padding: EdgeInsets.symmetric(vertical: 16),
      child: SizedBox(
        height: 100,
        child: ListView.separated(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: state.adPhotos.length,
          padding: EdgeInsets.only(left: 10, right: 16),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                context.router.push(
                  ImageViewerRoute(
                    images: state.adPhotos,
                    initialIndex: index,
                  ),
                );
              },
              child: RoundedCachedNetworkImage(
                imageId: state.adPhotos[index],
                width: 160,
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(width: 10);
          },
        ),
      ),
    );
  }

  Widget _buildTitleBlock(BuildContext context, UserAdDetailState state) {
    return Container(
      color: context.cardColor,
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16),
          (userAd.name ?? "").w(600).s(14).c(context.textPrimary),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (userAd.hasPrice())
                DetailPriceTextWidget(
                  price: userAd.price ?? 0,
                  toPrice: userAd.toPrice ?? 0,
                  fromPrice: userAd.fromPrice ?? 0,
                  currency: userAd.currency.toCurrency(),
                ),
              // "473 769 560 сум".w(700).s(16).c(Color(0xFF5C6AC3))
            ],
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildStatsBlock(BuildContext context, UserAdDetailState state) {
    return Container(
      color: context.cardColor,
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16),
          // Row(
          //   children: [
          //     Assets.images.icCalendar.svg(width: 24, height: 24),
          //     SizedBox(width: 8),
          //     ("${userAd.beginDate ?? ""}-${userAd.endDate ?? ""}")
          //         .w(500)
          //         .s(12)
          //         .c(context.textSecondary),
          //   ],
          // ),
          // SizedBox(height: 16),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   children: [
          //     Assets.images.icLocation.svg(height: 24, width: 24),
          //     SizedBox(width: 6),
          //     ("${userAd.region ?? " "} ${userAd.district ?? ""}")
          //         .w(400)
          //         .s(12)
          //         .c(context.textSecondary)
          //   ],
          // ),
          // SizedBox(height: 16),
          // Container(
          //   margin: EdgeInsets.all(16),
          //   child: CustomElevatedButton(
          //     text: "Посмотреть статистику",
          //     onPressed: () {},
          //   ),
          // ),
          // SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 1,
                child: Container(
                  height: 36,
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
                            color: context.colors.iconSecondary),
                        SizedBox(width: 8),
                        (userAd.viewedCount ?? 0)
                            .toString()
                            .w(600)
                            .s(10)
                            .c(context.textPrimary)
                      ]),
                ),
              ),
              SizedBox(width: 12),
              Flexible(
                flex: 1,
                child: Container(
                  height: 36,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(width: 1, color: Color(0xFFDADDE5)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Assets.images.icFavoriteRemove.svg(
                          height: 12,
                          width: 12,
                          color: context.colors.iconSecondary),
                      SizedBox(width: 8),
                      (userAd.selectedCount ?? 0)
                          .toString()
                          .w(600)
                          .s(10)
                          .c(context.textPrimary)
                    ],
                  ),
                ),
              ),
              SizedBox(width: 12),
              Flexible(
                flex: 1,
                child: Container(
                  height: 36,
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
                            color: context.colors.iconSecondary),
                        SizedBox(width: 8),
                        (userAd.phoneViewedCount ?? 0)
                            .toString()
                            .w(600)
                            .s(10)
                            .c(context.textPrimary)
                      ]),
                ),
              ),
              SizedBox(width: 12),
              Flexible(
                flex: 1,
                child: Container(
                  height: 36,
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
                          color: context.colors.iconSecondary),
                      SizedBox(width: 8),
                      (userAd.messageViewedCount ?? 0)
                          .toString()
                          .w(600)
                          .s(10)
                          .c(context.textPrimary)
                    ],
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
