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

    _subscribeStreams();

    _getInitialData();
  }

  StreamSubscription? _installmentAdsSubs;
  StreamSubscription? _productAdsSubs;
  StreamSubscription? _recentlyAdsSubs;
  StreamSubscription? _selectedRegionSubs;
  StreamSubscription? _serviceAdsSubs;
  StreamSubscription? _topAdsSubs;

  @override
  Future<void> close() async {
    await _installmentAdsSubs?.cancel();
    await _productAdsSubs?.cancel();
    await _recentlyAdsSubs?.cancel();
    await _selectedRegionSubs?.cancel();
    await _serviceAdsSubs?.cancel();
    await _topAdsSubs?.cancel();

    super.close();
  }

  void _subscribeStreams() {
    _selectedRegionSubs?.cancel();
    _selectedRegionSubs = _selectedRegionStreamController.listen((event) {
      getSelectedRegion();
    });
  }

  Future<void> _getInitialData() async {
    await Future.wait([
      getBanners(),
      getPopularCategories(),
      getPopularProductAds(),
      getPopularServiceAds(),
      getTopRatedAds(),
      getInstallmentAds()
    ]);
  }

  reload() async {
    await Future.wait([
      getBanners(),
      getPopularCategories(),
      getPopularProductAds(),
      getPopularServiceAds(),
      getTopRatedAds(),
      getInstallmentAds(),
      getRecentlyViewedAds(),
    ]);
  }

  Future<void> getSelectedRegion() async {
    final regionName = _regionRepository.getSelectedRegionName();
    updateState((state) => state.copyWith(selectedRegionName: regionName));

    reload();
  }

  Future<void> getPopularCategories() async {
    _commonRepository
        .getPopularCategories(1, 20)
        .initFuture()
        .onStart(() {
          updateState((state) => state.copyWith(
                popularCategoriesState: LoadingState.loading,
              ));
        })
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
              logger.e("getPopularProductAds error = $error");
              updateState((state) => state.copyWith(
                    popularProductAdsState: LoadingState.error,
                  ));
            });
        })
        .onError((error) {
          logger.e("getPopularProductAds error = $error");
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
              logger.e("getPopularServiceAds error = $error");
              updateState((state) => state.copyWith(
                    popularServiceAdsState: LoadingState.error,
                  ));
            });
        })
        .onError((error) {
          logger.e("getPopularServiceAds error = $error");
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
              logger.e("getTopRatedAds error = $error");
              updateState((state) => state.copyWith(
                    topRatedAdsState: LoadingState.error,
                  ));
            });
        })
        .onError((error) {
          logger.e("getTopRatedAds error = $error");
          updateState((state) => state.copyWith(
                topRatedAdsState: LoadingState.error,
              ));
          logger.e(error);
        })
        .onFinished(() {})
        .executeFuture();
  }

  Future<void> getInstallmentAds() async {
    _adRepository
        .getAdsWithInstallment()
        .initFuture()
        .onStart(() {
          updateState((state) => state.copyWith(
                installmentAdsState: LoadingState.loading,
              ));
        })
        .onSuccess((data) {
          final ids = data.adIds();
          _installmentAdsSubs?.cancel();
          _installmentAdsSubs = _adRepository.watchAdsByIds(ids).listen(
            (ads) {
              updateState((state) => state.copyWith(
                    installmentAds: ads,
                    installmentAdsState:
                        ads.isEmpty ? LoadingState.empty : LoadingState.success,
                  ));
            },
          )..onError((error) {
              logger.e("getInstallmentAds error = $error");
              updateState((state) => state.copyWith(
                    installmentAdsState: LoadingState.error,
                  ));
            });
        })
        .onError((error) {
          logger.e("getInstallmentAds error = $error");
          updateState((state) => state.copyWith(
                popularProductAdsState: LoadingState.error,
              ));
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

  Future<void> updateCartData(Ad ad) async {
    if (ad.isInCart) {
      await _cartRepository.removeFromCart(ad.id);
    } else {
      await _cartRepository.addToCart(ad);
    }
  }

  Future<void> updateFavoriteData(Ad ad) async {
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
