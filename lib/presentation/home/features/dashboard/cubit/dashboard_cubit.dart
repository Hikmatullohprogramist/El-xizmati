import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/enum/enums.dart';

import '../../../../../common/core/base_cubit.dart';
import '../../../../../data/repositories/ad_repository.dart';
import '../../../../../data/repositories/common_repository.dart';
import '../../../../../data/repositories/favorite_repository.dart';
import '../../../../../data/responses/banner/banner_response.dart';
import '../../../../../data/responses/category/popular_category/popular_category_response.dart';
import '../../../../../domain/models/ad/ad.dart';
import '../../../../../domain/models/ad/ad_type.dart';

part 'dashboard_cubit.freezed.dart';

part 'dashboard_state.dart';

@injectable
class DashboardCubit
    extends BaseCubit<DashboardBuildable, DashboardListenable> {
  DashboardCubit(
    this.adRepository,
    this.commonRepository,
    this.favoriteRepository,
  ) : super(DashboardBuildable()) {
    getInitialData();
  }

  Future<void> getInitialData() async {
    await Future.wait([
      getBanners(),
      getPopularCategories(),
      getPopularProductAds(),
      getPopularServiceAds(),
      getTopRatedAds(),
    ]);
  }

  final AdRepository adRepository;
  final CommonRepository commonRepository;
  final FavoriteRepository favoriteRepository;

  Future<void> getPopularCategories() async {
    try {
      final popularCategories =
          await commonRepository.getPopularCategories(1, 20);

      updateState((buildable) => buildable.copyWith(
            popularCategories: popularCategories,
            popularCategoriesState: LoadingState.success,
          ));
    } on DioException catch (e, stackTrace) {
      updateState((buildable) =>
          buildable.copyWith(popularCategoriesState: LoadingState.error));

      log.e(e.toString(), error: e, stackTrace: stackTrace);
      display.error(e.toString());
    }
  }

  Future<void> getPopularProductAds() async {
    try {
      final ads = await adRepository.getDashboardPopularAdsByType(
        adType: AdType.product,
      );

      updateState((buildable) => buildable.copyWith(
            popularProductAds: ads,
            popularProductAdsState: LoadingState.success,
          ));
    } on DioException catch (e, stackTrace) {
      updateState((buildable) =>
          buildable.copyWith(popularProductAdsState: LoadingState.error));
      log.e(e.toString(), error: e, stackTrace: stackTrace);
      display.error(e.toString());
    }
  }

  Future<void> getPopularServiceAds() async {
    try {
      final ads = await adRepository.getDashboardPopularAdsByType(
        adType: AdType.service,
      );

      updateState(
        (buildable) => buildable.copyWith(
          popularServiceAds: ads,
          popularServiceAdsState: LoadingState.success,
        ),
      );
    } on DioException catch (e, stackTrace) {
      updateState((buildable) =>
          buildable.copyWith(popularServiceAdsState: LoadingState.error));
      log.e(e.toString(), error: e, stackTrace: stackTrace);
      display.error(e.toString());
    }
  }

  Future<void> getTopRatedAds() async {
    try {
      final ads = await adRepository.getDashboardTopRatedAds();

      updateState(
        (buildable) => buildable.copyWith(
          topRatedAds: ads,
          topRatedAdsState: LoadingState.success,
        ),
      );
    } on DioException catch (e, stackTrace) {
      updateState((buildable) =>
          buildable.copyWith(topRatedAdsState: LoadingState.error));
      log.e(e.toString(), error: e, stackTrace: stackTrace);
      display.error(e.toString());
    }
  }

  Future<void> getRecentlyViewedAds() async {
    try {
      final ads = await adRepository.getRecentlyViewedAds(page: 1, limit: 20);

      updateState((buildable) => buildable.copyWith(
            recentlyViewedAds: ads,
            recentlyViewedAdsState: LoadingState.success,
          ));
    } on DioException catch (e, stackTrace) {
      updateState((buildable) =>
          buildable.copyWith(recentlyViewedAdsState: LoadingState.error));
      log.e(e.toString(), error: e, stackTrace: stackTrace);
      display.error(e.toString());
    }
  }

  Future<void> getBanners() async {
    try {
      final banners = await commonRepository.getBanner();

      updateState((buildable) => buildable.copyWith(
          banners: banners, bannersState: LoadingState.success));

      log.i("getBanners success = ${currentState.banners}");
    } on DioException catch (e, stackTrace) {
      updateState(
        (buildable) => buildable.copyWith(bannersState: LoadingState.error),
      );
      log.e("getBanners error = ${e.toString()}",
          error: e, stackTrace: stackTrace);
      display.error(e.toString());
    }
  }

  Future<void> popularProductAdsAddFavorite(Ad ad) async {
    try {
      if (!ad.favorite) {
        final backendId = await favoriteRepository.addFavorite(ad);
        final index = currentState.popularProductAds.indexOf(ad);
        final item = currentState.popularProductAds.elementAt(index);
        currentState.popularProductAds.insert(
          index,
          item
            ..favorite = true
            ..backendId = backendId,
        );
      } else {
        await favoriteRepository.removeFavorite(ad);
        final index = currentState.popularProductAds.indexOf(ad);
        final item = currentState.popularProductAds.elementAt(index);
        currentState.popularProductAds.insert(index, item..favorite = false);
      }
    } on DioException catch (error) {
      display.error("serverda xatolik yuz  berdi");
      log.e(error.toString());
    }
  }

  Future<void> popularServiceAdsAddFavorite(Ad ad) async {
    try {
      if (!ad.favorite) {
        final backendId = await favoriteRepository.addFavorite(ad);
        final index = currentState.popularServiceAds.indexOf(ad);
        final item = currentState.popularServiceAds.elementAt(index);
        currentState.popularServiceAds.insert(
          index,
          item
            ..favorite = true
            ..backendId = backendId,
        );
      } else {
        await favoriteRepository.removeFavorite(ad);
        final index = currentState.popularServiceAds.indexOf(ad);
        final item = currentState.popularServiceAds.elementAt(index);
        currentState.popularServiceAds.insert(index, item..favorite = false);
      }
    } on DioException catch (error) {
      display.error("serverda xatolik yuz  berdi");
      log.e(error.toString());
    }
  }

  Future<void> topRatedAdsAddFavorite(Ad ad) async {
    try {
      if (!ad.favorite) {
        final backendId = await favoriteRepository.addFavorite(ad);
        final index = currentState.topRatedAds.indexOf(ad);
        final item = currentState.topRatedAds.elementAt(index);
        currentState.topRatedAds.insert(
          index,
          item
            ..favorite = true
            ..backendId = backendId,
        );
      } else {
        await favoriteRepository.removeFavorite(ad);
        final index = currentState.topRatedAds.indexOf(ad);
        final item = currentState.topRatedAds.elementAt(index);
        currentState.topRatedAds.insert(index, item..favorite = false);
      }
    } on DioException catch (error) {
      display.error("serverda xatolik yuz  berdi");
      log.e(error.toString());
    }
  }

  Future<void> recentlyViewAdAddToFavorite(Ad ad) async {
    try {
      if (!ad.favorite) {
        final backendId = await favoriteRepository.addFavorite(ad);
        final index = currentState.recentlyViewedAds.indexOf(ad);
        final item = currentState.recentlyViewedAds.elementAt(index);
        currentState.recentlyViewedAds.insert(
          index,
          item
            ..favorite = true
            ..backendId = backendId,
        );
      } else {
        await favoriteRepository.removeFavorite(ad);
        final index = currentState.recentlyViewedAds.indexOf(ad);
        final item = currentState.recentlyViewedAds.elementAt(index);
        currentState.recentlyViewedAds.insert(index, item..favorite = false);
      }
    } on DioException catch (error) {
      display.error("serverda xatolik yuz  berdi");
      log.e(error.toString());
    }
  }
}
