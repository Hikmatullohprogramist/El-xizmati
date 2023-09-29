import 'package:auto_route/annotations.dart';
import 'package:flutter/cupertino.dart';
import 'package:onlinebozor/common/base/base_page.dart';
import 'package:onlinebozor/presentation/home/favorites/favorites/commodity/cubit/commodity_favorites_cubit.dart';

@RoutePage()
class CommodityFavoritesPage extends BasePage<CommodityFavoritesCubit, CommodityFavoritesBuildable,
    CommodityFavoritesListenable> {
  const CommodityFavoritesPage({super.key});

  @override
  Widget builder(BuildContext context, CommodityFavoritesBuildable state) {
    return Center(
      child: Text("Commodity Servise"),
    );
  }
}
