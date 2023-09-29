import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/constants.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/common/router/app_router.dart';
import 'package:onlinebozor/common/widgets/app_bar/common_search_bar.dart';
import 'package:onlinebozor/common/widgets/category/category_widget.dart';
import 'package:onlinebozor/common/widgets/loading/loader_state_widget.dart';

import '../../../domain/model/category/category_response.dart';
import 'cubit/category_cubit.dart';

@RoutePage()
class CategoryPage
    extends BasePage<CategoryCubit, CategoryBuildable, CategoryListenable> {
  const CategoryPage({super.key});

  @override
  Widget builder(BuildContext context, CategoryBuildable state) {
    return Scaffold(
      appBar: CommonSearchBar(
          onPressedMic: () {},
          onPressedNotification: () {
            context.router.push(NotificationRoute());
          },
          onPressedSearch: () {
            context.router.push(SearchRoute());
          }),
      body: LoaderStateWidget(
          isFullScreen: false,
          loadingState: state.categoriesState,
          child: ListView.separated(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: state.categories.length,
            itemBuilder: (context, index) {
              return AppCategoryWidget(
                onClick: (CategoryResponse categoryResponse) {
                  context.router.push(AdListRoute(
                      adListType: AdListType.popularCategory,
                      keyWord: categoryResponse.key_word));
                },
                categoryResponse: state.categories[index],
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider(
                height: 1,
                indent: 54,
                color: Color(0xFFE5E9F3),
              );
            },
          )),
    );
  }
}
