import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/controller/controller_exts.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/common/widgets/divider/custom_diverder.dart';
import 'package:onlinebozor/domain/models/ad/ad_type.dart';

import '../../../../../common/widgets/category/category_widget.dart';
import '../../../../../common/widgets/loading/loader_state_widget.dart';
import '../../../../../data/responses/category/category/category_response.dart';
import '../../../common/gen/assets/assets.gen.dart';
import '../../../common/gen/localization/strings.dart';
import '../../../common/widgets/category/category_shimmer.dart';
import 'cubit/page_cubit.dart';

@RoutePage()
class SelectionNestedCategoryPage
    extends BasePage<PageCubit, PageState, PageEvent> {
  SelectionNestedCategoryPage(this.adType, this.onResult, {super.key});

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
