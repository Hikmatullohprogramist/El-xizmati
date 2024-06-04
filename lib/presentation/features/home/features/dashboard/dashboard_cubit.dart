import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/core/enum/enums.dart';
import 'package:onlinebozor/core/extensions/list_extensions.dart';
import 'package:onlinebozor/core/handler/future_handler_exts.dart';
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
class DashboardCubit extends BaseCubit<DashboardState, DashboardEvent> {
  DashboardCubit(
    this._adRepository,
    this._cartRepository,
    this._commonRepository,
    this._favoriteRepository,
  ) : super(DashboardState()) {
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

  StreamSubscription? _productAdsSubs;
  StreamSubscription? _serviceAdsSubs;

  @override
  Future<void> close() async {
    await _productAdsSubs?.cancel();
    await _serviceAdsSubs?.cancel();
    super.close();
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
    if (states.popularProductAdsState == LoadingState.success ||
        states.popularProductAds.isNotEmpty) {
      return;
    }

    _adRepository
        .getDashboardPopularAds(adType: AdType.product)
        .initFuture()
        .onStart(() {})
        .onSuccess((data) {
          final ids = data.adIds();
          _productAdsSubs = _adRepository.watchAdsByIds(ids).asyncMap(
            (ads) {
              logger.w(
                  "watchPopularProductAds ads count = ${ads.length}, cart count = ${ads.cartCount()}, favorite count = ${ads.favoriteCount()}");
              updateState((state) => state.copyWith(
                    popularProductAds: ads.map((e) => e).toList(),
                    popularProductAdsState:
                        ads.isEmpty ? LoadingState.empty : LoadingState.success,
                  ));
            },
          ).listen(null)
            ..onError((error) {
              logger.w("watchPopularProductAds error = $error");
              updateState((state) => state.copyWith(
                    popularProductAdsState: LoadingState.error,
                  ));
            });
        })
        .onError((error) {
          logger.e("watchPopularProductAds error = $error");
          updateState((state) => state.copyWith(
                popularProductAdsState: LoadingState.error,
              ));
        })
        .onFinished(() {})
        .executeFuture();
  }

  Future<void> getPopularServiceAds() async {
    if (states.popularServiceAdsState == LoadingState.success ||
        states.popularServiceAds.isNotEmpty) {
      return;
    }

    _adRepository
        .getDashboardPopularAds(adType: AdType.product)
        .initFuture()
        .onStart(() {})
        .onSuccess((data) {
          final ids = data.adIds();
          _serviceAdsSubs = _adRepository.watchAdsByIds(ids).listen((ads) {
            logger.w(
                "watchPopularServiceAds ads count = ${ads.length}, cart count = ${ads.cartCount()}, favorite count = ${ads.favoriteCount()}");
            updateState((state) => state.copyWith(
                  popularServiceAds: ads,
                  popularServiceAdsState:
                      ads.isEmpty ? LoadingState.empty : LoadingState.success,
                ));
          })
            ..onError((error) {
              logger.w("watchPopularServiceAds error = $error");
              updateState((state) => state.copyWith(
                    popularServiceAdsState: LoadingState.error,
                  ));
            });
        })
        .onError((error) {
          logger.e("watchPopularServiceAds error = $error");
          updateState((state) => state.copyWith(
                popularServiceAdsState: LoadingState.error,
              ));
        })
        .onFinished(() {})
        .executeFuture();

    try {
      final ads = await _adRepository.getDashboardPopularAds(
        adType: AdType.service,
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
    _updateFavoriteData(ad, []);
  }

  Future<void> popularProductAdsUpdateCart(Ad ad) async {
    _updateCartData(ad, states.popularProductAds.toList());
  }

  Future<void> popularServiceAdsUpdateFavorite(Ad ad) async {
    _updateFavoriteData(ad, states.popularServiceAds.toList());
  }

  Future<void> popularServiceAdsUpdateCart(Ad ad) async {
    _updateCartData(ad, states.popularServiceAds.toList());
  }

  Future<void> topRatedAdsUpdateFavorite(Ad ad) async {
    _updateFavoriteData(ad, states.topRatedAds.toList());
  }

  Future<void> recentlyViewAdUpdateFavorite(Ad ad) async {
    _updateFavoriteData(ad, states.recentlyViewedAds.toList());
  }

  Future<void> recentlyViewAdUpdateCart(Ad ad) async {
    _updateCartData(ad, states.recentlyViewedAds.toList());
  }

  Future<void> _updateCartData(Ad ad, List<Ad> adList) async {
    try {
      int index = adList.indexOf(ad);
      if (index == -1) return;

      if (ad.isInCart) {
        await _cartRepository.removeFromCart(ad.id);
        adList[index] = ad..isInCart = false;
      } else {
        await _cartRepository.addToCart(ad);
        adList[index] = ad..isInCart = true;
      }

      updateState((state) => state);
    } catch (error) {
      logger.e(error.toString());
    }
  }

  Future<void> _updateFavoriteData(Ad ad, List<Ad> adList) async {
    try {
      // int index = adList.indexOf(ad);
      // if (index == -1) return;

      if (ad.isFavorite) {
        await _favoriteRepository.removeFromFavorite(ad.id);
        // adList[index] = ad..isFavorite = false;
      } else {
        final backendId = await _favoriteRepository.addToFavorite(ad);
        // adList[index] = ad
        //   ..isFavorite = true
        //   ..backendId = backendId;
      }
      // updateState((state) => state);
    } catch (error) {
      logger.e(error.toString());
    }
  }
}
