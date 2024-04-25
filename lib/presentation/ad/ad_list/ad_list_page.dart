import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/localization/strings.dart';
import 'package:onlinebozor/common/widgets/ad/vertical/vertical_ad_shimmer.dart';
import 'package:onlinebozor/common/widgets/app_bar/default_app_bar.dart';
import 'package:onlinebozor/common/widgets/button/custom_elevated_button.dart';
import 'package:onlinebozor/presentation/ad/ad_list/cubit/page_cubit.dart';

import '../../../common/core/base_page.dart';
import '../../../common/router/app_router.dart';
import '../../../common/widgets/ad/vertical/vertical_ad_widget.dart';
import '../../../domain/models/ad/ad.dart';
import '../../../domain/models/ad/ad_list_type.dart';
import '../../../domain/models/ad/ad_type.dart';

@RoutePage()
class AdListPage extends BasePage<PageCubit, PageState, PageEvent> {
  const AdListPage({
    super.key,
    required this.adListType,
    required this.keyWord,
    this.title,
    this.sellerTin,
    this.adId,
    this.adType,
  });

  final AdListType adListType;
  final String? keyWord;
  final String? title;
  final int? sellerTin;
  final int? adId;
  final AdType? adType;

  @override
  void onWidgetCreated(BuildContext context) {
    cubit(context)
        .setInitialParams(adListType, keyWord, sellerTin, adId, adType);
  }

  @override
  void onEventEmitted(BuildContext context, PageEvent event) {
    switch (event.type) {
      case PageEventType.navigationToAuthStart:
        context.router.push(AuthStartRoute());
    }
  }

  @override
  Widget onWidgetBuild(BuildContext context, PageState state) {
    double width;
    double height;
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: DefaultAppBar(
        titleText: title ?? "",
        backgroundColor: context.appBarColor,
        onBackPressed: () => context.router.pop(),
      ),
      backgroundColor: context.backgroundColor,
      body: PagedGridView<int, Ad>(
        shrinkWrap: true,
        addAutomaticKeepAlives: true,
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        pagingController: state.controller!,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: width / height,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          crossAxisCount: 2,
          mainAxisExtent: 256,
        ),
        builderDelegate: PagedChildBuilderDelegate<Ad>(
          firstPageErrorIndicatorBuilder: (_) {
            return SizedBox(
              height: 100,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Strings.commonEmptyMessage
                        .w(400)
                        .s(14)
                        .c(context.colors.textPrimary),
                    SizedBox(height: 12),
                    CustomElevatedButton(
                      text: Strings.commonRetry,
                      onPressed: () {},
                    )
                  ],
                ),
              ),
            );
          },
          firstPageProgressIndicatorBuilder: (_) {
            return GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of columns
                childAspectRatio: 0.60,
                crossAxisSpacing: 15.0, // Spacing between columns
                mainAxisSpacing: 1.0,
              ),
              itemCount: 10,
              // Number of items in the grid
              itemBuilder: (context, index) {
                return VerticalAdShimmer();
              },
            );
          },
          noItemsFoundIndicatorBuilder: (_) {
            return SizedBox(
              height: 200,
              width: double.infinity,
              child: Center(child: Text(Strings.commonEmptyMessage)),
            );
          },
          newPageProgressIndicatorBuilder: (_) {
            return SizedBox(
              height: 160,
              width: double.infinity,
              child: Center(
                child: CircularProgressIndicator(color: Colors.blue),
              ),
            );
          },
          newPageErrorIndicatorBuilder: (_) {
            return SizedBox(
              height: 160,
              child: Center(
                child: CircularProgressIndicator(color: Colors.blue),
              ),
            );
          },
          transitionDuration: Duration(milliseconds: 100),
          itemBuilder: (context, item, index) => SizedBox(
            height: 90,
            child: VerticalAdWidget(
              ad: item,
              onFavoriteClicked: (value) => cubit(context).changeFavorite(value),
              onClicked: (value) {
                context.router.push(AdDetailRoute(adId: value.id));
              },
            ),
          ),
        ),
      ),
    );
  }
}
