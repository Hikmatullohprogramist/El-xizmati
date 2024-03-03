import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/widgets/app_bar/default_app_bar.dart';
import 'package:onlinebozor/common/widgets/button/custom_elevated_button.dart';
import 'package:onlinebozor/common/widgets/category/popular_category_vertical.dart';
import 'package:onlinebozor/presentation/common/popular_categories/cubit/page_cubit.dart';

import '../../../common/core/base_page.dart';
import '../../../common/gen/localization/strings.dart';
import '../../../common/router/app_router.dart';
import '../../../common/widgets/category/popular_category_vertical_shimmer.dart';
import '../../../data/responses/category/popular_category/popular_category_response.dart';
import '../../../domain/models/ad/ad_list_type.dart';

@RoutePage()
class PopularCategoriesPage extends BasePage<PageCubit, PageState, PageEvent> {
  const PopularCategoriesPage(this.title, {super.key});

  final String? title;

  @override
  Widget onWidgetBuild(BuildContext context, PageState state) {
    return Scaffold(
      appBar: DefaultAppBar(title ?? "", () => context.router.pop()),
      body: state.controller == null
          ? SizedBox()
          : SizedBox(
              child: PagedListView<int, PopularCategoryResponse>(
                shrinkWrap: true,
                addAutomaticKeepAlives: false,
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                pagingController: state.controller!,
                builderDelegate:
                    PagedChildBuilderDelegate<PopularCategoryResponse>(
                  firstPageErrorIndicatorBuilder: (_) {
                    return SizedBox(
                      height: 60,
                      child: Center(
                        child: Column(
                          children: [
                            Strings.loadingStateError
                                .w(400)
                                .s(14)
                                .c(context.colors.textPrimary),
                            SizedBox(height: 12),
                            CustomElevatedButton(
                              onPressed: () {},
                              text: Strings.loadingStateRetry,
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  firstPageProgressIndicatorBuilder: (_) {
                    return SingleChildScrollView(
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 7,
                        itemBuilder: (BuildContext context, int index) {
                          return PopularCategoryVerticalShimmer();
                        },
                      ),
                    );
                  },
                  noItemsFoundIndicatorBuilder: (_) {
                    return Center(
                        child: Strings.loadingStateNoItemFound.w(400));
                  },
                  newPageProgressIndicatorBuilder: (_) {
                    return SizedBox(
                      height: 60,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Colors.blue,
                        ),
                      ),
                    );
                  },
                  newPageErrorIndicatorBuilder: (_) {
                    return SizedBox(
                      height: 60,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Colors.blue,
                        ),
                      ),
                    );
                  },
                  transitionDuration: Duration(milliseconds: 100),
                  itemBuilder: (context, item, index) => Container(
                    margin: EdgeInsets.symmetric(vertical: 6),
                    child: PopularCategoryVertical(
                      category: item,
                      onItemClicked: (value) {
                        context.router.push(
                          AdListRoute(
                            adListType: AdListType.homeList,
                            keyWord: value.key_word,
                            title: value.name,
                            sellerTin: null,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
