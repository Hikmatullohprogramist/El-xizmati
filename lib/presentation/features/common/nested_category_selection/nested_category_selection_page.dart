import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/core/gen/assets/assets.gen.dart';
import 'package:onlinebozor/core/gen/localization/strings.dart';
import 'package:onlinebozor/domain/models/ad/ad_type.dart';
import 'package:onlinebozor/presentation/support/cubit/base_page.dart';
import 'package:onlinebozor/presentation/widgets/category/category_shimmer.dart';
import 'package:onlinebozor/presentation/widgets/divider/custom_diverder.dart';

import '../../../../../data/datasource/network/responses/category/category/category_response.dart';
import '../../../../../presentation/widgets/category/category_widget.dart';
import '../../../../../presentation/widgets/loading/loader_state_widget.dart';
import 'cubit/nested_category_selection_cubit.dart';

@RoutePage()
class NestedCategorySelectionPage
    extends BasePage<PageCubit, PageState, PageEvent> {
  NestedCategorySelectionPage(this.adType, this.onResult, {super.key});

  final AdType adType;
  final void Function(CategoryResponse categoryResponse) onResult;

  final searchTextController = TextEditingController();

  @override
  void onWidgetCreated(BuildContext context) {
    cubit(context).setInitialParams(adType);
  }

  @override
  void onEventEmitted(BuildContext context, PageEvent event) {
    switch (event.type) {
      case PageEventType.closePage:
        {
          if (event.category != null) {
            onResult(event.category!);
          }
          context.router.pop(event.category);
        }
    }
  }

  @override
  Widget onWidgetBuild(BuildContext context, PageState state) {
    // searchTextController.updateOnRestore(state.searchQuery);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => cubit(context).backWithoutSelectedCategory(),
          icon: Assets.images.icArrowLeft.svg(),
        ),
        // backgroundColor: context.themeOf.backgroundColor,
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
      body: LoaderStateWidget(
        isFullScreen: true,
        loadingState: state.loadState,
        loadingBody: _buildLoadingBody(),
        successBody: _buildSuccessBody(state),
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
          category: state.visibleItems[index],
          isShowCount: false,
          onClicked: (CategoryResponse categoryResponse) {
            cubit(context).selectCategory(categoryResponse);
          },
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return CustomDivider(startIndent: 54, color: Color(0xFFE5E9F3));
      },
    );
  }
}
