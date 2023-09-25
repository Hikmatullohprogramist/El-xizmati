import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';

import '../../../common/loading_state.dart';
import '../../../common/widgets/loading/loader_state_widget.dart';
import 'cubit/favorites_cubit.dart';

@RoutePage()
class FavoritesPage
    extends BasePage<FavoritesCubit, FavoritesBuildable, FavoritesListenable> {
  const FavoritesPage({super.key});

  @override
  Widget builder(BuildContext context, FavoritesBuildable state) {
    return LoaderStateWidget(
        isFullScreen: true,
        loadingState: AppLoadingState.loading,
        child: "misol".w(400));
  }
}
