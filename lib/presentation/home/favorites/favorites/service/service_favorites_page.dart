import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/base/base_page.dart';
import 'package:onlinebozor/common/router/app_router.dart';
import 'package:onlinebozor/common/widgets/favorite_empty_widget.dart';
import 'package:onlinebozor/presentation/home/favorites/favorites/service/cubit/service_favorites_cubit.dart';

@RoutePage()
class ServiceFavoritesPage extends BasePage<ServiceFavoritesCubit,
    ServiceFavoritesBuildable, ServiceFavoritesListenable> {
  const ServiceFavoritesPage({super.key});

  @override
  Widget builder(BuildContext context, ServiceFavoritesBuildable state) {
    return Scaffold(
        backgroundColor: Colors.white, body: FavoriteEmptyWidget(callBack: () {
      context.router.push(DashboardRoute());
    },));
  }
}
