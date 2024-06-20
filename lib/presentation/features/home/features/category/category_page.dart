import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/core/gen/localization/strings.dart';
import 'package:onlinebozor/domain/models/ad/ad_list_type.dart';
import 'package:onlinebozor/domain/models/category/category.dart';
import 'package:onlinebozor/presentation/router/app_router.dart';
import 'package:onlinebozor/presentation/support/cubit/base_page.dart';
import 'package:onlinebozor/presentation/support/extensions/color_extension.dart';
import 'package:onlinebozor/presentation/widgets/category/category_shimmer.dart';
import 'package:onlinebozor/presentation/widgets/category/category_widget.dart';
import 'package:onlinebozor/presentation/widgets/divider/custom_divider.dart';
import 'package:onlinebozor/presentation/widgets/form_field/custom_text_form_field.dart';
import 'package:onlinebozor/presentation/widgets/loading/loader_state_widget.dart';

import 'category_cubit.dart';

@RoutePage()
class CategoryPage
    extends BasePage<CategoryCubit, CategoryState, CategoryEvent> {
  CategoryPage({super.key});

  final searchTextController = TextEditingController();

  @override
  void onEventEmitted(BuildContext context, CategoryEvent event) {
    switch (event.type) {
      case CategoryEventType.onOpenSubCategory:
        context.router.push(SubCategoryRoute(
          title: event.category!.name,
          parentId: event.category!.id,
          categories: event.categories!,
        ));
      case CategoryEventType.onOpenProductList:
        context.router.push(AdListRoute(
          adListType: AdListType.popularCategoryAds,
          keyWord: event.category!.keyWord,
          title: event.category!.name,
          sellerTin: null,
        ));
    }
  }

  @override
  Widget onWidgetBuild(BuildContext context, CategoryState state) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.appBarColor,
        elevation: 0,
        toolbarHeight: 64,
        // leadingWidth: 0,
        actions: [
          Expanded(
            child: Container(
              height: 62,
              margin: EdgeInsets.only(left: 16, top: 6, right: 16, bottom: 6),
              child: CustomTextFormField(
                height: 42,
                controller: searchTextController,
                hint: Strings.searchHintCategory,
                inputType: TextInputType.text,
                keyboardType: TextInputType.text,
                maxLines: 1,
                isStrokeEnabled: false,
                enabledColor: context.cardColor,
                onChanged: (value) {
                  cubit(context).setSearchQuery(value);
                },
              ),
            ),
          ),
        ],
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: context.backgroundGreyColor,
      body: LoaderStateWidget(
        isFullScreen: true,
        loadingState: state.loadState,
        loadingBody: _buildLoadingBody(),
        successBody: _buildSuccessBody(state),
        onRetryClicked: () => cubit(context).getCatalogCategories(),
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

  ListView _buildSuccessBody(CategoryState state) {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: state.visibleItems.length,
      itemBuilder: (context, index) {
        return CategoryWidget(
          onClicked: (Category category) {
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
