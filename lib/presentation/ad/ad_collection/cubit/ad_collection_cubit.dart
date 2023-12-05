import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/enum/enums.dart';
import 'package:onlinebozor/domain/model/ad.dart';
import 'package:onlinebozor/domain/repository/favorite_repository.dart';

import '../../../../common/core/base_cubit.dart';
import '../../../../domain/repository/ad_repository.dart';
import '../../../../domain/repository/common_repository.dart';

part 'ad_collection_cubit.freezed.dart';
part 'ad_collection_state.dart';

@injectable
class AdCollectionCubit extends BaseCubit<AdCollectionBuildable, AdCollectionListenable> {
  AdCollectionCubit(
      this.adRepository, this.commonRepository, this.favoriteRepository)
      : super(AdCollectionBuildable()) {
    getHome();
  }

  void setCollectionType(CollectiveType collectiveType) {
    build((buildable) => buildable.copyWith(collectiveType: collectiveType));
  }

  Future<void> getHome() async {
    await Future.wait([
      getHotDiscountAds(),
      getPopularAds(),
      getController(),
    ]);
  }

  static const _pageSize = 20;

  final AdRepository adRepository;
  final CommonRepository commonRepository;
  final FavoriteRepository favoriteRepository;

  Future<void> getHotDiscountAds() async {
    try {
      log.i("recentlyViewerAds request");
      final hotDiscountAds =
          await adRepository.getPopularAds(buildable.collectiveType);
      build((buildable) => buildable.copyWith(
          hotDiscountAds: hotDiscountAds,
          hotDiscountAdsState: AppLoadingState.success));
      log.i("recentlyViewerAds=${buildable.hotDiscountAds}");
    }on DioException  catch (e, stackTrace) {
      build((buildable) =>
          buildable.copyWith(hotDiscountAdsState: AppLoadingState.error));
      log.e(e.toString(), error: e, stackTrace: stackTrace);
      display.error(e.toString());
    }
  }

  Future<void> getPopularAds() async {
    try {
      log.i("recentlyViewerAds request");
      final popularAds =
      await adRepository.getPopularAds(buildable.collectiveType);
      build((buildable) => buildable.copyWith(
          popularAds: popularAds, popularAdsState: AppLoadingState.success));
      log.i("recentlyViewerAds=${buildable.hotDiscountAds}");
    }on DioException catch (e, stackTrace) {
      build((buildable) =>
          buildable.copyWith(popularAdsState: AppLoadingState.error));
      log.e(e.toString(), error: e, stackTrace: stackTrace);
      display.error(e.toString());
    }
  }

  Future<void> getController() async {
    try {
      final controller =
          buildable.adsPagingController ?? getAdsController(status: 1);
      build((buildable) => buildable.copyWith(adsPagingController: controller));
    }on DioException  catch (e, stackTrace) {
      log.e(e.toString(), error: e, stackTrace: stackTrace);
      display.error(e.toString());
    } finally {
      log.i(buildable.adsPagingController);
      // build((buildable) => buildable.copyWith(loading: false));
    }
  }

  PagingController<int, Ad> getAdsController({
    required int status,
  }) {
    final adController = PagingController<int, Ad>(
      firstPageKey: 1,
    );
    log.i(buildable.adsPagingController);

    adController.addPageRequestListener(
          (pageKey) async {
        final adsList = await adRepository.getCollectiveAds(pageKey, _pageSize, "", buildable.collectiveType);
        if (adsList.length <= 19) {
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

  Future<void> popularAdsAddFavorite(Ad adModel) async {
    try {
      if (!adModel.favorite) {
        await favoriteRepository.addFavorite(adModel);
        final index = buildable.popularAds.indexOf(adModel);
        final item = buildable.popularAds.elementAt(index);
        buildable.popularAds.insert(index, item..favorite = true);
      } else {
        await favoriteRepository.removeFavorite(adModel);
        final index = buildable.popularAds.indexOf(adModel);
        final item = buildable.popularAds.elementAt(index);
        buildable.popularAds.insert(index, item..favorite = false);
      }
    } on DioException catch (e) {
      display.error("xatolik yuz  berdi");
    }
  }

  Future<void> discountAdsAddFavorite(Ad adModel) async {
    try {
      if (!adModel.favorite) {
        await favoriteRepository.addFavorite(adModel);
        final index = buildable.hotDiscountAds.indexOf(adModel);
        final item = buildable.hotDiscountAds.elementAt(index);
        buildable.hotDiscountAds.insert(index, item..favorite = true);
      } else {
        await favoriteRepository.removeFavorite(adModel);
        final index = buildable.hotDiscountAds.indexOf(adModel);
        final item = buildable.hotDiscountAds.elementAt(index);
        buildable.hotDiscountAds.insert(index, item..favorite = false);
      }
    } on DioException catch (e) {
      display.error("xatolik yuz  berdi");
    }
  }

  Future<void> addFavorite(Ad adModel) async {
    try {
      if (!adModel.favorite) {
        await favoriteRepository.addFavorite(adModel);
        final index =
            buildable.adsPagingController?.itemList?.indexOf(adModel) ?? 0;
        final item = buildable.adsPagingController?.itemList?.elementAt(index);
        if (item != null) {
          buildable.adsPagingController?.itemList
              ?.insert(index, item..favorite = true);
          buildable.adsPagingController?.itemList?.removeAt(index);
          buildable.adsPagingController?.notifyListeners();
        }
      } else {
        await favoriteRepository.removeFavorite(adModel);
        final index =
            buildable.adsPagingController?.itemList?.indexOf(adModel) ?? 0;
        final item = buildable.adsPagingController?.itemList?.elementAt(index);
        if (item != null) {
          buildable.adsPagingController?.itemList
              ?.insert(index, item..favorite = false);
          buildable.adsPagingController?.itemList?.removeAt(index);
          buildable.adsPagingController?.notifyListeners();
        }
      }
    } on DioException catch (e) {
      display.error("xatolik yuz  berdi");
    }
  }
}
