import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/enum/enums.dart';

import '../../../../common/core/base_cubit.dart';
import '../../../../data/repositories/ad_repository.dart';
import '../../../../data/repositories/common_repository.dart';
import '../../../../data/repositories/favorite_repository.dart';
import '../../../../domain/models/ad/ad.dart';
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

  Future<void> setInitialParams(AdType adType) async {
    updateState((state) => state.copyWith(adType: adType));
    getHome();
  }

  Future<void> getHome() async {
    await Future.wait([
      getCheapAdsByType(),
      getPopularAdsByType(),
      getController(),
    ]);
  }

  Future<void> getCheapAdsByType() async {
    try {
      final cheapAds = await adRepository.getCheapAdsByType(
        adType: states.adType,
        page: 1,
        limit: 10,
      );
      updateState(
        (state) => state.copyWith(
          cheapAds: cheapAds,
          cheapAdsState: LoadingState.success,
        ),
      );
    } catch (e, stackTrace) {
      updateState(
        (state) => state.copyWith(cheapAdsState: LoadingState.error),
      );
      log.e(e.toString(), error: e, stackTrace: stackTrace);
      display.error(e.toString());
    }
  }

  Future<void> getPopularAdsByType() async {
    try {
      final popularAds = await adRepository.getPopularAdsByType(
        adType: states.adType,
        page: 1,
        limit: 10,
      );
      updateState(
        (state) => state.copyWith(
          popularAds: popularAds,
          popularAdsState: LoadingState.success,
        ),
      );
    } catch (e, stackTrace) {
      updateState(
          (state) => state.copyWith(popularAdsState: LoadingState.error));
      log.e(e.toString(), error: e, stackTrace: stackTrace);
      display.error(e.toString());
    }
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

  PagingController<int, Ad> getAdsController({
    required int status,
  }) {
    final adController = PagingController<int, Ad>(
      firstPageKey: 1,
    );
    log.i(states.controller);

    adController.addPageRequestListener(
      (pageKey) async {
        final adsList = await adRepository.getAdsByType(
          adType: states.adType,
          page: pageKey,
          limit: _pageSize,
        );
        if (adsList.length <= 19) {
          adController.appendLastPage(adsList);
          log.i(states.controller);
          return;
        }
        adController.appendPage(adsList, pageKey + 1);
        log.i(states.controller);
      },
    );
    return adController;
  }

  Future<void> popularAdsAddFavorite(Ad ad) async {
    try {
      if (ad.favorite == true) {
        await favoriteRepository.removeFromFavorite(ad.id);
        final index = states.popularAds.indexOf(ad);
        final item = states.popularAds.elementAt(index);
        states.popularAds.insert(index, item..favorite = false);
      } else {
        final backendId = await favoriteRepository.addToFavorite(ad);
        final index = states.popularAds.indexOf(ad);
        final item = states.popularAds.elementAt(index);
        states.popularAds.insert(
          index,
          item
            ..favorite = true
            ..backendId = backendId,
        );
      }
    } catch (error) {
      display.error("xatolik yuz  berdi");
      log.e(error.toString());
    }
  }

  Future<void> cheapAdsAddFavorite(Ad ad) async {
    try {
      if (ad.favorite == true) {
        await favoriteRepository.removeFromFavorite(ad.id);
        final index = states.cheapAds.indexOf(ad);
        final item = states.cheapAds.elementAt(index);
        states.cheapAds.insert(index, item..favorite = false);
      } else {
        final backendId = await favoriteRepository.addToFavorite(ad);
        final index = states.cheapAds.indexOf(ad);
        final item = states.cheapAds.elementAt(index);
        states.cheapAds.insert(
          index,
          item
            ..favorite = true
            ..backendId = backendId,
        );
      }
    } catch (error) {
      display.error("xatolik yuz  berdi");
      log.e(error.toString());
    }
  }

  Future<void> addFavorite(Ad ad) async {
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
              ..backendId = backendId,
          );
          states.controller?.itemList?.removeAt(index);
          states.controller?.notifyListeners();
        }
      }
    } catch (error) {
      display.error("xatolik yuz  berdi");
      log.e(error.toString());
    }
  }
}
