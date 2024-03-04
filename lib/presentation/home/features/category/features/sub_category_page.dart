import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/common/enum/enums.dart';
import 'package:onlinebozor/common/widgets/divider/custom_diverder.dart';
import 'package:onlinebozor/presentation/home/features/category/features/cubit/page_cubit.dart';

import '../../../../../common/colors/static_colors.dart';
import '../../../../../common/router/app_router.dart';
import '../../../../../common/widgets/app_bar/default_app_bar.dart';
import '../../../../../common/widgets/category/category_shimmer.dart';
import '../../../../../common/widgets/category/category_widget.dart';
import '../../../../../common/widgets/loading/loader_state_widget.dart';
import '../../../../../data/responses/category/category/category_response.dart';
import '../../../../../domain/models/ad/ad_list_type.dart';

@RoutePage()
class SubCategoryPage extends BasePage<PageCubit, PageState, PageEvent> {
  const SubCategoryPage(this.subCategoryId, this.title, {super.key});

  final int subCategoryId;
  final String title;

  @override
  void onWidgetCreated(BuildContext context) {
    cubit(context).getCategories(subCategoryId);
  }

  @override
  Widget onWidgetBuild(BuildContext context, PageState state) {
    return Scaffold(
      appBar: DefaultAppBar(title, () => context.router.pop()),
      backgroundColor: StaticColors.backgroundColor,
      body: LoaderStateWidget(
        isFullScreen: true,
        loadingState: state.loadState,
        child: Stack(
          children: [
            state.loadState == LoadingState.loading
                ? _buildShimmerLoadingItems()
                : _buildCategoryItems(state),
          ],
        ),
      ),
    );
  }

  ListView _buildShimmerLoadingItems() {
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

  ListView _buildCategoryItems(PageState state) {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: state.items.length,
      itemBuilder: (context, index) {
        return CategoryWidget(
          onClicked: (CategoryResponse category) {
            context.router.push(
              AdListRoute(
                adListType: AdListType.popularCategoryAds,
                keyWord: category.key_word,
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
