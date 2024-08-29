import 'package:El_xizmati/data/datasource/network/sp_response/category/category_response/category_response.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:El_xizmati/domain/models/ad/ad_list_type.dart';
import 'package:El_xizmati/domain/models/category/category.dart';
import 'package:El_xizmati/presentation/router/app_router.dart';
import 'package:El_xizmati/presentation/support/cubit/base_page.dart';
import 'package:El_xizmati/presentation/support/extensions/color_extension.dart';
import 'package:El_xizmati/presentation/widgets/app_bar/default_app_bar.dart';
import 'package:El_xizmati/presentation/widgets/category/category_shimmer.dart';
import 'package:El_xizmati/presentation/widgets/category/category_widget.dart';
import 'package:El_xizmati/presentation/widgets/divider/custom_divider.dart';
import 'package:El_xizmati/presentation/widgets/loading/loader_state_widget.dart';

import 'sub_category_cubit.dart';

@RoutePage()
class SubCategoryPage
    extends BasePage<SubCategoryCubit, SubCategoryState, SubCategoryEvent> {
  final String title;
  final int parentId;
  final List<Results> categories;

  const SubCategoryPage({
    super.key,
    required this.title,
    required this.parentId,
    required this.categories,
  });

  @override
  void onWidgetCreated(BuildContext context) {
    cubit(context).setInitialParams(parentId, categories);
  }

  @override
  Widget onWidgetBuild(BuildContext context, SubCategoryState state) {
    return Scaffold(
      appBar: DefaultAppBar(
        titleText: title,
        titleTextColor: context.textPrimary,
        backgroundColor: context.backgroundGreyColor,
        onBackPressed: () => context.router.pop(),
      ),
      backgroundColor: context.backgroundGreyColor,
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
      itemCount: 6,
      itemBuilder: (context, index) {
        return CategoryShimmer();
      },
      separatorBuilder: (BuildContext context, int index) {
        return CustomDivider(startIndent: 54, color: Color(0xFFE5E9F3));
      },
    );
  }

  ListView _buildSuccessBody(SubCategoryState state) {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: state.items.length,
      itemBuilder: (context, index) {
        return CategoryWidget(
          onClicked: (category) {
            context.router.push(
              AdListRoute(
                adListType: AdListType.popularCategoryAds,
                keyWord: category.name,
                title: category.name,
                sellerTin: null,
              ),
            );
          },
          category: state.items[index],
          loadingState: state.loadState,
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return CustomDivider(startIndent: 54, color: Color(0xFFE5E9F3));
      },
    );
  }
}
