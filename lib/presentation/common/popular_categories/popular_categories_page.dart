import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:onlinebozor/common/base/base_page.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/widgets/app_bar/common_app_bar.dart';
import 'package:onlinebozor/common/widgets/category/popular_category_horizontal.dart';
import 'package:onlinebozor/domain/model/popular_category/popular_category_response.dart';
import 'package:onlinebozor/presentation/common/popular_categories/cubit/popular_categories_cubit.dart';

import '../../../common/widgets/common_button.dart';

@RoutePage()
class PopularCategoriesPage extends BasePage<PopularCategoriesCubit,
    PopularCategoriesBuildable, PopularCategoriesListenable> {
  const PopularCategoriesPage({super.key});

  @override
  Widget builder(BuildContext context, PopularCategoriesBuildable state) {
    return Scaffold(
        appBar: CommonAppBar(() => context.router.pop(), "Ommobop Category"),
        body: state.categoriesPagingController == null
            ? SizedBox()
            : SizedBox(
                child: PagedGridView<int, PopularCategoryResponse>(
                  shrinkWrap: true,
                  addAutomaticKeepAlives: false,
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                  pagingController: state.categoriesPagingController!,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    crossAxisCount: 2,
                  ),
                  builderDelegate:
                      PagedChildBuilderDelegate<PopularCategoryResponse>(
                    firstPageErrorIndicatorBuilder: (_) {
                      return SizedBox(
                        height: 100,
                        child: Center(
                          child: Column(
                            children: [
                              "Xatolik yuz berdi?"
                                  .w(400)
                                  .s(14)
                                  .c(context.colors.textPrimary),
                              SizedBox(height: 12),
                              CommonButton(
                                  onPressed: () {},
                                  type: ButtonType.elevated,
                                  child: "Qayta urinish".w(400).s(15))
                            ],
                          ),
                        ),
                      );
                    },
                    firstPageProgressIndicatorBuilder: (_) {
                      return SizedBox(
                        height: 160,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Colors.blue,
                          ),
                        ),
                      );
                    },
                    noItemsFoundIndicatorBuilder: (_) {
                      return Center(
                          child: Text("Hech qanday element topilmadi"));
                    },
                    noMoreItemsIndicatorBuilder: (_) {
                      return Center(child: Text("Boshqa Item Yo'q"));
                    },
                    newPageProgressIndicatorBuilder: (_) {
                      return SizedBox(
                        height: 160,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Colors.blue,
                          ),
                        ),
                      );
                    },
                    newPageErrorIndicatorBuilder: (_) {
                      return SizedBox(
                        height: 160,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Colors.blue,
                          ),
                        ),
                      );
                    },
                    transitionDuration: Duration(milliseconds: 100),
                    itemBuilder: (context, item, index) =>
                        AppPopularCategoryHorizontal(
                      popularCategoryResponse: item,
                      onClick: (value) {},
                    ),
                  ),
                ),
              ));
  }
}
