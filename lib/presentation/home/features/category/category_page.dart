import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/common/router/app_router.dart';
import 'package:onlinebozor/common/widgets/app_bar/search_app_bar.dart';
import 'package:onlinebozor/common/widgets/category/category_widget.dart';
import 'package:onlinebozor/common/widgets/divider/custom_diverder.dart';
import 'package:onlinebozor/common/widgets/loading/loader_state_widget.dart';

import '../../../../common/colors/static_colors.dart';
import '../../../../common/widgets/category/category_shimmer.dart';
import '../../../../data/responses/category/category/category_response.dart';
import '../../../../domain/models/ad/ad_list_type.dart';
import 'cubit/page_cubit.dart';

@RoutePage()
class CategoryPage extends BasePage<PageCubit, PageState, PageEvent> {
  const CategoryPage({super.key});

  @override
  void onEventEmitted(BuildContext context, PageEvent event) {
    switch (event.type) {
      case PageEventType.onOpenSubCategory:
        {
          context.router.push(
            SubCategoryRoute(
                title: event.category!.name ?? "",
                parentId: event.category!.id,
                categories: event.categories!),
          );
        }
      case PageEventType.onOpenProductList:
        {
          context.router.push(
            AdListRoute(
              adListType: AdListType.popularCategoryAds,
              keyWord: event.category!.key_word,
              title: event.category!.name,
              sellerTin: null,
            ),
          );
        }
    }
  }

  @override
  Widget onWidgetBuild(BuildContext context, PageState state) {
    return Scaffold(
      appBar: SearchAppBar(
        onSearchClicked: () => context.router.push(SearchRoute()),
        onMicrophoneClicked: () {},
        onFavoriteClicked: () => context.router.push(FavoriteListRoute()),
        onNotificationClicked: () =>
            context.router.push(NotificationListRoute()),
      ),
      backgroundColor: StaticColors.backgroundColor,
      body: LoaderStateWidget(
        isFullScreen: true,
        loadingState: state.loadState,
        loadingBody: _buildShimmerLoadingItems(),
        successBody: _buildCategoryItems(state),
        onRetryClicked: () => cubit(context).getCategories(),
      ),
    );
  }

  ListView _buildShimmerLoadingItems() {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: 20,
      itemBuilder: (context, index) {
        return CategoryShimmer();
      },
      separatorBuilder: (BuildContext context, int index) {
        return CustomDivider(startIndent: 48, color: Color(0xFFE5E9F3));
      },
    );
  }

  ListView _buildCategoryItems(PageState state) {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: state.visibleItems.length,
      itemBuilder: (context, index) {
        return CategoryWidget(
          onClicked: (CategoryResponse category) {
            cubit(context).setSelectedCategory(category);
          },
          category: state.visibleItems[index],
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return CustomDivider(startIndent: 48, color: Color(0xFFE5E9F3));
      },
    );
  }
}
