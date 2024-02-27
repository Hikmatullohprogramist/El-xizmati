import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';

import '../../../../../common/gen/assets/assets.gen.dart';
import '../../../../../common/widgets/category/category_widget.dart';
import '../../../../../common/widgets/loading/loader_state_widget.dart';
import '../../../../../data/responses/category/category/category_response.dart';
import 'cubit/selection_nested_category_cubit.dart';

@RoutePage()
class SelectionNestedCategoryPage
    extends BasePage<PageCubit, PageState, PageEvent> {
  const SelectionNestedCategoryPage(this.onResult, {super.key});

  final void Function(CategoryResponse categoryResponse) onResult;

  @override
  void onEventEmitted(BuildContext context, PageEvent event) {
    switch (event.pageEventType) {
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
      appBar: AppBar(
        leading: IconButton(
          icon: Assets.images.icArrowLeft.svg(),
          onPressed: () {
            cubit(context).backWithoutSelectedCategory();
          },
        ),
        elevation: 0.5,
        backgroundColor: Colors.white,
        centerTitle: true,
        bottomOpacity: 1,
        title: (state.selectedCategory?.name ?? "")
            .w(500)
            .s(16)
            .c(context.colors.textPrimary),
      ),
      body: LoaderStateWidget(
        isFullScreen: true,
        loadingState: state.categoriesState,
        child: ListView.separated(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: state.categories.length,
          itemBuilder: (context, index) {
            return AppCategoryWidget(
              category: state.categories[index],
              onClicked: (CategoryResponse categoryResponse) {
                cubit(context).selectCategory(categoryResponse);
              },
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider(height: 1, indent: 54, color: Color(0xFFE5E9F3));
          },
        ),
      ),
    );
  }
}
