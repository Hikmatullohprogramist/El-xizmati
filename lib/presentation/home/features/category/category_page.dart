import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/common/gen/assets/assets.gen.dart';
import 'package:onlinebozor/common/router/app_router.dart';
import 'package:onlinebozor/common/widgets/category/category_widget.dart';
import 'package:onlinebozor/common/widgets/divider/custom_diverder.dart';
import 'package:onlinebozor/common/widgets/loading/loader_state_widget.dart';

import '../../../../common/colors/static_colors.dart';
import '../../../../common/gen/localization/strings.dart';
import '../../../../common/widgets/category/category_shimmer.dart';
import '../../../../data/responses/category/category/category_response.dart';
import '../../../../domain/models/ad/ad_list_type.dart';
import 'cubit/page_cubit.dart';

@RoutePage()
class CategoryPage extends BasePage<PageCubit, PageState, PageEvent> {
  CategoryPage({super.key});

  final searchTextController = TextEditingController();

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
    // searchTextController.updateOnRestore(state.searchQuery);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        toolbarHeight: 64,
        title: TextField(
          controller: searchTextController,
          decoration: InputDecoration(
            hintText: Strings.categoryListSearchHint,
            border: InputBorder.none,
            icon: Assets.images.iconSearch.svg(),
          ),
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color(0xFF41455F),
          ),
          onChanged: (value) {
            cubit(context).setSearchQuery(value);
          },
        ),
      ),
      backgroundColor: StaticColors.backgroundColor,
      body: LoaderStateWidget(
        isFullScreen: true,
        loadingState: state.loadState,
        loadingBody: _buildLoadingBody(),
        successBody: _buildSuccessBody(state),
        onRetryClicked: () => cubit(context).getCategories(),
      ),
    );
  }

  ListView _buildLoadingBody() {
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

  ListView _buildSuccessBody(PageState state) {
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
