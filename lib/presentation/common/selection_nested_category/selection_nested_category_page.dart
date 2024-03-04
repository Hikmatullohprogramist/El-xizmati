import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/core/base_page.dart';

import '../../../../../common/widgets/category/category_widget.dart';
import '../../../../../common/widgets/loading/loader_state_widget.dart';
import '../../../../../data/responses/category/category/category_response.dart';
import '../../../common/widgets/app_bar/default_app_bar.dart';
import 'cubit/page_cubit.dart';

@RoutePage()
class SelectionNestedCategoryPage
    extends BasePage<PageCubit, PageState, PageEvent> {
  const SelectionNestedCategoryPage(this.onResult, {super.key});

  final void Function(CategoryResponse categoryResponse) onResult;

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
    return Scaffold(
      appBar: DefaultAppBar(
        state.selectedCategory?.name ?? "",
        () => cubit(context).backWithoutSelectedCategory(),
      ),
      body: LoaderStateWidget(
        isFullScreen: true,
        loadingState: state.categoriesState,
        child: ListView.separated(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: state.visibleCategories.length,
          itemBuilder: (context, index) {
            return CategoryWidget(
              category: state.visibleCategories[index],
              onClicked: (CategoryResponse categoryResponse) {
                cubit(context).selectCategory(categoryResponse);
              },
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
