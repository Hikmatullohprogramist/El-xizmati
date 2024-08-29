import 'package:El_xizmati/domain/models/ad/ad_list_type.dart';
import 'package:El_xizmati/presentation/router/app_router.dart';
import 'package:El_xizmati/presentation/support/cubit/base_page.dart';
import 'package:El_xizmati/presentation/support/extensions/color_extension.dart';
import 'package:El_xizmati/presentation/widgets/category/category_shimmer.dart';
import 'package:El_xizmati/presentation/widgets/divider/custom_divider.dart';
import 'package:El_xizmati/presentation/widgets/loading/loader_state_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../../data/datasource/network/sp_response/category/category_response/category_response.dart';
import '../../../../widgets/category/category_widget.dart';
import 'category_cubit.dart';

@RoutePage()
class CategoryPage extends BasePage<CategoryCubit, CategoryState, CategoryEvent> {
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
          keyWord: event.category!.name,
          title: event.category!.name,
          sellerTin: null,
        ));
    }
  }

  @override
  Widget onWidgetBuild(BuildContext context, CategoryState state) {
    return Scaffold(
      appBar: AppBar(
        /*backgroundColor: context.appBarColor,
        elevation: 0.5,
        toolbarHeight: 64,
        leadingWidth: 0,
        leading: Assets.images.icArrowLeft.svg(color: Colors.transparent),
        actions: [
          Expanded(
            child: Container(
              margin: EdgeInsets.fromLTRB(0, 4, 0, 4),
              child: SearchInputField(
                hintText: Strings.searchHintCategory,
                onQueryChanged: (query) => cubit(context).setSearchQuery(query),
              ),
            ),
          ),
        ],*/
        backgroundColor: context.backgroundWhiteColor,
        elevation: 0,
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: context.backgroundWhiteColor,
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

  GridView _buildSuccessBody(CategoryState state) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,mainAxisSpacing: 8,crossAxisSpacing: 8,childAspectRatio: 0.8),
      padding: EdgeInsets.all(24),
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index){
        return CategoryWidget(
          onClicked: (Results category) {
            cubit(context).setSelectedCategory(category);
          },
          category: state.visibleItems[index],
        );
      },
      itemCount: state.visibleItems.length,
    );
    /*ListView.separated(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: state.visibleItems.length,
      itemBuilder: (context, index) {
        return CategoryWidget(
          onClicked: (Results category) {
            cubit(context).setSelectedCategory(category);
          },
          category: state.visibleItems[index],
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return CustomDivider(startIndent: 48, color: Color(0xFFE5E9F3));
      },
    );*/
  }
}
