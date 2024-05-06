import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/enum/enums.dart';
import 'package:onlinebozor/domain/mappers/ad_mapper.dart';

import '../../../../common/constants.dart';
import '../../../../common/core/base_cubit.dart';
import '../../../../data/repositories/ad_repository.dart';
import '../../../../data/repositories/cart_repository.dart';
import '../../../../data/repositories/favorite_repository.dart';
import '../../../../data/storages/token_storage.dart';
import '../../../../domain/models/ad/ad.dart';
import '../../../../domain/models/ad/ad_detail.dart';
import '../../../../domain/models/stats/stats_type.dart';

part 'page_cubit.freezed.dart';
part 'page_state.dart';

@injectable
class PageCubit extends BaseCubit<PageState, PageEvent> {
  PageCubit(
    this._adRepository,
    this._cartRepository,
    this._favoriteRepository,
    this._tokenStorage,
  ) : super(PageState());

  final AdRepository _adRepository;
  final CartRepository _cartRepository;
  final FavoriteRepository _favoriteRepository;
  final TokenStorage _tokenStorage;

  List<String> getImages() {
    return (states.adDetail?.photos ?? List.empty(growable: true))
        .map((e) => "${Constants.baseUrlForImage}${e.image}")
        .toList();
  }

  void setAdId(int adId) {
    updateState((state) => state.copyWith(adId: adId));
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
    try {
      var response = await _adRepository.getAdDetail(states.adId!);
      updateState(
        (state) => state.copyWith(
          adDetail: response,
          isPhoneVisible: false,
          isAddCart: response?.isAddedToCart ?? false,
        ),
      );
      await increaseAdStats(StatsType.view);
      await addAdToRecentlyViewed();
    } catch (e) {
      log.e(e.toString());
      display.error(e.toString());
    }
    getSimilarAds();
    getOwnerOtherAds();
  }

  Future<void> setPhotoView() async {
    updateState((state) => state.copyWith(isPhoneVisible: true));
    await increaseAdStats(StatsType.phone);
  }

  Future<void> changeAdFavorite() async {
    try {
      var ad = states.adDetail;
      if (ad?.isFavorite == true) {
        await _favoriteRepository.removeFromFavorite(states.adDetail!.adId);
        updateState((state) => state.copyWith(adDetail: ad?..isFavorite = false));
      } else {
        final backendId =
            await _favoriteRepository.addToFavorite(states.adDetail!.toMap());

        ad?.isFavorite = true;
        ad?.backendId = backendId;

        updateState((state) => state.copyWith(adDetail: ad));
      }
    } catch (e) {
      display.error(e.toString());
    }
  }

  Future<void> similarAdsAddFavorite(Ad ad) async {
    try {
      if (ad.isFavorite == true) {
        await _favoriteRepository.removeFromFavorite(ad.id);
        final index = states.similarAds.indexOf(ad);
        final item = states.similarAds.elementAt(index);
        states.similarAds.insert(index, item..isFavorite = false);
      } else {
        final backendId = await _favoriteRepository.addToFavorite(ad);
        final index = states.similarAds.indexOf(ad);
        final item = states.similarAds.elementAt(index);
        states.similarAds.insert(
            index,
            item
              ..isFavorite = true
              ..backendId = backendId);
      }
    } catch (error) {
      display.error("xatolik yuz  berdi");
      log.e(error.toString());
    }
  }

  Future<void> addCart() async {
    try {
      await _cartRepository.addCart(states.adDetail!.toMap());
      updateState((state) => state.copyWith(isAddCart: true));
    } catch (e) {
      log.e(e.toString());
    }
  }

  Future<void> getSimilarAds() async {
    try {
      final ads = await _adRepository.getSimilarAds(
        adId: states.adId ?? 0,
        page: 1,
        limit: 10,
      );
      updateState(
        (state) => state.copyWith(
          similarAds: ads,
          similarAdsState: LoadingState.success,
        ),
      );
    } catch (e, stackTrace) {
      updateState(
        (state) => state.copyWith(similarAdsState: LoadingState.error),
      );
      log.e(e.toString(), error: e, stackTrace: stackTrace);
      // display.error(e.toString());
    }
  }

  Future<void> increaseAdStats(StatsType type) async {
    try {
      int? adId = states.adId;
      if (adId != null) {
        await _adRepository.increaseAdStats(type: type, adId: adId);
      }
    } catch (error) {
      log.e(error.toString());
    }
  }

  Future<void> addAdToRecentlyViewed() async {
    try {
      int? adId = states.adId;
      if (adId != null && _tokenStorage.isUserLoggedIn) {
        await _adRepository.addAdToRecentlyViewed(adId: adId);
      }
    } catch (error) {
      log.e(error.toString());
    }
  }

  Future<void> getOwnerOtherAds() async {
    if (state.state?.adDetail?.sellerTin == null) {
      updateState((state) => state.copyWith(ownerAdsState: LoadingState.error));
      return;
    }

    try {
      final ads = await _adRepository.getAdsByUser(
        sellerTin: state.state!.adDetail!.sellerTin!,
        page: 1,
        limit: 20,
      );

      display.success("Muallifning boshqa e'lonlari muaffaqiyatli yuklandi");

      ads.removeWhere((element) => element.id == state.state?.adId);
      updateState(
        (state) => state.copyWith(
          ownerAds: ads,
          ownerAdsState: LoadingState.success,
        ),
      );
    } catch (e, stackTrace) {
      updateState((state) => state.copyWith(ownerAdsState: LoadingState.error));
      log.e(e.toString(), error: e, stackTrace: stackTrace);
      display.error(e.toString());
    }
  }

  Future<void> ownerAdAddToFavorite(Ad ad) async {
    try {
      if (ad.isFavorite == true) {
        await _favoriteRepository.removeFromFavorite(ad.id);
        final index = states.ownerAds.indexOf(ad);
        final item = states.ownerAds.elementAt(index);
        states.ownerAds.insert(index, item..isFavorite = false);
      } else {
        final backendId = await _favoriteRepository.addToFavorite(ad);
        final index = states.ownerAds.indexOf(ad);
        final item = states.ownerAds.elementAt(index);
        states.ownerAds.insert(
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
      updateState(
        (state) => state.copyWith(recentlyViewedAdsState: LoadingState.error),
      );
      log.e(e.toString(), error: e, stackTrace: stackTrace);
      display.error(e.toString());
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
