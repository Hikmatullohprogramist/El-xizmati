import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/core/enum/enums.dart';
import 'package:onlinebozor/core/extensions/list_extensions.dart';
import 'package:onlinebozor/core/handler/future_handler_exts.dart';
import 'package:onlinebozor/data/repositories/ad_repository.dart';
import 'package:onlinebozor/data/repositories/cart_repository.dart';
import 'package:onlinebozor/data/repositories/favorite_repository.dart';
import 'package:onlinebozor/domain/mappers/ad_mapper.dart';
import 'package:onlinebozor/domain/models/ad/ad.dart';
import 'package:onlinebozor/domain/models/ad/ad_detail.dart';
import 'package:onlinebozor/domain/models/stats/stats_type.dart';
import 'package:onlinebozor/presentation/support/cubit/base_cubit.dart';
import 'package:onlinebozor/presentation/support/extensions/extension_message_exts.dart';

part 'ad_detail_cubit.freezed.dart';
part 'ad_detail_state.dart';

@injectable
class AdDetailCubit extends BaseCubit<AdDetailState, AdDetailEvent> {
  final AdRepository _adRepository;
  final CartRepository _cartRepository;
  final FavoriteRepository _favoriteRepository;

  AdDetailCubit(
    this._adRepository,
    this._cartRepository,
    this._favoriteRepository,
  ) : super(AdDetailState());

  StreamSubscription? _ownerAdsSubs;
  StreamSubscription? _similarAdsSubs;

  @override
  Future<void> close() async {
    await _ownerAdsSubs?.cancel();
    await _similarAdsSubs?.cancel();

    super.close();
  }

  void setInitialParams(int adId) {
    updateState((state) => state.copyWith(
          adId: adId,
          isNotPrepared: true,
          isPreparingInProcess: true,
        ));
    getDetailResponse();
  }

  bool hasAdDetailDescription() {
    return states.adDetail?.hasDescription() ?? false;
  }

  bool hasSimilarAds() {
    return states.similarAdsState == LoadingState.loading ||
        states.similarAds.isNotEmpty;
  }

  bool hasOwnerOtherAds() {
    return states.ownerAdsState == LoadingState.loading ||
        states.ownerAds.isNotEmpty;
  }

  bool hasRecentlyViewedAds() {
    return states.recentlyViewedAdsState == LoadingState.loading ||
        states.recentlyViewedAds.isNotEmpty;
  }

  Future<void> getDetailResponse() async {
    if (states.adDetail != null) {
      updateState((state) => state.copyWith(
            isNotPrepared: false,
            isPreparingInProcess: false,
          ));
      return;
    }

    _adRepository
        .getAdDetail(states.adId!)
        .initFuture()
        .onStart(() {
          updateState((state) => state.copyWith(
                isNotPrepared: true,
                isPreparingInProcess: true,
              ));
        })
        .onSuccess((data) {
          updateState((state) => state.copyWith(
                adDetail: data,
                isPhoneVisible: false,
                isAddCart: data?.isInCart ?? false,
                isNotPrepared: false,
                isPreparingInProcess: false,
              ));
        })
        .onError((error) {
          logger.e(error);
          updateState((state) => state.copyWith(
                isNotPrepared: true,
                isPreparingInProcess: false,
              ));
        })
        .onFinished(() {})
        .executeFuture();

    await increaseAdStats(StatsType.view);
    await addAdToRecentlyViewed();

    getSimilarAds();
    getOwnerOtherAds();
  }

  Future<void> setPhoneNumberVisibility() async {
    updateState((state) => state.copyWith(isPhoneVisible: true));
    await increaseAdStats(StatsType.phone);
  }

  Future<void> changeAdFavorite() async {
    try {
      var ad = states.adDetail;
      if (ad?.isFavorite == true) {
        await _favoriteRepository.removeFromFavorite(states.adDetail!.adId);
        updateState(
            (state) => state.copyWith(adDetail: ad?..isFavorite = false));
      } else {
        final backendId =
            await _favoriteRepository.addToFavorite(states.adDetail!.toAd());

        ad?.isFavorite = true;
        ad?.backendId = backendId;

        updateState((state) => state.copyWith(adDetail: ad));
      }
    } catch (e) {
      logger.e(e);
    }
  }

  Future<void> addCart() async {
    try {
      await _cartRepository.addToCart(states.adDetail!.toAd());
      updateState((state) => state.copyWith(isAddCart: true));
    } catch (e) {
      logger.e(e.toString());
    }
  }

  Future<void> increaseAdStats(StatsType type) async {
    if (states.adId == null) return;

    _adRepository
        .increaseAdStats(type: type, adId: states.adId!)
        .initFuture()
        .onError((error) => logger.w(error))
        .executeFuture();
  }

  Future<void> addAdToRecentlyViewed() async {
    if (states.adId == null) return;

    _adRepository
        .addAdToRecentlyViewed(adId: states.adId!)
        .initFuture()
        .onError((error) => logger.w(error))
        .executeFuture();
  }

  Future<void> getSimilarAds() async {
    _adRepository
        .getSimilarAds(adId: states.adId ?? 0, page: 1, limit: 10)
        .initFuture()
        .onStart(() {
          updateState((s) => s.copyWith(similarAdsState: LoadingState.loading));
        })
        .onSuccess((data) {
          final ids = data.adIds();

          _similarAdsSubs?.cancel();
          _similarAdsSubs = _adRepository.watchAdsByIds(ids).listen((ads) {
            updateState((state) => state.copyWith(
                  similarAds: ads.map((e) => e.copy()).toList(),
                  similarAdsState:
                      ads.isEmpty ? LoadingState.empty : LoadingState.success,
                ));
          })
            ..onError((error) {
              updateState((state) => state.copyWith(
                    similarAdsState: LoadingState.error,
                  ));
            });
        })
        .onError((error) {
          updateState((s) => s.copyWith(similarAdsState: LoadingState.error));
        })
        .onFinished(() {})
        .executeFuture();
  }

  Future<void> similarAdsUpdateFavorite(Ad ad) async {
    _updateFavoriteData(ad, states.similarAds.map((e) => e).toList());
  }

  Future<void> similarAdsUpdateCart(Ad ad) async {
    _updateCartData(ad, states.similarAds.map((e) => e).toList());
  }

  Future<void> getOwnerOtherAds() async {
    if (states.adDetail?.sellerTin == null) {
      updateState((s) => s.copyWith(ownerAdsState: LoadingState.error));
      return;
    }

    _adRepository
        .getAdsByUser(
          sellerTin: states.adDetail!.sellerTin!,
          page: 1,
          limit: 20,
        )
        .initFuture()
        .onStart(() {})
        .onSuccess((data) {
          data.removeWhere((e) => e.id == state.state?.adId);

          final ids = data.adIds();

          _ownerAdsSubs?.cancel();
          _ownerAdsSubs = _adRepository.watchAdsByIds(ids).listen((ads) {
            updateState((state) => state.copyWith(
                  ownerAds: ads.map((e) => e.copy()).toList(),
                  ownerAdsState:
                      ads.isEmpty ? LoadingState.empty : LoadingState.success,
                ));
          })
            ..onError((error) {
              updateState((state) => state.copyWith(
                    ownerAdsState: LoadingState.error,
                  ));
            });

          updateState((state) => state.copyWith(
                ownerAds: data,
                ownerAdsState: LoadingState.success,
              ));
        })
        .onError((error) {
          logger.w(error);
          updateState((s) => s.copyWith(ownerAdsState: LoadingState.error));
          if (error.isRequiredShowError) {
            stateMessageManager.showErrorBottomSheet(error.localizedMessage);
          }
        })
        .onFinished(() {})
        .executeFuture();
  }

  Future<void> ownerAdUpdateFavorite(Ad ad) async {
    _updateFavoriteData(ad, states.ownerAds.map((e) => e).toList());
  }

  Future<void> ownerAdUpdateCart(Ad ad) async {
    _updateCartData(ad, states.ownerAds.map((e) => e).toList());
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
          updateState((state) => state.copyWith(
                recentlyViewedAds: data,
                recentlyViewedAdsState: LoadingState.success,
              ));
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

  Future<void> recentlyViewedAdUpdateFavorite(Ad ad) async {
    _updateFavoriteData(ad, states.recentlyViewedAds.map((e) => e).toList());
  }

  Future<void> recentlyViewedAdUpdateCart(Ad ad) async {
    _updateCartData(ad, states.recentlyViewedAds.map((e) => e).toList());
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

  void setVisibleImageIndex(int index) {
    updateState((state) => state.copyWith(visibleImageIndex: index));
  }
}
