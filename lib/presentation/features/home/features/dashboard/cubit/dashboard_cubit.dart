import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/core/enum/enums.dart';
import 'package:onlinebozor/data/datasource/network/responses/banner/banner_response.dart';
import 'package:onlinebozor/data/datasource/network/responses/category/popular_category/popular_category_response.dart';
import 'package:onlinebozor/data/repositories/ad_repository.dart';
import 'package:onlinebozor/data/repositories/cart_repository.dart';
import 'package:onlinebozor/data/repositories/common_repository.dart';
import 'package:onlinebozor/data/repositories/favorite_repository.dart';
import 'package:onlinebozor/domain/models/ad/ad.dart';
import 'package:onlinebozor/domain/models/ad/ad_type.dart';
import 'package:onlinebozor/presentation/support/cubit/base_cubit.dart';

part 'dashboard_cubit.freezed.dart';
part 'dashboard_state.dart';

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

  final AdRepository _adRepository;
  final CartRepository _cartRepository;
  final CommonRepository _commonRepository;
  final FavoriteRepository _favoriteRepository;

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

      logger.e(e.toString(), error: e, stackTrace: stackTrace);
      stateMessageManager.showErrorSnackBar(e.toString());
    }
  }

  Future<void> getPopularProductAds() async {
    try {
      final ads = await _adRepository.getDashboardPopularAds(
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
      logger.e(e.toString(), error: e, stackTrace: stackTrace);
      stateMessageManager.showErrorSnackBar(e.toString());
    }
  }

  Future<void> getPopularServiceAds() async {
    try {
      final ads = await _adRepository.getDashboardPopularAds(
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
      logger.e(e.toString(), error: e, stackTrace: stackTrace);
      stateMessageManager.showErrorSnackBar(e.toString());
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
      logger.e(e.toString(), error: e, stackTrace: stackTrace);
      stateMessageManager.showErrorSnackBar(e.toString());
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
      logger.e(e.toString(), error: e, stackTrace: stackTrace);
    }
  }

  Future<void> getBanners() async {
    try {
      final banners = await _commonRepository.getBanner();
      updateState((state) => state.copyWith(
            banners: banners,
            bannersState: LoadingState.success,
          ));
      logger.i("getBanners success = ${states.banners}");
    } catch (e, stackTrace) {
      updateState((state) => state.copyWith(
            bannersState: LoadingState.error,
          ));
      logger.e("getBanners e = ${e.toString()}",
          error: e, stackTrace: stackTrace);
    }
  }

  Future<void> popularProductAdsUpdateFavorite(Ad ad) async {
    _updateFavoriteData(ad, states.popularProductAds);
  }

  Future<void> popularProductAdsUpdateCart(Ad ad) async {
    _updateCartData(ad, states.popularProductAds);
  }

  Future<void> popularServiceAdsUpdateFavorite(Ad ad) async {
    _updateFavoriteData(ad, states.popularServiceAds);
  }

  Future<void> popularServiceAdsUpdateCart(Ad ad) async {
    _updateCartData(ad, states.popularServiceAds);
  }

  Future<void> topRatedAdsUpdateFavorite(Ad ad) async {
    _updateFavoriteData(ad, states.topRatedAds);
  }

  Future<void> recentlyViewAdUpdateFavorite(Ad ad) async {
    _updateFavoriteData(ad, states.recentlyViewedAds);
  }
  Future<void> recentlyViewAdUpdateCart(Ad ad) async {
    _updateCartData(ad, states.recentlyViewedAds);
  }

  Future<void> _updateCartData(Ad ad, List<Ad> adList) async {
    try {
      int index = adList.indexOf(ad);
      if (index == -1) return;

      if (ad.isAddedToCart) {
        await _cartRepository.removeFromCart(ad.id);
        adList[index] = ad..isAddedToCart = false;
      } else {
        await _cartRepository.addToCart(ad);
        adList[index] = ad..isAddedToCart = true;
      }

      updateState((state) => state);
    } catch (error) {
      logger.e(error.toString());
    }
  }


  Future<void> _updateFavoriteData(Ad ad, List<Ad> adList) async {
    try {
      int index = adList.indexOf(ad);
      if (index == -1) return;

      if (ad.isFavorite) {
        await _favoriteRepository.removeFromFavorite(ad.id);
        adList[index] = ad..isFavorite = false;
      } else {
        final backendId = await _favoriteRepository.addToFavorite(ad);
        adList[index] = ad
          ..isFavorite = true
          ..backendId = backendId;
      }
      updateState((state) => state);
    } catch (error) {
      logger.e(error.toString());
    }
  }
}
