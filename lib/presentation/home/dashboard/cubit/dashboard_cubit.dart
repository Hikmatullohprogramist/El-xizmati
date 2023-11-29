import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/enum/enums.dart';
import 'package:onlinebozor/data/model/category/popular_category/popular_category_response.dart';
import 'package:onlinebozor/domain/model/ad.dart';
import 'package:onlinebozor/domain/repository/favorite_repository.dart';

import '../../../../common/core/base_cubit.dart';
import '../../../../data/model/banner/banner_response.dart';
import '../../../../domain/repository/ad_repository.dart';
import '../../../../domain/repository/common_repository.dart';

part 'dashboard_cubit.freezed.dart';
part 'dashboard_state.dart';

@injectable
class DashboardCubit
    extends BaseCubit<DashboardBuildable, DashboardListenable> {
  DashboardCubit(
      this.adRepository, this.commonRepository, this.favoriteRepository)
      : super(DashboardBuildable()) {
    getHome();
  }

  Future<void> getHome() async {
    await Future.wait([
      getPopularCategories(),
      getRecentlyViewAds(),
      getBanners(),
      getController(),
    ]);
  }

  static const _pageSize = 20;

  final AdRepository adRepository;
  final CommonRepository commonRepository;
  final FavoriteRepository favoriteRepository;

  Future<void> getPopularCategories() async {
    try {
      log.i("recentlyViewerAds request");
      final popularCategories =
          await commonRepository.getPopularCategories(1, 20);
      build((buildable) => buildable.copyWith(
            popularCategories: popularCategories,
            popularCategoriesState: AppLoadingState.success,
          ));
      log.i("recentlyViewerAds=${buildable.recentlyViewerAds}");
    }on DioException  catch (e, stackTrace) {
      build((buildable) =>
          buildable.copyWith(popularCategoriesState: AppLoadingState.error));
      log.e(e.toString(), error: e, stackTrace: stackTrace);
      display.error(e.toString());
    }
  }

  Future<void> getRecentlyViewAds() async {
    try {
      log.i("recentlyViewerAds request");
      final recentlyAds = await adRepository.getRecentlyViewAds();
      build((buildable) => buildable.copyWith(
          recentlyViewerAds: recentlyAds,
          recentlyAdsState: AppLoadingState.success));
      log.i("recentlyViewerAds=${buildable.recentlyViewerAds}");
    }on DioException  catch (e, stackTrace) {
      build((buildable) =>
          buildable.copyWith(recentlyAdsState: AppLoadingState.error));
      log.e(e.toString(), error: e, stackTrace: stackTrace);
      display.error(e.toString());
    }
  }

  Future<void> getBanners() async {
    try {
      build((buildable) =>
          buildable.copyWith(bannersState: AppLoadingState.loading));
      final banners = await commonRepository.getBanner();
      build((buildable) => buildable.copyWith(
          banners: banners, bannersState: AppLoadingState.success));
      log.i("${buildable.banners}");
    }on DioException  catch (e, stackTrace) {
      build((buildable) =>
          buildable.copyWith(bannersState: AppLoadingState.error));
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
        firstPageKey: 1, invisibleItemsThreshold: 100);
    log.i(buildable.adsPagingController);

    adController.addPageRequestListener(
          (pageKey) async {
        final adsList = await adRepository.getHomeAds(pageKey, _pageSize, "");
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

  Future<void> recentlyAdsAddFavorite(Ad adModel) async {
    try {
      if (!adModel.favorite) {
        await favoriteRepository.addFavorite(adModel);
        final index = buildable.recentlyViewerAds.indexOf(adModel);
        final item = buildable.recentlyViewerAds.elementAt(index);
        buildable.recentlyViewerAds.insert(index, item..favorite = true);
      } else {
        await favoriteRepository.removeFavorite(adModel.id);
        final index = buildable.recentlyViewerAds.indexOf(adModel);
        final item = buildable.recentlyViewerAds.elementAt(index);
        buildable.recentlyViewerAds.insert(index, item..favorite = false);
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
        await favoriteRepository.removeFavorite(adModel.id);
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
