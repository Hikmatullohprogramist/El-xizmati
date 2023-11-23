import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/base/base_cubit.dart';
import 'package:onlinebozor/domain/repository/ad_repository.dart';
import 'package:onlinebozor/domain/repository/favorite_repository.dart';

import '../../../../../../common/enum/loading_enum.dart';
import '../../../../../../domain/model/ad_enum.dart';
import '../../../../../../domain/model/ad_model.dart';

part 'commodity_favorites_cubit.freezed.dart';
part 'commodity_favorites_state.dart';

@injectable
class CommodityFavoritesCubit extends BaseCubit<CommodityFavoritesBuildable,
    CommodityFavoritesListenable> {
  CommodityFavoritesCubit(this._favoriteRepository, this._adRepository)
      : super(const CommodityFavoritesBuildable()) {
    getController();
  }

  final FavoriteRepository _favoriteRepository;
  final AdRepository _adRepository;
  static const _pageSize = 20;

  Future<void> getController() async {
    try {
      final controller =
          buildable.adsPagingController ?? getAdsController(status: 1);
      build((buildable) => buildable.copyWith(adsPagingController: controller));
    } on DioException catch (e, stackTrace) {
      log.e(e.toString(), error: e, stackTrace: stackTrace);
      display.error(e.toString());
    } finally {
      log.i(buildable.adsPagingController);
      // build((buildable) => buildable.copyWith(loading: false));
    }
  }

  PagingController<int, AdModel> getAdsController({
    required int status,
  }) {
    final adController = PagingController<int, AdModel>(
        firstPageKey: 1, invisibleItemsThreshold: 100);
    log.i(buildable.adsPagingController);

    adController.addPageRequestListener(
          (pageKey) async {
        final adsList = await _favoriteRepository.getFavoriteAds();
        if (adsList.length <= 1000) {
          adController.appendLastPage(adsList);
          log.i(buildable.adsPagingController);
          return;
        }
        adController.appendPage(adsList, pageKey + 1);
        log.i(buildable.adsPagingController);
      },
    );
    return adController;
  }

  Future<void> removeFavorite(AdModel adModel) async {
    try {
      await _favoriteRepository.removeFavorite(adModel.id);
      buildable.adsPagingController?.itemList?.remove(adModel);
      buildable.adsPagingController?.notifyListeners();
    } on DioException catch (e) {
      display.error("xatolik yuz berdi");
    }
  }
}
