import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';

import '../../../../common/core/base_cubit.dart';
import '../../../../common/enum/enums.dart';
import '../../../../data/repositories/ad_repository.dart';
import '../../../../data/repositories/common_repository.dart';
import '../../../../data/repositories/favorite_repository.dart';
import '../../../../domain/models/ad/ad.dart';
import '../../../../domain/models/ad/ad_list_type.dart';
import '../../../../domain/models/ad/ad_type.dart';

part 'page_cubit.freezed.dart';
part 'page_state.dart';

@injectable
class PageCubit extends BaseCubit<PageState, PageEvent> {
  PageCubit(
    this.adRepository,
    this.commonRepository,
    this.favoriteRepository,
  ) : super(PageState());

  static const _pageSize = 20;
  final AdRepository adRepository;
  final CommonRepository commonRepository;
  final FavoriteRepository favoriteRepository;

  void setInitialParams(
    AdListType adListType,
    String? keyWord,
    int? sellerTin,
    int? adId,
    AdType? collectiveType,
  ) {
    updateState(
      (state) => state.copyWith(
        adListType: adListType,
        keyWord: keyWord ?? "",
        sellerTin: sellerTin,
        adId: adId,
        collectiveType: collectiveType,
        controller: null,
      ),
    );

    getController();
  }

  Future<void> getController() async {
    try {
      final controller = states.controller ?? getAdsController(status: 1);
      updateState((state) => state.copyWith(controller: controller));
    } catch (e, stackTrace) {
      log.e(e.toString(), error: e, stackTrace: stackTrace);
      display.error(e.toString());
    } finally {
      log.i(states.controller);
    }
  }

  PagingController<int, Ad> getAdsController({required int status}) {
    final adController = PagingController<int, Ad>(firstPageKey: 1);
    log.i(states.controller);

    adController.addPageRequestListener(
      (pageKey) async {
        List<Ad> adsList;
        switch (states.adListType) {
          case AdListType.homeList:
            adsList = await adRepository.getHomeAds(
              pageKey,
              _pageSize,
              states.keyWord,
            );
          case AdListType.homePopularAds:
            adsList = await adRepository.getPopularAdsByType(
              adType: AdType.product,
              page: pageKey,
              limit: _pageSize,
            );
          case AdListType.adsByUser:
            adsList = await adRepository.getAdsByUser(
              sellerTin: states.sellerTin ?? -1,
              page: pageKey,
              limit: 20,
            );
          case AdListType.similarAds:
            adsList = await adRepository.getSimilarAds(
              adId: states.adId ?? 0,
              page: pageKey,
              limit: 20,
            );
          case AdListType.popularCategoryAds:
            adsList = await adRepository.getHomeAds(
              pageKey,
              _pageSize,
              states.keyWord,
            );
          case AdListType.cheaperAdsByAdType:
            adsList = await adRepository.getCheapAdsByType(
              adType: states.collectiveType ?? AdType.product,
              page: pageKey,
              limit: 20,
            );
          case AdListType.popularAdsByAdType:
            adsList = await adRepository.getPopularAdsByType(
              adType: states.collectiveType ?? AdType.product,
              page: pageKey,
              limit: 20,
            );
          case AdListType.recentlyViewedAds:
            adsList = await adRepository.getRecentlyViewedAds(
                page: pageKey, limit: 20);
        }

        if (states.adListType == AdListType.homePopularAds ||
            states.adListType == AdListType.cheaperAdsByAdType ||
            states.adListType == AdListType.popularAdsByAdType ||
            states.adListType == AdListType.popularCategoryAds ||
            states.adListType == AdListType.adsByUser ||
            states.adListType == AdListType.similarAds) {
          adController.appendLastPage(adsList);
          log.i(states.controller);
          return;
        } else {
          if (adsList.length <= 19) {
            adController.appendLastPage(adsList);
            log.i(states.controller);
            return;
          }
          adController.appendPage(adsList, pageKey + 1);
          log.i(states.controller);
        }
      },
    );
    return adController;
  }

  Future<void> changeFavorite(Ad ad) async {
    try {
      if (ad.favorite == true) {
        await favoriteRepository.removeFromFavorite(ad.id);
        final index = states.controller?.itemList?.indexOf(ad) ?? 0;
        final item = states.controller?.itemList?.elementAt(index);
        if (item != null) {
          states.controller?.itemList?.insert(index, item..favorite = false);
          states.controller?.itemList?.removeAt(index);
          states.controller?.notifyListeners();
        }
      } else {
        final backendId = await favoriteRepository.addToFavorite(ad);
        final index = states.controller?.itemList?.indexOf(ad) ?? 0;
        final item = states.controller?.itemList?.elementAt(index);
        if (item != null) {
          states.controller?.itemList?.insert(
              index,
              item
                ..favorite = true
                ..backendId = backendId);
          states.controller?.itemList?.removeAt(index);
          states.controller?.notifyListeners();
        }
      }
    } catch (error) {
      display.error("xatolik yuz  berdi");
      log.w(error.toString());
    }
  }
}
