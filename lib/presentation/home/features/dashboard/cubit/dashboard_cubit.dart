import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/enum/enums.dart';

import '../../../../../common/core/base_cubit.dart';
import '../../../../../data/responses/banner/banner_response.dart';
import '../../../../../data/responses/category/popular_category/popular_category_response.dart';
import '../../../../../domain/models/ad.dart';
import '../../../../../domain/repositories/ad_repository.dart';
import '../../../../../domain/repositories/common_repository.dart';
import '../../../../../domain/repositories/favorite_repository.dart';

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
      getPopularAds(),
      getController(),
    ]);
  }

  static const _pageSize = 20;

  final AdRepository adRepository;
  final CommonRepository commonRepository;
  final FavoriteRepository favoriteRepository;

  Future<void> getPopularCategories() async {
    try {
      final popularCategories =
          await commonRepository.getPopularCategories(1, 20);
      build((buildable) => buildable.copyWith(
            popularCategories: popularCategories,
            popularCategoriesState: AppLoadingState.success,
          ));
    }on DioException  catch (e, stackTrace) {
      build((buildable) =>
          buildable.copyWith(popularCategoriesState: AppLoadingState.error));
      log.e(e.toString(), error: e, stackTrace: stackTrace);
      display.error(e.toString());
    }
  }

  Future<void> getPopularAds() async {
    try {
      final recentlyAds = await adRepository.getHomePopularAds(1, 10);
      build((buildable) => buildable.copyWith(
          popularAds: recentlyAds, popularAdsState: AppLoadingState.success));
    } on DioException catch (e, stackTrace) {
      build((buildable) =>
          buildable.copyWith(popularAdsState: AppLoadingState.error));
      log.e(e.toString(), error: e, stackTrace: stackTrace);
      display.error(e.toString());
    }
  }

  /**
   * bannerlarni  ko'rsatish vaqtinchalik to'xtatildi
   * */

  Future<void> getBanners() async {
    try {
      build((buildable) =>
          buildable.copyWith(bannersState: AppLoadingState.loading));
      final banners = await commonRepository.getBanner();
      build((buildable) => buildable.copyWith(
          banners: banners, bannersState: AppLoadingState.success));
      log.i("${buildable.banners}");
    } on DioException catch (e, stackTrace) {
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

  Future<void> popularAdsAddFavorite(Ad ad) async {
    try {
      if (!ad.favorite) {
        final backendId = await favoriteRepository.addFavorite(ad);
        final index = buildable.popularAds.indexOf(ad);
        final item = buildable.popularAds.elementAt(index);
        buildable.popularAds.insert(
            index,
            item
              ..favorite = true
              ..backendId = backendId);
      } else {
        await favoriteRepository.removeFavorite(ad);
        final index = buildable.popularAds.indexOf(ad);
        final item = buildable.popularAds.elementAt(index);
        buildable.popularAds.insert(index, item..favorite = false);
      }
    } on DioException catch (error) {
      display.error("serverda xatolik yuz  berdi");
      log.e(error.toString());
    }
  }

  Future<void> addFavorite(Ad ad) async {
    try {
      if (!ad.favorite) {
        final backendId = await favoriteRepository.addFavorite(ad);
        final index = buildable.adsPagingController?.itemList?.indexOf(ad) ?? 0;
        final item = buildable.adsPagingController?.itemList?.elementAt(index);
        if (item != null) {
          buildable.adsPagingController?.itemList?.insert(
              index,
              item
                ..favorite = true
                ..backendId = backendId);
          buildable.adsPagingController?.itemList?.removeAt(index);
          buildable.adsPagingController?.notifyListeners();
        }
      } else {
        await favoriteRepository.removeFavorite(ad);
        final index = buildable.adsPagingController?.itemList?.indexOf(ad) ?? 0;
        final item = buildable.adsPagingController?.itemList?.elementAt(index);
        if (item != null) {
          buildable.adsPagingController?.itemList
              ?.insert(index, item..favorite = false);
          buildable.adsPagingController?.itemList?.removeAt(index);
          buildable.adsPagingController?.notifyListeners();
        }
      }
    } on DioException catch (error) {
      display.error("serverda xatolik yuz  berdi");
      log.e(error.toString());
    }
  }
}
