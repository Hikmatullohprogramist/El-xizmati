import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/base/base_page.dart';

import 'cubit/favorites_cubit.dart';

@RoutePage()
class FavoritesPage
    extends BasePage<FavoritesCubit, FavoritesBuildable, FavoritesListenable> {
  const FavoritesPage({super.key});

  @override
  Widget builder(BuildContext context, FavoritesBuildable state) {
    return Center(
      child: Text("Auth Start"),
    );
  }
}
