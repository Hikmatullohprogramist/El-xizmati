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

part 'page_cubit.freezed.dart';

part 'page_state.dart';

@injectable
class PageCubit extends BaseCubit<PageState, PageEvent> {
  PageCubit(
    this.adRepository,
    this.commonRepository,
    this.favoriteRepository,
  ) : super(PageState()) {
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

      updateState(
        (state) => state.copyWith(
          popularCategories: popularCategories,
          popularCategoriesState: LoadingState.success,
        ),
      );
    } on DioException catch (e, stackTrace) {
      updateState(
        (state) => state.copyWith(popularCategoriesState: LoadingState.error),
      );

      log.e(e.toString(), error: e, stackTrace: stackTrace);
      display.error(e.toString());
    }
  }

  Future<void> getPopularProductAds() async {
    try {
      final ads = await adRepository.getDashboardPopularAdsByType(
        adType: AdType.product,
      );

      updateState(
        (state) => state.copyWith(
          popularProductAds: ads,
          popularProductAdsState: LoadingState.success,
        ),
      );
    } on DioException catch (e, stackTrace) {
      updateState(
        (state) => state.copyWith(popularProductAdsState: LoadingState.error),
      );
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
        (state) => state.copyWith(
          popularServiceAds: ads,
          popularServiceAdsState: LoadingState.success,
        ),
      );
    } on DioException catch (e, stackTrace) {
      updateState((state) =>
          state.copyWith(popularServiceAdsState: LoadingState.error));
      log.e(e.toString(), error: e, stackTrace: stackTrace);
      display.error(e.toString());
    }
  }

  Future<void> getTopRatedAds() async {
    try {
      final ads = await adRepository.getDashboardTopRatedAds();
      updateState(
        (state) => state.copyWith(
          topRatedAds: ads,
          topRatedAdsState: LoadingState.success,
        ),
      );
    } on DioException catch (e, stackTrace) {
      updateState(
        (state) => state.copyWith(topRatedAdsState: LoadingState.error),
      );
      log.e(e.toString(), error: e, stackTrace: stackTrace);
      display.error(e.toString());
    }
  }

  Future<void> getRecentlyViewedAds() async {
    try {
      final ads = await adRepository.getRecentlyViewedAds(page: 1, limit: 20);
      updateState(
        (state) => state.copyWith(
          recentlyViewedAds: ads,
          recentlyViewedAdsState: LoadingState.success,
        ),
      );
    } on DioException catch (e, stackTrace) {
      updateState(
        (state) => state.copyWith(recentlyViewedAdsState: LoadingState.error),
      );
      log.e(e.toString(), error: e, stackTrace: stackTrace);
    } finally {
      updateState(
        (state) => state.copyWith(recentlyViewedAdsState: LoadingState.error),
      );
    }
  }

  Future<void> getBanners() async {
    try {
      final banners = await commonRepository.getBanner();
      updateState(
        (state) => state.copyWith(
            banners: banners, bannersState: LoadingState.success),
      );
      log.i("getBanners success = ${states.banners}");
    } on DioException catch (e, stackTrace) {
      updateState(
        (state) => state.copyWith(bannersState: LoadingState.error),
      );
      log.e("getBanners e = ${e.toString()}", error: e, stackTrace: stackTrace);
    }
  }

  Future<void> popularProductAdsAddFavorite(Ad ad) async {
    try {
      if (!ad.favorite) {
        final backendId = await favoriteRepository.addFavorite(ad);
        final index = states.popularProductAds.indexOf(ad);
        final item = states.popularProductAds.elementAt(index);
        states.popularProductAds.insert(
          index,
          item
            ..favorite = true
            ..backendId = backendId,
        );
      } else {
        await favoriteRepository.removeFavorite(ad);
        final index = states.popularProductAds.indexOf(ad);
        final item = states.popularProductAds.elementAt(index);
        states.popularProductAds.insert(index, item..favorite = false);
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
        final index = states.popularServiceAds.indexOf(ad);
        final item = states.popularServiceAds.elementAt(index);
        states.popularServiceAds.insert(
          index,
          item
            ..favorite = true
            ..backendId = backendId,
        );
      } else {
        await favoriteRepository.removeFavorite(ad);
        final index = states.popularServiceAds.indexOf(ad);
        final item = states.popularServiceAds.elementAt(index);
        states.popularServiceAds.insert(index, item..favorite = false);
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
        final index = states.topRatedAds.indexOf(ad);
        final item = states.topRatedAds.elementAt(index);
        states.topRatedAds.insert(
          index,
          item
            ..favorite = true
            ..backendId = backendId,
        );
      } else {
        await favoriteRepository.removeFavorite(ad);
        final index = states.topRatedAds.indexOf(ad);
        final item = states.topRatedAds.elementAt(index);
        states.topRatedAds.insert(index, item..favorite = false);
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
        final index = states.recentlyViewedAds.indexOf(ad);
        final item = states.recentlyViewedAds.elementAt(index);
        states.recentlyViewedAds.insert(
          index,
          item
            ..favorite = true
            ..backendId = backendId,
        );
      } else {
        await favoriteRepository.removeFavorite(ad);
        final index = states.recentlyViewedAds.indexOf(ad);
        final item = states.recentlyViewedAds.elementAt(index);
        states.recentlyViewedAds.insert(index, item..favorite = false);
      }
    } on DioException catch (error) {
      display.error("serverda xatolik yuz  berdi");
      log.e(error.toString());
    }
  }
}
