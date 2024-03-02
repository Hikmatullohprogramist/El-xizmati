import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/router/app_router.dart';

import '../../../../../../common/gen/localization/strings.dart';
import '../../../../../../common/widgets/ad/vertical_ad_widget.dart';
import '../../../../../common/widgets/ad/horizanral_add_list_shimmer.dart';
import '../../../../../common/widgets/button/common_button.dart';
import '../../../../../../common/widgets/favorite/favorite_empty_widget.dart';
import '../../../../../../domain/models/ad/ad.dart';
import 'cubit/page_cubit.dart';

@RoutePage()
class ServiceFavoritesPage extends BasePage<PageCubit, PageState, PageEvent> {
  const ServiceFavoritesPage({super.key});

  @override
  Widget onWidgetBuild(BuildContext context, PageState state) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PagedGridView<int, Ad>(
        shrinkWrap: true,
        addAutomaticKeepAlives: true,
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        pagingController: state.controller!,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 156 / 286,
          crossAxisSpacing: 16,
          mainAxisSpacing: 24,
          crossAxisCount: 2,
        ),
        builderDelegate: PagedChildBuilderDelegate<Ad>(
          firstPageErrorIndicatorBuilder: (_) {
            return SizedBox(
              height: 100,
              child: Center(
                child: Column(
                  children: [
                    Strings.loadingStateError
                        .w(400)
                        .s(14)
                        .c(context.colors.textPrimary),
                    SizedBox(height: 12),
                    CommonButton(
                        onPressed: () {},
                        type: ButtonType.elevated,
                        text: Strings.loadingStateRetry.w(400).s(15))
                  ],
                ),
              ),
            );
          },
          firstPageProgressIndicatorBuilder: (_) {
            return  GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of columns
                childAspectRatio: 0.60,
                crossAxisSpacing: 15.0, // Spacing between columns
                mainAxisSpacing: 1.0,
              ),
              itemCount: 10,
              // Number of items in the grid
              itemBuilder: (context, index) {
                return HorizontalAddListShimmer();
              },
            );
          },
          noItemsFoundIndicatorBuilder: (_) {
            return FavoriteEmptyWidget(invoke: () {
              context.router.push(DashboardRoute());
            });
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
          itemBuilder: (context, item, index) => VerticalAdWidget(
            favoriteBeChange: false,
            ad: item,
            onFavoriteClicked: (value) =>
                context.read<PageCubit>().removeFavorite(value),
            onClicked: (value) {
              context.router.push(AdDetailRoute(adId: value.id));
            },
          ),
        ),
      ),
    );
  }
}
