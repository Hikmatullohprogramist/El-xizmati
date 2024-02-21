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

      build((buildable) => buildable.copyWith(
            popularCategories: popularCategories,
            popularCategoriesState: LoadingState.success,
          ));
    } on DioException catch (e, stackTrace) {
      build((buildable) =>
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

      build((buildable) => buildable.copyWith(
            popularProductAds: ads,
            popularProductAdsState: LoadingState.success,
          ));
    } on DioException catch (e, stackTrace) {
      build((buildable) =>
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

      build(
        (buildable) => buildable.copyWith(
          popularServiceAds: ads,
          popularServiceAdsState: LoadingState.success,
        ),
      );
    } on DioException catch (e, stackTrace) {
      build((buildable) =>
          buildable.copyWith(popularServiceAdsState: LoadingState.error));
      log.e(e.toString(), error: e, stackTrace: stackTrace);
      display.error(e.toString());
    }
  }

  Future<void> getTopRatedAds() async {
    try {
      final ads = await adRepository.getDashboardTopRatedAds();

      build(
        (buildable) => buildable.copyWith(
          topRatedAds: ads,
          topRatedAdsState: LoadingState.success,
        ),
      );
    } on DioException catch (e, stackTrace) {
      build((buildable) =>
          buildable.copyWith(topRatedAdsState: LoadingState.error));
      log.e(e.toString(), error: e, stackTrace: stackTrace);
      display.error(e.toString());
    }
  }

  Future<void> getRecentlyViewedAds() async {
    try {
      final ads = await adRepository.getRecentlyViewedAds(page: 1, limit: 20);

      build((buildable) => buildable.copyWith(
            recentlyViewedAds: ads,
            recentlyViewedAdsState: LoadingState.success,
          ));
    } on DioException catch (e, stackTrace) {
      build((buildable) =>
          buildable.copyWith(recentlyViewedAdsState: LoadingState.error));
      log.e(e.toString(), error: e, stackTrace: stackTrace);
      display.error(e.toString());
    }
  }

  Future<void> getBanners() async {
    try {
      final banners = await commonRepository.getBanner();

      build((buildable) => buildable.copyWith(
          banners: banners, bannersState: LoadingState.success));

      log.i("getBanners success = ${buildable.banners}");
    } on DioException catch (e, stackTrace) {
      build(
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
        final index = buildable.popularProductAds.indexOf(ad);
        final item = buildable.popularProductAds.elementAt(index);
        buildable.popularProductAds.insert(
          index,
          item
            ..favorite = true
            ..backendId = backendId,
        );
      } else {
        await favoriteRepository.removeFavorite(ad);
        final index = buildable.popularProductAds.indexOf(ad);
        final item = buildable.popularProductAds.elementAt(index);
        buildable.popularProductAds.insert(index, item..favorite = false);
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
        final index = buildable.popularServiceAds.indexOf(ad);
        final item = buildable.popularServiceAds.elementAt(index);
        buildable.popularServiceAds.insert(
          index,
          item
            ..favorite = true
            ..backendId = backendId,
        );
      } else {
        await favoriteRepository.removeFavorite(ad);
        final index = buildable.popularServiceAds.indexOf(ad);
        final item = buildable.popularServiceAds.elementAt(index);
        buildable.popularServiceAds.insert(index, item..favorite = false);
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
        final index = buildable.topRatedAds.indexOf(ad);
        final item = buildable.topRatedAds.elementAt(index);
        buildable.topRatedAds.insert(
          index,
          item
            ..favorite = true
            ..backendId = backendId,
        );
      } else {
        await favoriteRepository.removeFavorite(ad);
        final index = buildable.topRatedAds.indexOf(ad);
        final item = buildable.topRatedAds.elementAt(index);
        buildable.topRatedAds.insert(index, item..favorite = false);
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
        final index = buildable.recentlyViewedAds.indexOf(ad);
        final item = buildable.recentlyViewedAds.elementAt(index);
        buildable.recentlyViewedAds.insert(
          index,
          item
            ..favorite = true
            ..backendId = backendId,
        );
      } else {
        await favoriteRepository.removeFavorite(ad);
        final index = buildable.recentlyViewedAds.indexOf(ad);
        final item = buildable.recentlyViewedAds.elementAt(index);
        buildable.recentlyViewedAds.insert(index, item..favorite = false);
      }
    } on DioException catch (error) {
      display.error("serverda xatolik yuz  berdi");
      log.e(error.toString());
    }
  }
}
