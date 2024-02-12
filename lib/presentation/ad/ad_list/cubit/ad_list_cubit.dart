import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';

import '../../../../common/core/base_cubit.dart';
import '../../../../common/enum/enums.dart';
import '../../../../domain/models/ad/ad.dart';
import '../../../../domain/models/ad/ad_list_type.dart';
import '../../../../domain/models/ad/ad_type.dart';
import '../../../../domain/repositories/ad_repository.dart';
import '../../../../domain/repositories/common_repository.dart';
import '../../../../domain/repositories/favorite_repository.dart';

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
    build((buildable) => buildable.copyWith(
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
          buildable.adsPagingController ?? getAdsController(status: 1);
      build((buildable) => buildable.copyWith(adsPagingController: controller));
    } on DioException catch (e, stackTrace) {
      log.e(e.toString(), error: e, stackTrace: stackTrace);
      display.error(e.toString());
    } finally {
      log.i(buildable.adsPagingController);
    }
  }

  PagingController<int, Ad> getAdsController({
    required int status,
  }) {
    final adController = PagingController<int, Ad>(
      firstPageKey: 1,
    );
    log.i(buildable.adsPagingController);

    adController.addPageRequestListener(
      (pageKey) async {
        List<Ad> adsList;
        switch (buildable.adListType) {
          case AdListType.homeList:
            adsList = await adRepository.getHomeAds(
              pageKey,
              _pageSize,
              buildable.keyWord,
            );
          case AdListType.homePopularAds:
            adsList = await adRepository.getPopularAdsByType(
              adType: AdType.product,
              page: pageKey,
              limit: _pageSize,
            );
          case AdListType.adsByUser:
            adsList = await adRepository.getAdsByUser(
              sellerTin: buildable.sellerTin ?? -1,
              page: pageKey,
              limit: 20,
            );
          case AdListType.similarAds:
            adsList = await adRepository.getSimilarAds(
              adId: buildable.adId ?? 0,
              page: pageKey,
              limit: 20,
            );
          case AdListType.popularCategoryAds:
            adsList = await adRepository.getHomeAds(
              pageKey,
              _pageSize,
              buildable.keyWord,
            );
          case AdListType.cheaperAdsByAdType:
            adsList = await adRepository.getCheapAdsByType(
              adType: buildable.collectiveType ?? AdType.product,
              page: pageKey,
              limit: 20,
            );
          case AdListType.popularAdsByAdType:
            adsList = await adRepository.getPopularAdsByType(
              adType: buildable.collectiveType ?? AdType.product,
              page: pageKey,
              limit: 20,
            );
          case AdListType.recentlyViewedAds:
            adsList = await adRepository.getRecentlyViewedAds(
                page: pageKey, limit: 20);
        }

        if (buildable.adListType == AdListType.homePopularAds ||
            buildable.adListType == AdListType.cheaperAdsByAdType ||
            buildable.adListType == AdListType.popularAdsByAdType ||
            buildable.adListType == AdListType.popularCategoryAds ||
            buildable.adListType == AdListType.adsByUser ||
            buildable.adListType == AdListType.similarAds) {
          adController.appendLastPage(adsList);
          log.i(buildable.adsPagingController);
          return;
        } else {
          if (adsList.length <= 19) {
            adController.appendLastPage(adsList);
            log.i(buildable.adsPagingController);
            return;
          }
          adController.appendPage(adsList, pageKey + 1);
          log.i(buildable.adsPagingController);
        }
      },
    );
    return adController;
  }

  Future<void> addFavorite(Ad ad) async {
    try {
      if (!ad.favorite) {
        final backendId = await favoriteRepository.addFavorite(ad);
        final index = buildable.adsPagingController?.itemList?.indexOf(ad) ?? 0;
        final item = buildable.adsPagingController?.itemList?.elementAt(index);
        if (item != null) {
          buildable.adsPagingController?.itemList?.insert(
              index,
              item
                ..favorite = true
                ..backendId = backendId);
          buildable.adsPagingController?.itemList?.removeAt(index);
          buildable.adsPagingController?.notifyListeners();
        }
      } else {
        await favoriteRepository.removeFavorite(ad);
        final index = buildable.adsPagingController?.itemList?.indexOf(ad) ?? 0;
        final item = buildable.adsPagingController?.itemList?.elementAt(index);
        if (item != null) {
          buildable.adsPagingController?.itemList
              ?.insert(index, item..favorite = false);
          buildable.adsPagingController?.itemList?.removeAt(index);
          buildable.adsPagingController?.notifyListeners();
        }
      }
    } on DioException catch (error) {
      display.error("xatolik yuz  berdi");
      log.w(error.toString());
    }
  }
}
