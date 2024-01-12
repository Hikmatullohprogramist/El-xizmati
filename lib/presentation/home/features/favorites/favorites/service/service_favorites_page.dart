import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/router/app_router.dart';
import 'package:onlinebozor/presentation/home/features/favorites/favorites/service/cubit/service_favorites_cubit.dart';

import '../../../../../../common/gen/localization/strings.dart';
import '../../../../../../common/widgets/ad/vertical_ad_widget.dart';
import '../../../../../../common/widgets/common/common_button.dart';
import '../../../../../../common/widgets/favorite/favorite_empty_widget.dart';
import '../../../../../../domain/models/ad.dart';

@RoutePage()
class ServiceFavoritesPage extends BasePage<ServiceFavoritesCubit,
    ServiceFavoritesBuildable, ServiceFavoritesListenable> {
  const ServiceFavoritesPage({super.key});

  @override
  Widget builder(BuildContext context, ServiceFavoritesBuildable state) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PagedGridView<int, Ad>(
        shrinkWrap: true,
        addAutomaticKeepAlives: true,
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        pagingController: state.adsPagingController!,
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
                        child: Strings.loadingStateRetry.w(400).s(15))
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
            invokeFavorite: (value) =>
                context.read<ServiceFavoritesCubit>().removeFavorite(value),
            invoke: (value) {
              context.router.push(AdDetailRoute(adId: value.id));
            },
          ),
        ),
      ),
    );
  }
}
