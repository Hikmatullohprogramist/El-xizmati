import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/presentation/home/features/category/features/cubit/page_cubit.dart';

import '../../../../../common/colors/static_colors.dart';
import '../../../../../common/router/app_router.dart';
import '../../../../../common/widgets/app_bar/default_app_bar.dart';
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
        child: ListView.separated(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: state.items.length,
          itemBuilder: (context, index) {
            return AppCategoryWidget(
              onClicked: (CategoryResponse categoryResponse) {
                context.router.push(
                  AdListRoute(
                    adListType: AdListType.popularCategoryAds,
                    keyWord: categoryResponse.key_word,
                    title: categoryResponse.name,
                    sellerTin: null,
                  ),
                );
              },
              category: state.items[index],
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider(indent: 54, color: Color(0xFFE5E9F3));
          },
        ),
      ),
    );
  }
}
