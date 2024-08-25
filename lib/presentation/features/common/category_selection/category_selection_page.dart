import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:El_xizmati/core/gen/assets/assets.gen.dart';
import 'package:El_xizmati/core/gen/localization/strings.dart';
import 'package:El_xizmati/domain/models/ad/ad_type.dart';
import 'package:El_xizmati/domain/models/category/category.dart';
import 'package:El_xizmati/presentation/support/cubit/base_page.dart';
import 'package:El_xizmati/presentation/support/extensions/color_extension.dart';
import 'package:El_xizmati/presentation/widgets/category/category_shimmer.dart';
import 'package:El_xizmati/presentation/widgets/category/category_widget.dart';
import 'package:El_xizmati/presentation/widgets/divider/custom_divider.dart';
import 'package:El_xizmati/presentation/widgets/loading/loader_state_widget.dart';
import 'package:El_xizmati/presentation/widgets/search/search_input_field.dart';

import 'category_selection_cubit.dart';

@RoutePage()
class CategorySelectionPage extends BasePage<CategorySelectionCubit,
    CategorySelectionState, CategorySelectionEvent> {
  final AdType adType;
  final void Function(Category category) onResult;

  CategorySelectionPage(this.adType, this.onResult, {super.key});

  final searchTextController = TextEditingController();

  @override
  void onWidgetCreated(BuildContext context) {
    cubit(context).setInitialParams(adType);
  }

  @override
  void onEventEmitted(BuildContext context, CategorySelectionEvent event) {
    switch (event.type) {
      case CategorySelectionEventType.closePage:
        {
          if (event.category != null) {
            onResult(event.category!);
          }
          context.router.pop(event.category);
        }
    }
  }

  @override
  Widget onWidgetBuild(BuildContext context, CategorySelectionState state) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.appBarColor,
        elevation: 0.5,
        toolbarHeight: 64,
        actions: [
          IconButton(
            onPressed: () => cubit(context).backWithoutSelectedCategory(),
            icon: Assets.images.icArrowLeft.svg(),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.fromLTRB(0, 4, 0, 4),
              child: SearchInputField(
                hintText: Strings.searchHintCategory,
                onQueryChanged: (query) => cubit(context).setSearchQuery(query),
              ),
            ),
          ),
        ],
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

  ListView _buildSuccessBody(CategorySelectionState state) {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: state.visibleItems.length,
      itemBuilder: (context, index) {
        return CategoryWidget(
          category: state.visibleItems[index],
          isShowCount: false,
          onClicked: (category) => cubit(context).selectCategory(category),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return CustomDivider(startIndent: 54, color: Color(0xFFE5E9F3));
      },
    );
  }
}
