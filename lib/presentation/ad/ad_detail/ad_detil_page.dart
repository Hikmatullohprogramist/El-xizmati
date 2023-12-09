import 'package:auto_route/auto_route.dart';
import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/constants.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/localization/strings.dart';
import 'package:onlinebozor/common/router/app_router.dart';
import 'package:onlinebozor/common/widgets/ad/price_widget.dart';
import 'package:onlinebozor/common/widgets/dashboard/all_view_widget.dart';
import 'package:onlinebozor/common/widgets/favorite/favorite_widget.dart';
import 'package:onlinebozor/domain/util.dart';
import 'package:onlinebozor/presentation/ad/ad_detail/cubit/ad_detail_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../common/core/base_page.dart';
import '../../../common/gen/assets/assets.gen.dart';
import '../../../common/widgets/ad/ad_group_widget.dart';
import '../../../common/widgets/ad/ad_property_widget.dart';
import '../../../common/widgets/ad/ad_route_widget.dart';
import '../../../common/widgets/common/common_button.dart';
import '../../../common/widgets/dashboard/app_diverder.dart';
import '../../../common/widgets/dashboard/app_image_widget.dart';
import '../../../common/widgets/loading/loader_state_widget.dart';
import '../../../domain/models/ad.dart';

@RoutePage()
class AdDetailPage
    extends BasePage<AdDetailCubit, AdDetailBuildable, AdDetailListenable> {
  const AdDetailPage(this.adId, {super.key});

  final int adId;

  @override
  void init(BuildContext context) {
    context.read<AdDetailCubit>().setAdId(adId);
  }

  Widget getWatch(String title, VoidCallback onPressed) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            title.w(500).s(14).c(Color(0xFF41455E)),
            IconButton(
                onPressed: onPressed,
                icon: Assets.images.icArrowRight.svg(height: 24, width: 24))
          ],
        ));
  }

  @override
  Widget builder(BuildContext context, AdDetailBuildable state) {
    return state.adDetail != null
        ? Scaffold(
            bottomNavigationBar: Visibility(
                visible: (state.adDetail!.mainTypeStatus == "SELL" ||
                    state.adDetail!.mainTypeStatus == "FREE" ||
                    state.adDetail!.mainTypeStatus == "EXCHANGE"),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Row(children: [
                    SizedBox(width: 16),
                    Strings.adDetailPrice.w(400).s(12).c(Color(0xFF9EABBE)),
                    SizedBox(width: 8),
                    AppPriceWidget(
                        price: state.adDetail!.price,
                        toPrice: state.adDetail!.toPrice,
                        fromPrice: state.adDetail!.fromPrice,
                        currency: state.adDetail!.currency),
                    SizedBox(width: 8),
                    Spacer(),
                    SizedBox(
                        height: 36,
                        child: CommonButton(
                            enabled: !state.isAddCart,
                            color: context.colors.buttonPrimary,
                            type: ButtonType.elevated,
                            onPressed: () =>
                                context.read<AdDetailCubit>().addCart(),
                            child: Strings.adDetailAddtocart
                                .s(13)
                                .c(Colors.white)
                                .w(500))),
                    SizedBox(width: 16)
                  ]),
                )),
            backgroundColor: Colors.white,
            appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 1,
                leading: IconButton(
                    onPressed: () => context.router.pop(),
                    icon: Assets.images.icArrowLeft.svg(height: 24, width: 24)),
                actions: [
                  Padding(
                      padding: EdgeInsets.all(4),
                      child: AppFavoriteWidget(
                          isSelected: state.adDetail!.favorite,
                          invoke: () =>
                              context.read<AdDetailCubit>().addFavorite()))
                ]),
            body: SafeArea(
              bottom: true,
              child: ListView(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                children: [
                  AppImageWidget(
                    images: (state.adDetail?.photos ??
                            List.empty(growable: true))
                        .map((e) => "${Constants.baseUrlForImage}${e.image}")
                        .toList(),
                    invoke: (int position) {
                      context.router.push(PhotoViewRoute(
                        lists: (state.adDetail?.photos ??
                                List.empty(growable: true))
                            .map(
                                (e) => "${Constants.baseUrlForImage}${e.image}")
                            .toList(),
                        position: position,
                      ));
                    },
                  ),
                  AppDivider(height: 1),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 16),
                          state.adDetail!.adName
                              .w(600)
                              .s(16)
                              .c(Color(0xFF41455E))
                              .copyWith(
                                  maxLines: 2, overflow: TextOverflow.ellipsis),
                          SizedBox(height: 16),
                          AppPriceWidget(
                              price: state.adDetail!.price,
                              toPrice: state.adDetail!.toPrice,
                              fromPrice: state.adDetail!.fromPrice,
                              currency: state.adDetail!.currency,
                              color: Color(0xFFFF0098)),
                          SizedBox(height: 24),
                          AppDivider(),
                          SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              AppAdRouterWidget(
                                  isHorizontal: false,
                                  adRouteType: state.adDetail!.adRouteType),
                              SizedBox(width: 5),
                              AppAdPropertyWidget(
                                  isHorizontal: false,
                                  adPropertyType:
                                      state.adDetail!.propertyStatus)
                            ],
                          ),
                          SizedBox(height: 12),
                          AppDivider(),
                          SizedBox(height: 12),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 4),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Color(0x28AEB2CD)),
                                  child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Strings.adDetailPublishedTitle
                                            .w(400)
                                            .s(14)
                                            .c(Color(0xFF9EABBE)),
                                        SizedBox(width: 5),
                                        (state.adDetail!.createdAt ?? "")
                                            .w(500)
                                            .s(14)
                                            .c(Color(0xFF41455E))
                                      ]))),
                          SizedBox(height: 8),
                          Align(
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 4),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Color(0x28AEB2CD)),
                                      child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Assets.images.icEye.svg(),
                                            SizedBox(width: 8),
                                            Strings.adDetailViewCountTitle
                                                .w(400)
                                                .s(14)
                                                .c(Color(0xFF9EABBE)),
                                            SizedBox(width: 4),
                                            state.adDetail!.view
                                                .toString()
                                                .w(500)
                                                .s(14)
                                                .c(Color(0xFF41455E))
                                          ])),
                                  // SizedBox(width: 8),
                                  // Container(
                                  //     padding: EdgeInsets.symmetric(
                                  //         horizontal: 5, vertical: 4),
                                  //     decoration: BoxDecoration(
                                  //         borderRadius:
                                  //             BorderRadius.circular(5),
                                  //         color: Color(0x28AEB2CD)),
                                  //     child: Row(
                                  //         mainAxisSize: MainAxisSize.min,
                                  //         children: [
                                  //           "ID:"
                                  //               .w(400)
                                  //               .s(14)
                                  //               .c(Color(0xFF9EABBE)),
                                  //           SizedBox(width: 4),
                                  //           state.adDetail!.adId
                                  //               .toString()
                                  //               .w(500)
                                  //               .s(14)
                                  //               .c(Color(0xFF41455E))
                                  //         ])),
                                ]),
                          ),
                          SizedBox(height: 16),
                          // AppDivider(),
                          // getWatch(Strings.adDetailFeedback, () {}),
                        ]),
                  ),
                  Visibility(
                      visible: (state.adDetail?.description != null &&
                          state.adDetail?.description != ""),
                      child: AppDivider()),
                  Visibility(
                      visible: (state.adDetail?.description != null &&
                          state.adDetail?.description != ""),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              getWatch("Описание", () {}),
                              (state.adDetail?.description ?? "")
                                  .w(400)
                                  .s(14)
                                  .c(Color(0xFF41455E))
                                  .copyWith(maxLines: 7),
                              SizedBox(height: 16),
                              InkWell(
                                  onTap: () {},
                                  child: "Показать больше"
                                      .w(500)
                                      .s(16)
                                      .c(Color(0xFF5C6AC3))),
                              SizedBox(height: 16),
                            ]),
                      )),
                  AppDivider(),
                  Container(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        "Продавец".w(500).s(16).c(Color(0xFF41455E)),
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
                                SizedBox(width: 14),
                                Flexible(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    (state.adDetail!.sellerFullName ?? "")
                                        .w(600)
                                        .s(16)
                                        .c(Color(0xFF41455E))
                                        .copyWith(
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis),
                                    SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Strings.adDetailOnOnlineBozor
                                            .w(500)
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
                                IconButton(
                                    onPressed: () {},
                                    icon: Assets.images.icArrowRight
                                        .svg(width: 24, height: 24)),
                              ],
                            ),
                            onTap: () {
                              context.router.push(AdListRoute(
                                  adListType: AdListType.seller,
                                  keyWord: "",
                                  title: state.adDetail?.sellerFullName,
                                  sellerTin: state.adDetail?.sellerTin));
                            }),
                        SizedBox(height: 8)
                      ],
                    ),
                  ),
                  Visibility(
                      visible: state.adDetail?.address != null,
                      child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Strings.adDetailLocation
                                  .w(500)
                                  .s(16)
                                  .c(Color(0xFF41455E)),
                              SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Assets.images.icLocation
                                      .svg(width: 16, height: 16),
                                  SizedBox(width: 4),
                                  (state.adDetail!.address?.name ?? "")
                                      .w(700)
                                      .s(12)
                                      .c(Color(0xFF5C6AC3)),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(width: 28),
                                  "${state.adDetail!.address?.region?.name}  ${state.adDetail!.address?.district?.name}"
                                      .w(500)
                                      .s(12)
                                      .c(Color(0xFF9EABBE))
                                      .frosted(
                                        blur: 2.5,
                                        borderRadius: BorderRadius.circular(20),
                                        padding: EdgeInsets.all(8),
                                      )
                                ],
                              ),
                              SizedBox(height: 16),
                              Visibility(
                                visible: state.adDetail?.address?.geo != null,
                                child: Stack(
                                  children: [
                                    InkWell(
                                        child: Assets.images.pngImages.map
                                            .image(width: double.infinity)),
                                    Positioned.fill(
                                        child: InkWell(
                                            onTap: () {},
                                            child: Align(
                                              child: "Посмотреть"
                                                  .w(600)
                                                  .s(14)
                                                  .c(Color(0xFF41455E))
                                                  .frosted(
                                                    blur: 2.5,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    padding: EdgeInsets.all(8),
                                                  ),
                                            ))),
                                  ],
                                ),
                              )
                            ],
                          ))),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    child: Column(
                      children: [
                        InkWell(
                            child: Card(
                              color: Color(0xFFFAF9FF),
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              shadowColor: Color(0x196B7194),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 14, horizontal: 24),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Assets.images.icSms
                                          .svg(height: 24, width: 24),
                                      SizedBox(width: 16),
                                      Strings.adDetailTowritemessge
                                          .w(500)
                                          .s(16)
                                          .c(Color(0xFF41455E))
                                    ]),
                              ),
                            ),
                            onTap: () {
                              try {
                                launch("sms://${state.adDetail!.phoneNumber}");
                              } catch (e) {}
                            }),
                        SizedBox(height: 16),
                        InkWell(
                            child: Card(
                              color: Color(0xFF32B88B),
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              shadowColor: Color(0xFF32B88B),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 14, horizontal: 24),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Assets.images.icCall
                                          .svg(height: 24, width: 24),
                                      SizedBox(width: 16),
                                      state.isPhoneVisible
                                          ? (state.adDetail?.phoneNumber ?? "")
                                              .w(500)
                                              .s(16)
                                              .c(Colors.white)
                                          : "Показать телефон"
                                              .w(500)
                                              .s(16)
                                              .c(Colors.white)
                                    ]),
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
                                  launch(
                                      "tel://${state.adDetail!.phoneNumber}");
                                } catch (e) {}
                              } else {
                                context.read<AdDetailCubit>().setPhotoView();
                              }
                            }),
                      ],
                    ),
                  ),
                  AppDivider(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(children: [getWatch("Отзывы ", () {})]),
                  ),
                  AppAllViewWidget(
                      listener: () {
                        context.router.push(AdListRoute(
                            adListType: AdListType.similar,
                            keyWord: null,
                            title: "O'xshash mahsulotlar",
                            adId: state.adId));
                      },
                      title: "O'xshash mahsulotlar"),
                  LoaderStateWidget(
                      isFullScreen: false,
                      onErrorToAgainRequest: () {
                        context.read<AdDetailCubit>().getSimilarAds();
                      },
                      loadingState: state.similarAdsState,
                      child: AdGroupWidget(
                        ads: state.similarAds,
                        invoke: (Ad ad) =>
                            context.router.push(AdDetailRoute(adId: ad.id)),
                        invokeFavorite: (Ad ad) => context
                            .read<AdDetailCubit>()
                            .similarAdsAddFavorite(ad),
                      )),
                ],
              ),
            ))
        : Scaffold(
            appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 1,
                leading: IconButton(
                    onPressed: () => context.router.pop(),
                    icon:
                        Assets.images.icArrowLeft.svg(height: 24, width: 24))),
            body: Center(
              child: CircularProgressIndicator(
                  backgroundColor: Colors.blue, strokeWidth: 8),
            ));
  }
}