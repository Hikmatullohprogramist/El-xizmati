import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/core/enum/enums.dart';
import 'package:onlinebozor/core/extensions/list_extensions.dart';
import 'package:onlinebozor/core/gen/localization/strings.dart';
import 'package:onlinebozor/core/handler/future_handler_exts.dart';
import 'package:onlinebozor/data/datasource/network/responses/category/popular_category/popular_category_response.dart';
import 'package:onlinebozor/data/repositories/ad_repository.dart';
import 'package:onlinebozor/data/repositories/cart_repository.dart';
import 'package:onlinebozor/data/repositories/common_repository.dart';
import 'package:onlinebozor/data/repositories/favorite_repository.dart';
import 'package:onlinebozor/data/repositories/region_repository.dart';
import 'package:onlinebozor/domain/models/ad/ad.dart';
import 'package:onlinebozor/domain/models/ad/ad_type.dart';
import 'package:onlinebozor/domain/models/banner/banner_image.dart';
import 'package:onlinebozor/presentation/stream_controllers/selected_region_stream_controller.dart';
import 'package:onlinebozor/presentation/support/cubit/base_cubit.dart';

part 'dashboard_cubit.freezed.dart';

part 'dashboard_state.dart';

@injectable
class DashboardCubit extends BaseCubit<DashboardState, DashboardEvent> {
  final AdRepository _adRepository;
  final CartRepository _cartRepository;
  final CommonRepository _commonRepository;
  final FavoriteRepository _favoriteRepository;
  final RegionRepository _regionRepository;
  final SelectedRegionStreamController _selectedRegionStreamController;

  DashboardCubit(
    this._adRepository,
    this._cartRepository,
    this._commonRepository,
    this._favoriteRepository,
    this._regionRepository,
    this._selectedRegionStreamController,
  ) : super(DashboardState()) {
    getSelectedRegion();
    _selectedRegionSubs = _selectedRegionStreamController.listen((event) {
      getSelectedRegion();
      if(event == 0){
        clearSelectedRegion();
      }
    });
    _getInitialData();
  }

  StreamSubscription? _productAdsSubs;
  StreamSubscription? _recentlyAdsSubs;
  StreamSubscription? _selectedRegionSubs;
  StreamSubscription? _serviceAdsSubs;
  StreamSubscription? _topAdsSubs;

  @override
  Future<void> close() async {
    await _productAdsSubs?.cancel();
    await _recentlyAdsSubs?.cancel();
    await _selectedRegionSubs?.cancel();
    await _serviceAdsSubs?.cancel();
    await _topAdsSubs?.cancel();

    super.close();
  }

  Future<void> _getInitialData() async {
    await Future.wait([
      getBanners(),
      getPopularCategories(),
      getPopularProductAds(),
      getPopularServiceAds(),
      getTopRatedAds(),
    ]);
  }

  reload() async {
    await Future.wait([
      getBanners(),
      getPopularCategories(),
      getPopularProductAds(),
      getPopularServiceAds(),
      getTopRatedAds(),
      getRecentlyViewedAds(),
    ]);
  }

  Future<void> getSelectedRegion() async {
    final regionName = _regionRepository.getSelectedRegionName();
    updateState((state) => state.copyWith(selectedRegionName: regionName));
  }

  Future<void> clearSelectedRegion() async {
    updateState((state) => state.copyWith(selectedRegionName: null));
  }

  Future<void> getPopularCategories() async {
    _commonRepository
        .getPopularCategories(1, 20)
        .initFuture()
        .onStart(() {})
        .onSuccess((data) {
          updateState((state) => state.copyWith(
                popularCategories: data,
                popularCategoriesState: LoadingState.success,
              ));
        })
        .onError((error) {
          updateState((state) => state.copyWith(
                popularCategoriesState: LoadingState.error,
              ));

          logger.e(error);
        })
        .onFinished(() {})
        .executeFuture();
  }

  Future<void> getPopularProductAds() async {
    _adRepository
        .getDashboardPopularAds(adType: AdType.product)
        .initFuture()
        .onStart(() {
          updateState((state) => state.copyWith(
                popularProductAdsState: LoadingState.loading,
              ));
        })
        .onSuccess((data) {
          final ids = data.adIds();
          _productAdsSubs?.cancel();
          _productAdsSubs = _adRepository.watchAdsByIds(ids).listen(
            (ads) {
              updateState((state) => state.copyWith(
                    popularProductAds: ads,
                    popularProductAdsState:
                        ads.isEmpty ? LoadingState.empty : LoadingState.success,
                  ));
            },
          )..onError((error) {
              updateState((state) => state.copyWith(
                    popularProductAdsState: LoadingState.error,
                  ));
            });
        })
        .onError((error) {
          updateState((state) => state.copyWith(
                popularProductAdsState: LoadingState.error,
              ));
        })
        .onFinished(() {})
        .executeFuture();
  }

  Future<void> getPopularServiceAds() async {
    _adRepository
        .getDashboardPopularAds(adType: AdType.service)
        .initFuture()
        .onStart(() {
          updateState((state) => state.copyWith(
                popularServiceAdsState: LoadingState.loading,
              ));
        })
        .onSuccess((data) {
          final ids = data.adIds();
          _serviceAdsSubs?.cancel();
          _serviceAdsSubs = _adRepository.watchAdsByIds(ids).listen((ads) {
            updateState((state) => state.copyWith(
                  popularServiceAds: ads,
                  popularServiceAdsState:
                      ads.isEmpty ? LoadingState.empty : LoadingState.success,
                ));
          })
            ..onError((error) {
              updateState((state) => state.copyWith(
                    popularServiceAdsState: LoadingState.error,
                  ));
            });
        })
        .onError((error) {
          updateState((state) => state.copyWith(
                popularServiceAdsState: LoadingState.error,
              ));
        })
        .onFinished(() {})
        .executeFuture();
  }

  Future<void> getTopRatedAds() async {
    _adRepository
        .getDashboardTopRatedAds()
        .initFuture()
        .onStart(() {
          updateState((state) => state.copyWith(
                topRatedAdsState: LoadingState.loading,
              ));
        })
        .onSuccess((data) {
          final ids = data.adIds();

          _topAdsSubs?.cancel();
          _topAdsSubs = _adRepository.watchAdsByIds(ids).listen((ads) {
            updateState((state) => state.copyWith(
                  topRatedAds: ads.map((e) => e.copy()).toList(),
                  topRatedAdsState:
                      ads.isEmpty ? LoadingState.empty : LoadingState.success,
                ));
          })
            ..onError((error) {
              updateState((state) => state.copyWith(
                    topRatedAdsState: LoadingState.error,
                  ));
            });
        })
        .onError((error) {
          updateState((state) => state.copyWith(
                topRatedAdsState: LoadingState.error,
              ));
          logger.e(error);
        })
        .onFinished(() {})
        .executeFuture();
  }

  Future<void> getRecentlyViewedAds() async {
    _adRepository
        .getRecentlyViewedAds(page: 1, limit: 20)
        .initFuture()
        .onStart(() {
          updateState((state) => state.copyWith(
                recentlyViewedAdsState: LoadingState.loading,
              ));
        })
        .onSuccess((data) {
          final ids = data.adIds();

          _recentlyAdsSubs?.cancel();
          _recentlyAdsSubs = _adRepository.watchAdsByIds(ids).listen((ads) {
            updateState((state) => state.copyWith(
                  recentlyViewedAds: ads.map((e) => e.copy()).toList(),
                  recentlyViewedAdsState:
                      ads.isEmpty ? LoadingState.empty : LoadingState.success,
                ));
          })
            ..onError((error) {
              updateState((state) => state.copyWith(
                    recentlyViewedAdsState: LoadingState.error,
                  ));
            });
        })
        .onError((error) {
          updateState((state) => state.copyWith(
                recentlyViewedAdsState: LoadingState.error,
              ));
          logger.e(error);
        })
        .onFinished(() {})
        .executeFuture();
  }

  Future<void> getBanners() async {
    _commonRepository
        .getBanners()
        .initFuture()
        .onStart(() {
          updateState((state) => state.copyWith(
                bannersState: LoadingState.loading,
              ));
        })
        .onSuccess((data) {
          updateState((state) => state.copyWith(
                banners: data.filterIf((e) => e.imageId.isNotEmpty).toList(),
                bannersState: LoadingState.success,
              ));
        })
        .onError((error) {
          updateState((state) => state.copyWith(
                bannersState: LoadingState.error,
              ));
          logger.e(error);
        })
        .onFinished(() {})
        .executeFuture();
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
      if (ad.isFavorite) {
        await _favoriteRepository.removeFromFavorite(ad.id);
      } else {
        await _favoriteRepository.addToFavorite(ad);
      }
    } catch (error) {
      logger.e(error.toString());
    }
  }
}
