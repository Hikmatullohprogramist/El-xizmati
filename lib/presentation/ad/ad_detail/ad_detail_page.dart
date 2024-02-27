import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/localization/strings.dart';
import 'package:onlinebozor/common/router/app_router.dart';
import 'package:onlinebozor/common/widgets/ad/detail_price_text_widget.dart';
import 'package:onlinebozor/common/widgets/dashboard/see_all_widget.dart';
import 'package:onlinebozor/common/widgets/favorite/ad_detail_favorite_widget.dart';
import 'package:onlinebozor/presentation/ad/ad_detail/cubit/ad_detail_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../common/core/base_page.dart';
import '../../../common/enum/enums.dart';
import '../../../common/gen/assets/assets.gen.dart';
import '../../../common/widgets/ad/horizontal_ad_list_widget.dart';
import '../../../common/widgets/common/common_button.dart';
import '../../../common/widgets/dashboard/app_diverder.dart';
import '../../../common/widgets/dashboard/app_image_widget.dart';
import '../../../common/widgets/loading/loader_state_widget.dart';
import '../../../domain/models/ad/ad.dart';
import '../../../domain/models/ad/ad_author_type.dart';
import '../../../domain/models/ad/ad_item_condition.dart';
import '../../../domain/models/ad/ad_list_type.dart';
import '../../../domain/models/stats/stats_type.dart';

@RoutePage()
class AdDetailPage extends BasePage<PageCubit, PageState, PageEvent> {
  const AdDetailPage(this.adId, {super.key});

  final int adId;

  @override
  void onWidgetCreated(BuildContext context) {
    context.read<PageCubit>().setAdId(adId);
    context.read<PageCubit>().getRecentlyViewedAds();
  }

  @override
  Widget onWidgetBuild(BuildContext context, PageState state) {
    return state.adDetail != null
        ? _getSuccessContent(context, state)
        : _getLoadingContent(context, state);
  }

  Widget _getLoadingContent(BuildContext context, PageState state) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
            onPressed: () => context.router.pop(),
            icon: Assets.images.icArrowLeft.svg(height: 24, width: 24)),
      ),
      body: Center(
        child: CircularProgressIndicator(
            backgroundColor: Colors.blue, strokeWidth: 8),
      ),
    );
  }

  Widget _getSuccessContent(BuildContext context, PageState state) {
    return Scaffold(
      appBar: _getAppBar(context, state),
      bottomNavigationBar: _getBottomNavigationBar(context, state),
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: true,
        child: _getBodyContent(context, state),
      ),
    );
  }

  Widget _getBodyContent(BuildContext context, PageState state) {
    return ListView(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      children: [
        AppImageWidget(
          images: cubit(context).getImages(),
          onClicked: (int position) {
            context.router.push(
              ImageViewerRoute(
                images: cubit(context).getImages(),
                initialIndex: position,
              ),
            );
          },
        ),
        Container(
          padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              state.adDetail!.adName.w(600).s(16).c(Color(0xFF41455E)).copyWith(
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
              SizedBox(height: 16),
              DetailPriceTextWidget(
                price: state.adDetail!.price,
                toPrice: state.adDetail!.toPrice,
                fromPrice: state.adDetail!.fromPrice,
                currency: state.adDetail!.currency,
                color: Color(0xFFFF0098),
              ),
              SizedBox(height: 12),
              AppDivider(),
              SizedBox(height: 12),
              _getAdInfoChips(state),
              // SizedBox(height: 12),
              // AppDivider(),
              // SizedBox(height: 12),
              // AppDivider(),
              // getWatch(Strings.adDetailFeedback, () {}),
            ],
          ),
        ),
        Visibility(
          visible: (state.adDetail?.hasDescription() ?? false),
          child: AppDivider(startIndent: 16, endIndent: 16),
        ),
        _getDescriptionBlock(context, state),
        AppDivider(startIndent: 16, endIndent: 16),
        _getAuthorBlock(context, state),
        SizedBox(height: 12),
        _getContactsBlock(context, state),
        SizedBox(height: 12),
        AppDivider(startIndent: 16, endIndent: 16),
        SizedBox(height: 12),
        _getAddressBlock(context, state),
        Visibility(
          visible: false,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(children: [
              getTitleWithArrowIcon(Strings.adDetailFeedback, () {})
            ]),
          ),
        ),
        _getSimilarAds(context, state),
        _getOwnerAdsWidget(context, state),
        _getRecentlyViewedAdsWidget(context, state)
      ],
    );
  }

  AppBar _getAppBar(BuildContext context, PageState state) {
    return AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
            onPressed: () => context.router.pop(),
            icon: Assets.images.icArrowLeft.svg(height: 24, width: 24)),
        actions: [
          Padding(
              padding: EdgeInsets.all(4),
              child: AdDetailFavoriteWidget(
                  isSelected: state.adDetail!.favorite,
                  invoke: () => context.read<PageCubit>().addFavorite()))
        ]);
  }

  Widget _getBottomNavigationBar(BuildContext context, PageState state) {
    return Visibility(
        visible: (state.adDetail!.mainTypeStatus == "SELL" ||
            state.adDetail!.mainTypeStatus == "FREE" ||
            state.adDetail!.mainTypeStatus == "EXCHANGE"),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppDivider(),
            SizedBox(height: 16),
            Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              SizedBox(width: 16),
              DetailPriceTextWidget(
                price: state.adDetail!.price,
                toPrice: state.adDetail!.toPrice,
                fromPrice: state.adDetail!.fromPrice,
                currency: state.adDetail!.currency,
              ),
              SizedBox(width: 8),
              Spacer(),
              SizedBox(
                height: 36,
                child: CommonButton(
                    enabled: !state.isAddCart,
                    color: context.colors.buttonPrimary,
                    type: ButtonType.elevated,
                    onPressed: () => context.read<PageCubit>().addCart(),
                    child:
                        Strings.adDetailAddtocart.s(13).c(Colors.white).w(500)),
              ),
              SizedBox(width: 16)
            ]),
            SizedBox(height: 16)
          ],
        ));
  }

  Widget getTitleWithArrowIcon(String title, VoidCallback onPressed) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            title.w(500).s(14).c(Color(0xFF41455E)),
            // IconButton(
            //   onPressed: onPressed,
            //   icon: Assets.images.icArrowRight.svg(height: 18, width: 18),
            // )
          ],
        ));
  }

  Widget _getAdInfoChips(PageState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: switch (state.adDetail!.adAuthorType) {
              AdAuthorType.private => Color(0x28AEB2CD),
              AdAuthorType.business => Color(0x1E6546E7),
            },
          ),
          child: switch (state.adDetail!.adAuthorType) {
            AdAuthorType.private =>
              Strings.adPropertyPersonal.w(400).s(12).c(Color(0xFF41455E)),
            AdAuthorType.business =>
              Strings.adPropertyBiznes.w(400).s(12).c(Color(0xFF6546E7)),
          },
        ),
        SizedBox(width: 8),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Color(0x28AEB2CD),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              switch (state.adDetail!.adItemCondition) {
                AdItemCondition.fresh =>
                  Strings.adStatusNew.w(400).s(12).c(Color(0xFF41455E)),
                AdItemCondition.used =>
                  Strings.adStatusOld.w(400).s(12).c(Color(0xFF41455E)),
              },
            ],
          ),
        ),
        SizedBox(width: 8),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Color(0x28AEB2CD),
          ),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            Assets.images.icEye.svg(height: 14, width: 14),
            SizedBox(width: 4),
            state.adDetail!.view.toString().w(500).s(12).c(Color(0xFF41455E))
          ]),
        ),
        SizedBox(width: 8),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Color(0x28AEB2CD),
          ),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            Assets.images.icEdit.svg(height: 12, width: 12),
            SizedBox(width: 6),
            (state.adDetail!.createdAt ?? "").w(500).s(12).c(Color(0xFF41455E))
          ]),
        )
      ],
    );
  }

  Widget _getDescriptionBlock(BuildContext context, PageState state) {
    return Visibility(
      visible: (state.adDetail?.hasDescription() ?? false),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getTitleWithArrowIcon(Strings.adDetailDescription, () {}),
            (state.adDetail?.description ?? "")
                .w(600)
                .s(14)
                .c(Color(0xFF41455E))
                .copyWith(maxLines: 7),
            SizedBox(height: 8),
            Visibility(
              visible: false,
              child: InkWell(
                onTap: () {},
                child:
                    Strings.adDetailShowMore.w(500).s(14).c(Color(0xFF5C6AC3)),
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _getAuthorBlock(BuildContext context, PageState state) {
    return Container(
      padding: EdgeInsets.only(left: 16, top: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Strings.adDetailAuthor.w(600).s(14).c(Color(0xFF41455E)),
          SizedBox(height: 16),
          InkWell(
              child: Row(
                children: [
                  Container(
                    height: 52,
                    width: 52,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Color(0xFFE0E0ED),
                        borderRadius: BorderRadius.circular(10)),
                    child: Assets.images.icAvatarBoy.svg(),
                  ),
                  SizedBox(width: 16),
                  Flexible(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      (state.adDetail!.sellerFullName ?? "")
                          .w(500)
                          .s(14)
                          .c(Color(0xFF41455E))
                          .copyWith(
                              maxLines: 2, overflow: TextOverflow.ellipsis),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Strings.adDetailOnOnlineBozor
                              .w(400)
                              .s(14)
                              .c(Color(0xFF9EABBE)),
                          SizedBox(width: 8),
                          (state.adDetail!.beginDate ?? "")
                              .w(400)
                              .s(14)
                              .c(Color(0xFF41455E))
                        ],
                      )
                    ],
                  )),
                  Assets.images.icArrowRight.svg(width: 18, height: 18),
                  SizedBox(width: 16)
                ],
              ),
              onTap: () {
                context.router.push(
                  AdListRoute(
                      adListType: AdListType.adsByUser,
                      keyWord: "",
                      title: state.adDetail?.sellerFullName,
                      sellerTin: state.adDetail?.sellerTin),
                );
              }),
          SizedBox(height: 8)
        ],
      ),
    );
  }

  Widget _getAddressBlock(BuildContext context, PageState state) {
    return Visibility(
        visible: state.adDetail?.address != null,
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Strings.adDetailLocation.w(600).s(14).c(Color(0xFF41455E)),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Assets.images.icLocation.svg(width: 16, height: 16),
                    SizedBox(width: 6),
                    Expanded(
                      child: (state.adDetail!.address?.name ?? "")
                          .w(700)
                          .s(14)
                          .c(Color(0xFF5C6AC3)),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 24),
                    "${state.adDetail!.address?.region?.name ?? ""}  ${state.adDetail!.address?.district?.name ?? ""}"
                        .w(500)
                        .s(14)
                        .c(context.colors.textPrimary)
                  ],
                ),
                SizedBox(height: 16),
                Visibility(
                  // visible: state.adDetail?.address?.geo != null,
                  visible: false,
                  child: Assets.images.pngImages.map
                      .image(width: double.infinity, fit: BoxFit.fill),
                ),
                Visibility(
                  // visible: state.adDetail?.address?.geo != null,
                  visible: false,
                  child: SizedBox(height: 12),
                ),
                Visibility(
                  visible: state.adDetail?.address?.geo != null,
                  child: AppDivider(),
                ),
              ],
            )));
  }

  Widget _getContactsBlock(BuildContext context, PageState state) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(width: 16),
        Flexible(
          flex: 4,
          child: InkWell(
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0x0a2d7cc7),
                  border: Border.all(
                    color: Color(0xEA2D7CC7),
                    width: 0.5,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: Row(
                  children: [
                    Assets.images.icSmsDetail.svg(height: 22, width: 22),
                    SizedBox(width: 16),
                    Flexible(
                      flex: 1,
                      child: Strings.adDetailTowritemessge
                          .w(500)
                          .s(16)
                          .c(Color(0xEA2D7CC7))
                          .copyWith(textAlign: TextAlign.center),
                    )
                  ],
                ),
              ),
              onTap: () {
                context.read<PageCubit>().increaseAdStats(StatsType.message);
                try {
                  launch("sms://${state.adDetail!.phoneNumber}");
                } catch (e) {}
              }),
        ),
        SizedBox(width: 12),
        Flexible(
          flex: 5,
          child: InkWell(
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0x0a6ca86b),
                  border: Border.all(
                    color: Color(0xEC6CA86B),
                    width: 0.5,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: Row(
                  children: [
                    Assets.images.icCallDetail.svg(height: 22, width: 22),
                    SizedBox(width: 16),
                    Flexible(
                      flex: 1,
                      child: (state.isPhoneVisible
                              ? (state.adDetail?.phoneNumber ?? "")
                              : Strings.adDetailShowPhone)
                          .w(500)
                          .s(16)
                          .c(Color(0xEC6CA86B))
                          .copyWith(textAlign: TextAlign.center),
                    )
                  ],
                ),
              ),
              onDoubleTap: () {
                try {
                  launch("tel://${state.adDetail!.phoneNumber}");
                } catch (e) {}
              },
              onTap: () {
                if (state.isPhoneVisible) {
                  try {
                    launch("tel://${state.adDetail!.phoneNumber}");
                  } catch (e) {}
                } else {
                  context.read<PageCubit>().setPhotoView();
                }
              }),
        ),
        SizedBox(width: 16),
      ],
    );
  }

  Widget _getSimilarAds(BuildContext context, PageState state) {
    return Column(
      children: [
        SeeAllWidget(
          onClicked: () {
            context.router.push(
              AdListRoute(
                adListType: AdListType.similarAds,
                keyWord: null,
                title: Strings.similarProductTitle,
                adId: state.adId,
              ),
            );
          },
          title: Strings.similarProductTitle,
        ),
        LoaderStateWidget(
          isFullScreen: false,
          onErrorToAgainRequest: () {
            context.read<PageCubit>().getSimilarAds();
          },
          loadingState: state.similarAdsState,
          child: HorizontalAdListWidget(
            ads: state.similarAds,
            onItemClicked: (Ad ad) =>
                context.router.push(AdDetailRoute(adId: ad.id)),
            onFavoriteClicked: (Ad ad) =>
                context.read<PageCubit>().similarAdsAddFavorite(ad),
          ),
        ),
      ],
    );
  }

  Widget _getOwnerAdsWidget(BuildContext context, PageState state) {
    return Visibility(
      visible: state.ownerAdsState != LoadingState.error &&
          state.ownerAds.isNotEmpty,
      child: Column(
        children: [
          SizedBox(height: 12),
          SeeAllWidget(
            onClicked: () {
              context.router.push(
                AdListRoute(
                  adListType: AdListType.adsByUser,
                  keyWord: '',
                  title: Strings.adDetailAuthorAds,
                  sellerTin: state.adDetail?.sellerTin,
                ),
              );
            },
            title: Strings.adDetailAuthorAds,
          ),
          LoaderStateWidget(
            isFullScreen: false,
            onErrorToAgainRequest: () {
              context.read<PageCubit>().getOwnerOtherAds();
            },
            loadingState: state.ownerAdsState,
            child: HorizontalAdListWidget(
              ads: state.ownerAds,
              onItemClicked: (Ad ad) {
                context.router.push(AdDetailRoute(adId: ad.id));
              },
              onFavoriteClicked: (Ad ad) {
                context.read<PageCubit>().ownerAdAddToFavorite(ad);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _getRecentlyViewedAdsWidget(
    BuildContext context,
    PageState state,
  ) {
    return Visibility(
      visible: state.recentlyViewedAdsState != LoadingState.error &&
          state.recentlyViewedAds.isNotEmpty,
      child: Column(
        children: [
          SizedBox(height: 12),
          SeeAllWidget(
            onClicked: () {
              context.router.push(
                AdListRoute(
                  adListType: AdListType.recentlyViewedAds,
                  keyWord: '',
                  title: Strings.recentlyViewedTitle,
                  sellerTin: null,
                ),
              );
            },
            title: Strings.recentlyViewedTitle,
          ),
          LoaderStateWidget(
            isFullScreen: false,
            onErrorToAgainRequest: () {
              context.read<PageCubit>().getRecentlyViewedAds();
            },
            loadingState: state.recentlyViewedAdsState,
            child: HorizontalAdListWidget(
              ads: state.recentlyViewedAds,
              onItemClicked: (Ad ad) {
                context.router.push(AdDetailRoute(adId: ad.id));
              },
              onFavoriteClicked: (Ad ad) {
                context.read<PageCubit>().recentlyViewAdAddToFavorite(ad);
              },
            ),
          ),
        ],
      ),
    );
  }
}
