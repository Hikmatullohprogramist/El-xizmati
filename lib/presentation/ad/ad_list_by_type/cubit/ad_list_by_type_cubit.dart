import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/enum/enums.dart';

import '../../../../common/core/base_cubit.dart';
import '../../../../domain/models/ad/ad.dart';
import '../../../../domain/models/ad/ad_type.dart';
import '../../../../data/repositories/ad_repository.dart';
import '../../../../data/repositories/common_repository.dart';
import '../../../../data/repositories/favorite_repository.dart';

part 'ad_list_by_type_cubit.freezed.dart';

part 'ad_list_by_type_state.dart';

@injectable
class AdListByTypeCubit
    extends BaseCubit<AdListByTypeBuildable, AdListByTypeListenable> {
  AdListByTypeCubit(
      this.adRepository, this.commonRepository, this.favoriteRepository)
      : super(AdListByTypeBuildable());

  Future<void> setAdType(AdType adType) async {
    updateState((buildable) => buildable.copyWith(adType: adType));
    getHome();
  }

  Future<void> getHome() async {
    await Future.wait([
      getCheapAdsByType(),
      getPopularAdsByType(),
      getController(),
    ]);
  }

  static const _pageSize = 20;

  final AdRepository adRepository;
  final CommonRepository commonRepository;
  final FavoriteRepository favoriteRepository;

  Future<void> getCheapAdsByType() async {
    try {
      final cheapAds = await adRepository.getCheapAdsByType(
          adType: currentState.adType, page: 1, limit: 10);
      updateState((buildable) => buildable.copyWith(
          cheapAds: cheapAds, cheapAdsState: LoadingState.success));
    } on DioException catch (e, stackTrace) {
      updateState(
        (buildable) => buildable.copyWith(cheapAdsState: LoadingState.error),
      );
      log.e(e.toString(), error: e, stackTrace: stackTrace);
      display.error(e.toString());
    }
  }

  Future<void> getPopularAdsByType() async {
    try {
      final popularAds = await adRepository.getPopularAdsByType(
        adType: currentState.adType,
        page: 1,
        limit: 10,
      );
      updateState(
        (buildable) => buildable.copyWith(
          popularAds: popularAds,
          popularAdsState: LoadingState.success,
        ),
      );
    } on DioException catch (e, stackTrace) {
      updateState((buildable) =>
          buildable.copyWith(popularAdsState: LoadingState.error));
      log.e(e.toString(), error: e, stackTrace: stackTrace);
      display.error(e.toString());
    }
  }

  Future<void> getController() async {
    try {
      final controller =
          currentState.adsPagingController ?? getAdsController(status: 1);
      updateState((buildable) => buildable.copyWith(adsPagingController: controller));
    } on DioException catch (e, stackTrace) {
      log.e(e.toString(), error: e, stackTrace: stackTrace);
      display.error(e.toString());
    } finally {
      log.i(currentState.adsPagingController);
    }
  }

  PagingController<int, Ad> getAdsController({
    required int status,
  }) {
    final adController = PagingController<int, Ad>(
      firstPageKey: 1,
    );
    log.i(currentState.adsPagingController);

    adController.addPageRequestListener(
      (pageKey) async {
        final adsList = await adRepository.getAdsByType(
          adType: currentState.adType,
          page: pageKey,
          limit: _pageSize,
        );
        if (adsList.length <= 19) {
          adController.appendLastPage(adsList);
          log.i(currentState.adsPagingController);
          return;
        }
        adController.appendPage(adsList, pageKey + 1);
        log.i(currentState.adsPagingController);
      },
    );
    return adController;
  }

  Future<void> popularAdsAddFavorite(Ad ad) async {
    try {
      if (!ad.favorite) {
        final backendId = await favoriteRepository.addFavorite(ad);
        final index = currentState.popularAds.indexOf(ad);
        final item = currentState.popularAds.elementAt(index);
        currentState.popularAds.insert(
          index,
          item
            ..favorite = true
            ..backendId = backendId,
        );
      } else {
        await favoriteRepository.removeFavorite(ad);
        final index = currentState.popularAds.indexOf(ad);
        final item = currentState.popularAds.elementAt(index);
        currentState.popularAds.insert(index, item..favorite = false);
      }
    } on DioException catch (error) {
      display.error("xatolik yuz  berdi");
      log.e(error.toString());
    }
  }

  Future<void> cheapAdsAddFavorite(Ad ad) async {
    try {
      if (!ad.favorite) {
        final backendId = await favoriteRepository.addFavorite(ad);
        final index = currentState.cheapAds.indexOf(ad);
        final item = currentState.cheapAds.elementAt(index);
        currentState.cheapAds.insert(
            index,
            item
              ..favorite = true
              ..backendId = backendId);
      } else {
        await favoriteRepository.removeFavorite(ad);
        final index = currentState.cheapAds.indexOf(ad);
        final item = currentState.cheapAds.elementAt(index);
        currentState.cheapAds.insert(index, item..favorite = false);
      }
    } on DioException catch (error) {
      display.error("xatolik yuz  berdi");
      log.e(error.toString());
    }
  }

  Future<void> addFavorite(Ad ad) async {
    try {
      if (!ad.favorite) {
        final backendId = await favoriteRepository.addFavorite(ad);
        final index = currentState.adsPagingController?.itemList?.indexOf(ad) ?? 0;
        final item = currentState.adsPagingController?.itemList?.elementAt(index);
        if (item != null) {
          currentState.adsPagingController?.itemList?.insert(
              index,
              item
                ..favorite = true
                ..backendId = backendId);
          currentState.adsPagingController?.itemList?.removeAt(index);
          currentState.adsPagingController?.notifyListeners();
        }
      } else {
        await favoriteRepository.removeFavorite(ad);
        final index = currentState.adsPagingController?.itemList?.indexOf(ad) ?? 0;
        final item = currentState.adsPagingController?.itemList?.elementAt(index);
        if (item != null) {
          currentState.adsPagingController?.itemList
              ?.insert(index, item..favorite = false);
          currentState.adsPagingController?.itemList?.removeAt(index);
          currentState.adsPagingController?.notifyListeners();
        }
      }
    } on DioException catch (error) {
      display.error("xatolik yuz  berdi");
      log.e(error.toString());
    }
  }
}
