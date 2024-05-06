import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/enum/enums.dart';
import 'package:onlinebozor/data/repositories/cart_repository.dart';
import 'package:onlinebozor/domain/mappers/ad_mapper.dart';

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
    this._adRepository,
    this._cartRepository,
    this._commonRepository,
    this._favoriteRepository,
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
      getRecentlyViewedAds(),
    ]);
  }

  final AdRepository _adRepository;
  final CartRepository _cartRepository;
  final CommonRepository _commonRepository;
  final FavoriteRepository _favoriteRepository;

  Future<void> getPopularCategories() async {
    try {
      final popularCategories =
          await _commonRepository.getPopularCategories(1, 20);

      updateState(
        (state) => state.copyWith(
          popularCategories: popularCategories,
          popularCategoriesState: LoadingState.success,
        ),
      );
    } catch (e, stackTrace) {
      updateState(
        (state) => state.copyWith(popularCategoriesState: LoadingState.error),
      );

      log.e(e.toString(), error: e, stackTrace: stackTrace);
      display.error(e.toString());
    }
  }

  Future<void> getPopularProductAds() async {
    try {
      final ads = await _adRepository.getDashboardPopularAdsByType(
        adType: AdType.PRODUCT,
      );

      updateState(
        (state) => state.copyWith(
          popularProductAds: ads,
          popularProductAdsState: LoadingState.success,
        ),
      );
    } catch (e, stackTrace) {
      updateState(
        (state) => state.copyWith(popularProductAdsState: LoadingState.error),
      );
      log.e(e.toString(), error: e, stackTrace: stackTrace);
      display.error(e.toString());
    }
  }

  Future<void> getPopularServiceAds() async {
    try {
      final ads = await _adRepository.getDashboardPopularAdsByType(
        adType: AdType.SERVICE,
      );
      updateState(
        (state) => state.copyWith(
          popularServiceAds: ads,
          popularServiceAdsState: LoadingState.success,
        ),
      );
    } catch (e, stackTrace) {
      updateState((state) =>
          state.copyWith(popularServiceAdsState: LoadingState.error));
      log.e(e.toString(), error: e, stackTrace: stackTrace);
      display.error(e.toString());
    }
  }

  Future<void> getTopRatedAds() async {
    try {
      final ads = await _adRepository.getDashboardTopRatedAds();
      updateState(
        (state) => state.copyWith(
          topRatedAds: ads,
          topRatedAdsState: LoadingState.success,
        ),
      );
    } catch (e, stackTrace) {
      updateState(
        (state) => state.copyWith(topRatedAdsState: LoadingState.error),
      );
      log.e(e.toString(), error: e, stackTrace: stackTrace);
      display.error(e.toString());
    }
  }

  Future<void> getRecentlyViewedAds() async {
    try {
      final ads = await _adRepository.getRecentlyViewedAds(page: 1, limit: 20);
      updateState(
        (state) => state.copyWith(
          recentlyViewedAds: ads,
          recentlyViewedAdsState: LoadingState.success,
        ),
      );
    } catch (e, stackTrace) {
      updateState((state) => state.copyWith(
            recentlyViewedAdsState: LoadingState.error,
          ));
      log.e(e.toString(), error: e, stackTrace: stackTrace);
    }
  }

  Future<void> getBanners() async {
    try {
      final banners = await _commonRepository.getBanner();
      updateState((state) => state.copyWith(
            banners: banners,
            bannersState: LoadingState.success,
          ));
      log.i("getBanners success = ${states.banners}");
    } catch (e, stackTrace) {
      updateState((state) => state.copyWith(
            bannersState: LoadingState.error,
          ));
      log.e("getBanners e = ${e.toString()}", error: e, stackTrace: stackTrace);
    }
  }

  Future<void> popularProductAdsAddCart(Ad ad) async {
    try {
      await _cartRepository.addCart(ad);
      // updateState((state) => state.copyWith(isAddCart: true));
    } catch (e) {
      log.e(e.toString());
    }
  }

  Future<void> popularProductAdsAddFavorite(Ad ad) async {
    try {
      if (ad.isFavorite == true) {
        await _favoriteRepository.removeFromFavorite(ad.id);
        final index = states.popularProductAds.indexOf(ad);
        final item = states.popularProductAds.elementAt(index);
        states.popularProductAds.insert(index, item..isFavorite = false);
      } else {
        final backendId = await _favoriteRepository.addToFavorite(ad);
        final index = states.popularProductAds.indexOf(ad);
        final item = states.popularProductAds.elementAt(index);
        states.popularProductAds.insert(
          index,
          item
            ..isFavorite = true
            ..backendId = backendId,
        );
      }
    } catch (error) {
      display.error("serverda xatolik yuz  berdi");
      log.e(error.toString());
    }
  }

  Future<void> popularServiceAdsAddFavorite(Ad ad) async {
    try {
      if (ad.isFavorite == true) {
        await _favoriteRepository.removeFromFavorite(ad.id);
        final index = states.popularServiceAds.indexOf(ad);
        final item = states.popularServiceAds.elementAt(index);
        states.popularServiceAds.insert(index, item..isFavorite = false);
      } else {
        final backendId = await _favoriteRepository.addToFavorite(ad);
        final index = states.popularServiceAds.indexOf(ad);
        final item = states.popularServiceAds.elementAt(index);
        states.popularServiceAds.insert(
          index,
          item
            ..isFavorite = true
            ..backendId = backendId,
        );
      }
    } catch (error) {
      display.error("serverda xatolik yuz  berdi");
      log.e(error.toString());
    }
  }

  Future<void> topRatedAdsAddFavorite(Ad ad) async {
    try {
      if (ad.isFavorite == true) {
        await _favoriteRepository.removeFromFavorite(ad.id);
        final index = states.topRatedAds.indexOf(ad);
        final item = states.topRatedAds.elementAt(index);
        states.topRatedAds.insert(index, item..isFavorite = false);
      } else {
        final backendId = await _favoriteRepository.addToFavorite(ad);
        final index = states.topRatedAds.indexOf(ad);
        final item = states.topRatedAds.elementAt(index);
        states.topRatedAds.insert(
          index,
          item
            ..isFavorite = true
            ..backendId = backendId,
        );
      }
    } catch (error) {
      display.error("serverda xatolik yuz  berdi");
      log.e(error.toString());
    }
  }

  Future<void> recentlyViewAdAddToFavorite(Ad ad) async {
    try {
      if (ad.isFavorite == true) {
        await _favoriteRepository.removeFromFavorite(ad.id);
        final index = states.recentlyViewedAds.indexOf(ad);
        final item = states.recentlyViewedAds.elementAt(index);
        states.recentlyViewedAds.insert(index, item..isFavorite = false);
      } else {
        final backendId = await _favoriteRepository.addToFavorite(ad);
        final index = states.recentlyViewedAds.indexOf(ad);
        final item = states.recentlyViewedAds.elementAt(index);
        states.recentlyViewedAds.insert(
          index,
          item
            ..isFavorite = true
            ..backendId = backendId,
        );
      }
    } catch (error) {
      display.error("serverda xatolik yuz  berdi");
      log.e(error.toString());
    }
  }
}
