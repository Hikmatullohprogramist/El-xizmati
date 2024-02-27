import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';

import '../../../../common/core/base_cubit.dart';
import '../../../../common/enum/enums.dart';
import '../../../../domain/models/ad/ad.dart';
import '../../../../domain/models/ad/ad_list_type.dart';
import '../../../../domain/models/ad/ad_type.dart';
import '../../../../data/repositories/ad_repository.dart';
import '../../../../data/repositories/common_repository.dart';
import '../../../../data/repositories/favorite_repository.dart';

part 'ad_list_cubit.freezed.dart';

part 'ad_list_state.dart';

@injectable
class AdListCubit extends BaseCubit<AdListBuildable, AdListListenable> {
  AdListCubit(
    this.adRepository,
    this.commonRepository,
    this.favoriteRepository,
  ) : super(AdListBuildable());

  void setInitiallyDate(String? keyWord, AdListType adListType, int? sellerTin,
      int? adId, AdType? collectiveType) {
    updateState((buildable) => buildable.copyWith(
        adsPagingController: null,
        keyWord: keyWord ?? "",
        sellerTin: sellerTin,
        adListType: adListType,
        adId: adId,
        collectiveType: collectiveType));
    getController();
  }

  static const _pageSize = 20;
  final AdRepository adRepository;
  final CommonRepository commonRepository;
  final FavoriteRepository favoriteRepository;

  Future<void> getController() async {
    try {
      final controller =
          currentState.adsPagingController ?? getAdsController(status: 1);
      updateState((buildable) => buildable.copyWith(adsPagingController: controller));
    } on DioException catch (e, stackTrace) {
      log.e(e.toString(), error: e, stackTrace: stackTrace);
      display.error(e.toString());
    } finally {
      log.i(currentState.adsPagingController);
    }
  }

  PagingController<int, Ad> getAdsController({
    required int status,
  }) {
    final adController = PagingController<int, Ad>(
      firstPageKey: 1,
    );
    log.i(currentState.adsPagingController);

    adController.addPageRequestListener(
      (pageKey) async {
        List<Ad> adsList;
        switch (currentState.adListType) {
          case AdListType.homeList:
            adsList = await adRepository.getHomeAds(
              pageKey,
              _pageSize,
              currentState.keyWord,
            );
          case AdListType.homePopularAds:
            adsList = await adRepository.getPopularAdsByType(
              adType: AdType.product,
              page: pageKey,
              limit: _pageSize,
            );
          case AdListType.adsByUser:
            adsList = await adRepository.getAdsByUser(
              sellerTin: currentState.sellerTin ?? -1,
              page: pageKey,
              limit: 20,
            );
          case AdListType.similarAds:
            adsList = await adRepository.getSimilarAds(
              adId: currentState.adId ?? 0,
              page: pageKey,
              limit: 20,
            );
          case AdListType.popularCategoryAds:
            adsList = await adRepository.getHomeAds(
              pageKey,
              _pageSize,
              currentState.keyWord,
            );
          case AdListType.cheaperAdsByAdType:
            adsList = await adRepository.getCheapAdsByType(
              adType: currentState.collectiveType ?? AdType.product,
              page: pageKey,
              limit: 20,
            );
          case AdListType.popularAdsByAdType:
            adsList = await adRepository.getPopularAdsByType(
              adType: currentState.collectiveType ?? AdType.product,
              page: pageKey,
              limit: 20,
            );
          case AdListType.recentlyViewedAds:
            adsList = await adRepository.getRecentlyViewedAds(
                page: pageKey, limit: 20);
        }

        if (currentState.adListType == AdListType.homePopularAds ||
            currentState.adListType == AdListType.cheaperAdsByAdType ||
            currentState.adListType == AdListType.popularAdsByAdType ||
            currentState.adListType == AdListType.popularCategoryAds ||
            currentState.adListType == AdListType.adsByUser ||
            currentState.adListType == AdListType.similarAds) {
          adController.appendLastPage(adsList);
          log.i(currentState.adsPagingController);
          return;
        } else {
          if (adsList.length <= 19) {
            adController.appendLastPage(adsList);
            log.i(currentState.adsPagingController);
            return;
          }
          adController.appendPage(adsList, pageKey + 1);
          log.i(currentState.adsPagingController);
        }
      },
    );
    return adController;
  }

  Future<void> addFavorite(Ad ad) async {
    try {
      if (!ad.favorite) {
        final backendId = await favoriteRepository.addFavorite(ad);
        final index = currentState.adsPagingController?.itemList?.indexOf(ad) ?? 0;
        final item = currentState.adsPagingController?.itemList?.elementAt(index);
        if (item != null) {
          currentState.adsPagingController?.itemList?.insert(
              index,
              item
                ..favorite = true
                ..backendId = backendId);
          currentState.adsPagingController?.itemList?.removeAt(index);
          currentState.adsPagingController?.notifyListeners();
        }
      } else {
        await favoriteRepository.removeFavorite(ad);
        final index = currentState.adsPagingController?.itemList?.indexOf(ad) ?? 0;
        final item = currentState.adsPagingController?.itemList?.elementAt(index);
        if (item != null) {
          currentState.adsPagingController?.itemList
              ?.insert(index, item..favorite = false);
          currentState.adsPagingController?.itemList?.removeAt(index);
          currentState.adsPagingController?.notifyListeners();
        }
      }
    } on DioException catch (error) {
      display.error("xatolik yuz  berdi");
      log.w(error.toString());
    }
  }
}
