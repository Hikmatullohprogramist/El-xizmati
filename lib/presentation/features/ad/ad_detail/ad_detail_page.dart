import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:El_xizmati/core/extensions/text_extensions.dart';
import 'package:El_xizmati/core/gen/assets/assets.gen.dart';
import 'package:El_xizmati/core/gen/localization/strings.dart';
import 'package:El_xizmati/domain/models/ad/ad.dart';
import 'package:El_xizmati/domain/models/ad/ad_item_condition.dart';
import 'package:El_xizmati/domain/models/ad/ad_list_type.dart';
import 'package:El_xizmati/domain/models/ad/ad_transaction_type.dart';
import 'package:El_xizmati/domain/models/report/report_type.dart';
import 'package:El_xizmati/domain/models/stats/stats_type.dart';
import 'package:El_xizmati/presentation/features/ad/ad_detail/features/installment_info/installment_info_page.dart';
import 'package:El_xizmati/presentation/features/common/report/submit_report_page.dart';
import 'package:El_xizmati/presentation/router/app_router.dart';
import 'package:El_xizmati/presentation/support/colors/static_colors.dart';
import 'package:El_xizmati/presentation/support/cubit/base_page.dart';
import 'package:El_xizmati/presentation/support/extensions/color_extension.dart';
import 'package:El_xizmati/presentation/support/extensions/platform_sizes.dart';
import 'package:El_xizmati/presentation/support/extensions/resource_exts.dart';
import 'package:El_xizmati/presentation/widgets/action/action_list_item.dart';
import 'package:El_xizmati/presentation/widgets/ad/detail/ad_detail_shimmer.dart';
import 'package:El_xizmati/presentation/widgets/ad/detail/detail_price_text_widget.dart';
import 'package:El_xizmati/presentation/widgets/ad/horizontal/horizontal_ad_list_shimmer.dart';
import 'package:El_xizmati/presentation/widgets/ad/horizontal/horizontal_ad_list_widget.dart';
import 'package:El_xizmati/presentation/widgets/app_bar/action_app_bar.dart';
import 'package:El_xizmati/presentation/widgets/bottom_sheet/bottom_sheet_title.dart';
import 'package:El_xizmati/presentation/widgets/button/custom_elevated_button.dart';
import 'package:El_xizmati/presentation/widgets/dashboard/see_all_widget.dart';
import 'package:El_xizmati/presentation/widgets/divider/custom_divider.dart';
import 'package:El_xizmati/presentation/widgets/elevation/elevation_widget.dart';
import 'package:El_xizmati/presentation/widgets/favorite/ad_detail_favorite_widget.dart';
import 'package:El_xizmati/presentation/widgets/image/rectangle_cached_network_image_widget.dart';
import 'package:El_xizmati/presentation/widgets/image/rounded_cached_network_image_widget.dart';
import 'package:El_xizmati/presentation/widgets/loading/default_error_widget.dart';
import 'package:El_xizmati/presentation/widgets/loading/loader_state_widget.dart';
import 'package:share_plus/share_plus.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

import 'ad_detail_cubit.dart';

@RoutePage()
class AdDetailPage
    extends BasePage<AdDetailCubit, AdDetailState, AdDetailEvent> {
  AdDetailPage(this.adId, {super.key});

  final int adId;

  @override
  void onWidgetCreated(BuildContext context) {
    cubit(context).setInitialParams(adId);
    cubit(context).getRecentlyViewedAds();
  }

  final CarouselController _controller = CarouselController();

  @override
  Widget onWidgetBuild(BuildContext context, AdDetailState state) {
    return Scaffold(
      appBar: _buildAppBar(context, state),
      bottomNavigationBar: state.isNotPrepared
          ? null
          : _buildBottomNavigationBar(context, state),
      backgroundColor: context.backgroundWhiteColor,
      body: state.isNotPrepared
          ? _buildLoadingBody(state, context)
          : _buildSuccessBody(context, state),
    );
  }

  Widget _buildLoadingBody(AdDetailState state, BuildContext context) {
    return state.isPreparingInProcess
        ? AdDetailShimmer()
        : DefaultErrorWidget(
            isFullScreen: true,
            onRetryClicked: () => cubit(context).getDetailResponse(),
          );
  }

  Widget _buildSuccessBody(BuildContext context, AdDetailState state) {
    return SafeArea(
      bottom: true,
      child: ListView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        children: [
          ..._buildImageListWidget(context, state),
          SizedBox(height: 16),
          ..._buildNameAndPriceWidgets(context, state),
          SizedBox(height: 12),
          ..._buildPriceRangeWidgets(context, state),
          SizedBox(height: 12),
          ..._buildAdInfoChips(context, state),
          SizedBox(height: 12),
          ..._buildDescBlock(context, state),
          SizedBox(height: 12),
          ..._buildAuthorBlock(context, state),
          SizedBox(height: 12),
          _buildContactsBlock(context, state),
          SizedBox(height: 12),
          CustomDivider(startIndent: 16, endIndent: 16),
          SizedBox(height: 12),
          _buildAddressBlock(context, state),
          Visibility(
            visible: false,
            child: Column(
              children: [
                SeeAllWidget(
                  title: Strings.adDetailFeedback,
                  onClicked: () {},
                )
              ],
            ),
          ),
          _buildSimilarAds(context, state),
          _buildOwnerAdsWidget(context, state),
          _buildRecentlyViewedAdsWidget(context, state)
        ],
      ),
    );
  }

  List<Widget> _buildNameAndPriceWidgets(
    BuildContext context,
    AdDetailState state,
  ) {
    return [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: state.adDetail!.adName.w(600).s(16).copyWith(
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
      ),
      SizedBox(height: 8),
      Row(
        children: [
          SizedBox(width: 16),
          DetailPriceTextWidget(
            price: state.adDetail!.price,
            toPrice: state.adDetail!.toPrice,
            fromPrice: state.adDetail!.fromPrice,
            currency: state.adDetail!.currency,
            color: Color(0xFFFF0098),
          ),
          SizedBox(width: 16),
        ],
      ),
      Visibility(
        visible: state.adDetail?.isContract == true,
        child: SizedBox(height: 12),
      ),
      Visibility(
        visible: state.adDetail?.isContract == true,
        child: Row(
          children: [
            Flexible(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Color(0xFF0096B2).withOpacity(0.15),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Assets.images.icBargain.svg(width: 20, height: 20),
                    SizedBox(width: 4),
                    Strings.commonBargain.s(13).w(500).c(Color(0xFF0096B2)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 12),
      Visibility(
        visible: state.hasInstallment,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 16),
            InkWell(
              onTap: () {
                HapticFeedback.lightImpact();
              },
              child: Flexible(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(6),
                      bottomLeft: Radius.circular(6),
                    ),
                    color: StaticColors.majorelleBlue.withOpacity(0.85),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: 12),
                      Assets.images.icInstallmentPayment.svg(
                        width: 15,
                        height: 15,
                        color: Colors.white,
                      ),
                      SizedBox(width: 8),
                      Strings.installmentPaymentPrice(
                              monthly_price: state.installmentMonthlyPrice,
                              month_count: state.installmentMonthlyCount)
                          .s(13)
                          .w(400)
                          .c(context.textPrimaryInverse)
                          .copyWith(
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                      SizedBox(width: 12),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 2),
            InkWell(
              onTap: () {
                HapticFeedback.lightImpact();
                _showSmInstallmentsPage(context, state);
              },
              child: Flexible(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(6),
                      bottomRight: Radius.circular(6),
                    ),
                    color: StaticColors.majorelleBlue.withOpacity(0.85),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: 12),
                      Strings.commonMore
                          .s(13)
                          .w(400)
                          .c(context.textPrimaryInverse)
                          .copyWith(
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                      SizedBox(width: 6),
                      Assets.images.icArrowRight.svg(
                        width: 15,
                        height: 15,
                        color: Colors.white,
                      ),
                      SizedBox(width: 12),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: 16),
          ],
        ),
      ),
      Visibility(
        visible: state.hasInstallment,
        child: SizedBox(height: 12),
      ),
      CustomDivider(startIndent: 16, endIndent: 16),
    ];
  }

  List<Widget> _buildPriceRangeWidgets(
    BuildContext context,
    AdDetailState state,
  ) {
    double calculatePricePosition(
        double minPrice, double maxPrice, double price) {
      if (maxPrice == minPrice) {
        return 0.0;
      } else if (price >= maxPrice) {
        return 70.0;
      }
      final position = ((price - minPrice) / (maxPrice - minPrice)) * 100;
      if (position < 10.0) {
        return 10.0;
      } else if (position > 70.0) {
        return 70.0;
      }
      return position;
    }

    double pricePosition = calculatePricePosition(
      state.adDetail!.minPrice!,
      state.adDetail!.maxPrice!,
      state.adDetail!.price.toDouble(),
    );

    return [
      Row(
        children: [
          Padding(
            padding: EdgeInsets.only(
                left:
                    MediaQuery.of(context).size.width * (pricePosition / 100)),
            child: Column(
              children: [
                RoundedCachedNetworkImage(
                  imageId: state.adDetail?.photos?.firstOrNull ?? "",
                  width: 100,
                  height: 64,
                ),
                DetailPriceTextWidget(
                  price: state.adDetail!.price,
                  toPrice: state.adDetail!.toPrice,
                  fromPrice: state.adDetail!.fromPrice,
                  currency: state.adDetail!.currency,
                  color: Color(0xFFFF0098),
                  textSize: 14,
                  fontWeight: 400,
                ),
              ],
            ),
          )
        ],
      ),
      SizedBox(height: 2),
      Row(
        children: [
          SizedBox(width: 16),
          Flexible(
            child: Container(
              height: 4,
              margin: EdgeInsets.symmetric(horizontal: 1),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF76cf5e),
                    Color(0xFF76cf5e).withOpacity(0.95),
                  ],
                ),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          Flexible(
            child: Container(
              height: 4,
              margin: EdgeInsets.symmetric(horizontal: 1),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF76cf5e).withOpacity(0.9),
                    Color(0xFF76cf5e).withOpacity(0.85),
                  ],
                ),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          Flexible(
            child: Container(
              height: 4,
              margin: EdgeInsets.symmetric(horizontal: 1),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF76cf5e).withOpacity(0.8),
                    Color(0xFF76cf5e).withOpacity(0.75),
                    Color(0xFFf7cf47).withOpacity(0.75),
                  ],
                ),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          Flexible(
            child: Container(
              height: 4,
              margin: EdgeInsets.symmetric(horizontal: 1),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFf7cf47).withOpacity(0.8),
                    Color(0xFFf7cf47).withOpacity(0.85),
                    Color(0xFFf7cf47).withOpacity(0.9),
                  ],
                ),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          Flexible(
            child: Container(
              height: 4,
              margin: EdgeInsets.symmetric(horizontal: 1),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: const [
                    Color(0xFFf7cf47),
                    Color(0xFFf7cf47),
                  ],
                ),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          Flexible(
            child: Container(
              height: 4,
              margin: EdgeInsets.symmetric(horizontal: 1),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFf7cf47).withOpacity(0.9),
                    Color(0xFFf7cf47).withOpacity(0.85),
                    Color(0xFFf7cf47).withOpacity(0.8),
                  ],
                ),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          Flexible(
            child: Container(
              height: 4,
              margin: EdgeInsets.symmetric(horizontal: 1),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFf7cf47).withOpacity(0.75),
                    Color(0xFFeb535a).withOpacity(0.75),
                    Color(0xFFeb535a).withOpacity(0.8),
                  ],
                ),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          Flexible(
            child: Container(
              height: 4,
              margin: EdgeInsets.symmetric(horizontal: 1),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFeb535a).withOpacity(0.85),
                    Color(0xFFeb535a).withOpacity(0.9),
                  ],
                ),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          Flexible(
            child: Container(
              height: 4,
              margin: EdgeInsets.symmetric(horizontal: 1),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFeb535a).withOpacity(0.85),
                    Color(0xFFeb535a),
                  ],
                ),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          SizedBox(width: 16),
        ],
      ),
      SizedBox(height: 8),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Strings.adDetailCheapPrice.s(14).w(400),
            Strings.adDetailExpensivePrice.s(14).w(400)
          ],
        ),
      ),
      SizedBox(height: 12),
      CustomDivider(startIndent: 16, endIndent: 16),
    ];
  }

  AppBar _buildAppBar(BuildContext context, AdDetailState state) {
    return state.isNotPrepared
        ? ActionAppBar(
            titleText: "",
            titleTextColor: context.textPrimary,
            backgroundColor: context.appBarColor,
            onBackPressed: () => context.router.pop(),
          )
        : ActionAppBar(
            titleText: "",
            titleTextColor: context.textPrimary,
            backgroundColor: context.appBarColor,
            onBackPressed: () => context.router.pop(),
            actions: [
              Padding(
                padding: EdgeInsets.all(4),
                child: AdDetailFavoriteWidget(
                  isFavorite: state.adDetail!.isFavorite,
                  onClicked: () => cubit(context).changeAdFavorite(),
                ),
              ),
              IconButton(
                icon: Assets.images.icShare.svg(),
                onPressed: () {
                  Share.share("https://online-bozor.uz/ads/${state.adId}");
                },
              ),
              IconButton(
                icon: Assets.images.icThreeDotVertical.svg(),
                onPressed: () {
                  _showReportTypeBottomSheet(context);
                },
              ),
            ],
          );
  }

  List<Widget> _buildImageListWidget(
    BuildContext context,
    AdDetailState state,
  ) {
    return [
      CarouselSlider(
        carouselController: _controller,
        options: CarouselOptions(
          autoPlay: false,
          height: 340,
          viewportFraction: 1,
          onPageChanged: (index, reason) {
            cubit(context).setVisibleImageIndex(index);
          },
        ),
        items: state.images.mapIndexed((index, image) {
          return Builder(
            builder: (BuildContext context) {
              return InkWell(
                onTap: () {
                  context.router.push(
                    ImageViewerRoute(
                      images: state.images,
                      initialIndex: index,
                    ),
                  );
                },
                child: RectangleCachedNetworkImage(imageId: image),
              );
            },
          );
        }).toList(),
      ),
      SizedBox(height: 8),
      Center(
        child: AnimatedSmoothIndicator(
          activeIndex: state.visibleImageIndex,
          effect: ExpandingDotsEffect(
            dotWidth: 9,
            dotHeight: 3,
            spacing: 5,
            radius: 3,
            dotColor: StaticColors.buttonColor.withOpacity(0.5),
            activeDotColor: StaticColors.buttonColor,
          ),
          count: state.imagesCount,
        ),
      ),
    ];
  }

  Widget _buildBottomNavigationBar(BuildContext context, AdDetailState state) {
    return Visibility(
      visible: (state.adDetail!.adTransactionType == AdTransactionType.sell ||
          state.adDetail!.adTransactionType == AdTransactionType.free ||
          state.adDetail!.adTransactionType == AdTransactionType.exchange),
      child: ElevationWidget(
        topLeftRadius: 16,
        topRightRadius: 16,
        backgroundColor: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            color: context.cardColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            border: Border.all(
              color: context.cardStrokeColor,
              width: .25,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 16),
              Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                SizedBox(width: 16),
                Flexible(
                  child: CustomElevatedButton(
                    text: Strings.adBuy,
                    backgroundColor:
                        StaticColors.majorelleBlue.withOpacity(0.8),
                    onPressed: () {
                      context.router
                          .push(OrderCreationRoute(adId: state.adId!));
                    },
                  ),
                ),
                SizedBox(width: 8),
                Flexible(
                  child: CustomElevatedButton(
                    text: !state.isAddCart
                        ? Strings.adDetailAddToCart
                        : Strings.adDetailOpenCart,
                    onPressed: () {
                      !state.isAddCart
                          ? cubit(context).addCart()
                          : context.router.push(CartRoute());
                    },
                  ),
                ),
                SizedBox(width: 16)
              ]),
              SizedBox(height: defaultBottomPadding)
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildAdInfoChips(BuildContext context, AdDetailState state) {
    return [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          alignment: WrapAlignment.start,
          crossAxisAlignment: WrapCrossAlignment.start,
          runAlignment: WrapAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Color(0x28AEB2CD),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Strings.adDetailChipItemCondition
                      .s(12)
                      .w(400)
                      .c(context.textPrimary.withOpacity(0.85)),
                  SizedBox(height: 6),
                  (state.adDetail!.adItemCondition == AdItemCondition.fresh
                          ? Strings.adStatusNew
                          : Strings.adStatusOld)
                      .s(12)
                      .w(500),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Color(0x28AEB2CD),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Strings.adDetailChipViewedCount
                      .s(12)
                      .w(400)
                      .c(context.textPrimary.withOpacity(0.85)),
                  SizedBox(height: 6),
                  state.adDetail!.viewedCount.toString().w(500).s(12),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Color(0x28AEB2CD),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Strings.adDetailChipPublishedDate
                      .s(12)
                      .w(400)
                      .c(context.textPrimary.withOpacity(0.85)),
                  SizedBox(height: 6),
                  (state.adDetail!.createdAt ?? "").w(500).s(12)
                ],
              ),
            ),
          ],
        ),
      ),
    ];
  }

  List<Widget> _buildDescBlock(BuildContext context, AdDetailState state) {
    return state.adDetail?.hasDescription() == false
        ? []
        : [
            CustomDivider(startIndent: 16, endIndent: 16),
            SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Strings.adDetailDescription.w(600).s(14),
            ),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: (state.adDetail?.description ?? "")
                  .w(400)
                  .s(14)
                  .copyWith(maxLines: 7),
            ),
          ];
  }

  List<Widget> _buildAuthorBlock(BuildContext context, AdDetailState state) {
    return [
      CustomDivider(startIndent: 16, endIndent: 16),
      SizedBox(height: 12),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Strings.adDetailAuthor.w(600).s(14),
      ),
      SizedBox(height: 4),
      InkWell(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            Row(
              children: [
                SizedBox(width: 16),
                Container(
                  height: 52,
                  width: 52,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Color(0xFFE0E0ED),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Assets.images.icAvatarBoy.svg(),
                ),
                SizedBox(width: 16),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      (state.adDetail?.seller?.fullName ?? "")
                          .w(500)
                          .s(14)
                          .copyWith(
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                      SizedBox(height: 8),
                      Row(
                        children: [  // Strings.adDetailOnEl_xizmati
                          //     .w(400)
                          //     .s(14)
                          //     .c(context.textPrimary.withOpacity(0.85)),

                          SizedBox(width: 8),
                          (state.adDetail!.beginDate ?? "").w(400).s(14)
                        ],
                      ),
                    ],
                  ),
                ),
                Assets.images.icArrowRight.svg(width: 18, height: 18),
                SizedBox(width: 16)
              ],
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Color(0xFF0096B2).withOpacity(0.75),
                  ),
                  margin: const EdgeInsets.only(left: 16),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  child: state.adDetail!.adAuthorType
                      .getLocalizedName()
                      .s(13)
                      .w(500)
                      .c(context.textPrimaryInverse),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Color(0xFF0096B2).withOpacity(0.75),
                  ),
                  margin: const EdgeInsets.only(left: 12, right: 16),
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Assets.images.icTrustedSeller.svg(width: 15, height: 15),
                      SizedBox(width: 6),
                      Strings.commonTrustedSeller
                          .s(13)
                          .w(500)
                          .c(context.textPrimaryInverse)
                          .copyWith(
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
          ],
        ),
        onTap: () {
          context.router.push(
            AdListRoute(
              adListType: AdListType.adsByUser,
              keyWord: "",
              title: state.adDetail?.seller?.fullName ?? "",
              sellerTin: state.adDetail?.seller?.tin,
            ),
          );
        },
      ),
      SizedBox(height: 4),
      Visibility(
        visible: state.adDetail?.hasAddress == true,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 4),
              Strings.adDetailLocation.w(600).s(14),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Assets.images.icLocation.svg(width: 16, height: 16),
                  SizedBox(width: 4),
                  (state.adDetail!.actualAddress)
                      .w(700)
                      .s(12)
                      .c(Color(0xFF5C6AC3)),
                ],
              ),
            ],
          ),
        ),
      ),
      SizedBox(height: 12),
      CustomDivider(startIndent: 16, endIndent: 16),
      // SizedBox(height: 8),
    ];
  }

  Widget _buildAddressBlock(BuildContext context, AdDetailState state) {
    return Visibility(
      visible: state.adDetail?.address != null,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Strings.adDetailLocation.w(600).s(14),
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
                    .c(context.textPrimary)
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
              child: CustomDivider(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactsBlock(BuildContext context, AdDetailState state) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(width: 16),
        Flexible(
          flex: 4,
          child: InkWell(
              borderRadius: BorderRadius.circular(10),
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
                cubit(context).increaseAdStats(StatsType.message);
                try {
                  launch("sms://${state.adDetail!.sellerPhoneNumber}");
                } catch (e) {}
              }),
        ),
        SizedBox(width: 12),
        Flexible(
          flex: 5,
          child: InkWell(
              borderRadius: BorderRadius.circular(10),
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
                              ? (state.adDetail?.sellerPhoneNumber
                                      ?.getFormattedPhoneNumber() ??
                                  "")
                              : Strings.adDetailShowPhone)
                          .w(500)
                          .s(16)
                          .c(Color(0xEC6CA86B))
                          .copyWith(textAlign: TextAlign.center),
                    )
                  ],
                ),
              ),
              onTap: () {
                if (state.isPhoneVisible) {
                  try {
                    launch(
                        "tel://${state.adDetail!.sellerPhoneNumber?.getFormattedPhoneNumber() ?? ""}");
                  } catch (e) {}
                } else {
                  cubit(context).setPhoneNumberVisibility();
                }
              }),
        ),
        SizedBox(width: 16),
      ],
    );
  }

  Widget _buildSimilarAds(BuildContext context, AdDetailState state) {
    if (cubit(context).hasSimilarAds()) {
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
            loadingState: state.similarAdsState,
            loadingBody: HorizontalAdListShimmer(),
            successBody: HorizontalAdListWidget(
              ads: state.similarAds,
              onItemClicked: (Ad ad) {
                context.router.push(AdDetailRoute(adId: ad.id));
              },
              onFavoriteClicked: (Ad ad) {
                cubit(context).similarAdsUpdateFavorite(ad);
              },
              onCartClicked: (Ad ad) {
                cubit(context).similarAdsUpdateCart(ad);
              },
              onBuyClicked: (Ad ad) {
                context.router.push(OrderCreationRoute(adId: ad.id));
              },
            ),
            onRetryClicked: () {
              cubit(context).getSimilarAds();
            },
          ),
        ],
      );
    } else {
      return Center();
    }
  }

  Widget _buildOwnerAdsWidget(BuildContext context, AdDetailState state) {
    if (cubit(context).hasOwnerOtherAds()) {
      return Column(
        children: [
          SizedBox(height: 12),
          SeeAllWidget(
            onClicked: () {
              context.router.push(
                AdListRoute(
                  adListType: AdListType.adsByUser,
                  keyWord: '',
                  title: Strings.adDetailAuthorAds,
                  sellerTin: state.adDetail?.seller?.tin,
                ),
              );
            },
            title: Strings.adDetailAuthorAds,
          ),
          LoaderStateWidget(
            isFullScreen: false,
            onRetryClicked: () {
              cubit(context).getOwnerOtherAds();
            },
            loadingState: state.ownerAdsState,
            loadingBody: HorizontalAdListShimmer(),
            successBody: HorizontalAdListWidget(
              ads: state.ownerAds,
              onItemClicked: (Ad ad) {
                context.router.push(AdDetailRoute(adId: ad.id));
              },
              onFavoriteClicked: (Ad ad) {
                cubit(context).ownerAdUpdateFavorite(ad);
              },
              onCartClicked: (Ad ad) {
                cubit(context).ownerAdUpdateCart(ad);
              },
              onBuyClicked: (Ad ad) {
                context.router.push(OrderCreationRoute(adId: ad.id));
              },
            ),
          ),
        ],
      );
    } else {
      return Center();
    }
  }

  Widget _buildRecentlyViewedAdsWidget(
    BuildContext context,
    AdDetailState state,
  ) {
    if (cubit(context).hasRecentlyViewedAds()) {
      return Column(
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
            onRetryClicked: () {
              cubit(context).getRecentlyViewedAds();
            },
            loadingState: state.recentlyViewedAdsState,
            loadingBody: HorizontalAdListShimmer(),
            successBody: HorizontalAdListWidget(
              ads: state.recentlyViewedAds,
              onItemClicked: (Ad ad) {
                context.router.push(AdDetailRoute(adId: ad.id));
              },
              onFavoriteClicked: (Ad ad) {
                cubit(context).recentlyViewedAdUpdateFavorite(ad);
              },
              onCartClicked: (Ad ad) {
                cubit(context).recentlyViewedAdUpdateCart(ad);
              },
              onBuyClicked: (Ad ad) {
                context.router.push(OrderCreationRoute(adId: ad.id));
              },
            ),
          ),
        ],
      );
    } else {
      return Center();
    }
  }

  void _showReportTypeBottomSheet(BuildContext context) {
    showCupertinoModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Material(
          child: Container(
            decoration: BoxDecoration(
              color: context.bottomSheetColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 20),
                BottomSheetTitle(
                  title: Strings.sendReportActionsTitle,
                  onCloseClicked: () {
                    context.router.pop();
                  },
                ),
                SizedBox(height: 16),
                ActionListItem(
                  item: "",
                  title: Strings.reportAdsReportTitle,
                  icon: Assets.images.icSubmitReport,
                  onClicked: (item) {
                    Navigator.pop(context);
                    _showReportPage(context, ReportType.AD_REPORT);
                  },
                ),
                ActionListItem(
                  item: "",
                  title: Strings.reportAdsBlockTitle,
                  icon: Assets.images.icSubmitBlock,
                  onClicked: (item) {
                    Navigator.pop(context);
                    _showReportPage(context, ReportType.AD_BLOCK);
                  },
                ),
                SizedBox(height: 32),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showReportPage(
    BuildContext context,
    ReportType reportType,
  ) async {
    final isReported = await showCupertinoModalBottomSheet(
      context: context,
      builder: (context) => SubmitReportPage(adId, reportType),
    );
  }
}

void _showSmInstallmentsPage(BuildContext context, AdDetailState state) async {
  final smInstallmentsPage = InstallmentInfoPage(detail: state.adDetail!);
  var result = await showCupertinoModalBottomSheet(
    isDismissible: false,
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return smInstallmentsPage;
    },
  );
}
