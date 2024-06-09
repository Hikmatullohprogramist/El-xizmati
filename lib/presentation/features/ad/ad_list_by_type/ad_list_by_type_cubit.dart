import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/core/enum/enums.dart';
import 'package:onlinebozor/core/handler/future_handler_exts.dart';
import 'package:onlinebozor/data/repositories/ad_repository.dart';
import 'package:onlinebozor/data/repositories/favorite_repository.dart';
import 'package:onlinebozor/domain/models/ad/ad.dart';
import 'package:onlinebozor/domain/models/ad/ad_type.dart';
import 'package:onlinebozor/presentation/support/cubit/base_cubit.dart';

part 'ad_list_by_type_cubit.freezed.dart';
part 'ad_list_by_type_state.dart';

@injectable
class AdListByTypeCubit
    extends BaseCubit<AdListByTypeState, AdListByTypeEvent> {
  AdListByTypeCubit(
    this._adRepository,
    this._favoriteRepository,
  ) : super(AdListByTypeState());

  static const _pageSize = 20;

  final AdRepository _adRepository;
  final FavoriteRepository _favoriteRepository;

  Future<void> setInitialParams(AdType adType) async {
    updateState((state) => state.copyWith(adType: adType));
    getAds();
  }

  Future<void> getAds() async {
    await Future.wait([
      getCheapAdsByType(),
      getPopularAdsByType(),
      getController(),
    ]);
  }

  Future<void> getCheapAdsByType() async {
    _adRepository
        .getCheapAdsByType(
          adType: states.adType,
          page: 1,
          limit: 10,
        )
        .initFuture()
        .onStart(() {})
        .onSuccess((data) {
          updateState((state) => state.copyWith(
                cheapAds: data,
                cheapAdsState: LoadingState.success,
              ));
        })
        .onError((error) {
          updateState((state) => state.copyWith(
                cheapAdsState: LoadingState.error,
              ));
          logger.e(error);
        })
        .onFinished(() {})
        .executeFuture();
  }

  Future<void> getPopularAdsByType() async {
    _adRepository
        .getPopularAdsByType(
          adType: states.adType,
          page: 1,
          limit: 10,
        )
        .initFuture()
        .onStart(() {})
        .onSuccess((data) {
          updateState((state) => state.copyWith(
                popularAds: data,
                popularAdsState: LoadingState.success,
              ));
        })
        .onError((error) {
          logger.e(error);
          updateState((state) => state.copyWith(
                popularAdsState: LoadingState.error,
              ));
        })
        .onFinished(() {})
        .executeFuture();
  }

  Future<void> getController() async {
    final controller = states.controller ?? getAdsController(status: 1);
    updateState((state) => state.copyWith(controller: controller));
  }

  PagingController<int, Ad> getAdsController({
    required int status,
  }) {
    final adController = PagingController<int, Ad>(
      firstPageKey: 1,
    );
    logger.i(states.controller);

    adController.addPageRequestListener(
      (pageKey) async {
        final adsList = await _adRepository.getAdsByType(
          adType: states.adType,
          page: pageKey,
          limit: _pageSize,
        );
        if (adsList.length <= 19) {
          adController.appendLastPage(adsList);
          logger.i(states.controller);
          return;
        }
        adController.appendPage(adsList, pageKey + 1);
        logger.i(states.controller);
      },
    );
    return adController;
  }

  Future<void> popularAdsAddFavorite(Ad ad) async {
    try {
      if (ad.isFavorite == true) {
        await _favoriteRepository.removeFromFavorite(ad.id);
        final index = states.popularAds.indexOf(ad);
        final item = states.popularAds.elementAt(index);
        states.popularAds.insert(index, item..isFavorite = false);
      } else {
        final backendId = await _favoriteRepository.addToFavorite(ad);
        final index = states.popularAds.indexOf(ad);
        final item = states.popularAds.elementAt(index);
        states.popularAds.insert(
          index,
          item
            ..isFavorite = true
            ..backendId = backendId,
        );
      }
    } catch (error) {
      stateMessageManager.showErrorSnackBar("xatolik yuz  berdi");
      logger.e(error.toString());
    }
  }

  Future<void> cheapAdsAddFavorite(Ad ad) async {
    try {
      if (ad.isFavorite == true) {
        await _favoriteRepository.removeFromFavorite(ad.id);
        final index = states.cheapAds.indexOf(ad);
        final item = states.cheapAds.elementAt(index);
        states.cheapAds.insert(index, item..isFavorite = false);
      } else {
        final backendId = await _favoriteRepository.addToFavorite(ad);
        final index = states.cheapAds.indexOf(ad);
        final item = states.cheapAds.elementAt(index);
        states.cheapAds.insert(
          index,
          item
            ..isFavorite = true
            ..backendId = backendId,
        );
      }
    } catch (error) {
      stateMessageManager.showErrorSnackBar("xatolik yuz  berdi");
      logger.e(error.toString());
    }
  }

  Future<void> addFavorite(Ad ad) async {
    try {
      if (ad.isFavorite == true) {
        await _favoriteRepository.removeFromFavorite(ad.id);
        final index = states.controller?.itemList?.indexOf(ad) ?? 0;
        final item = states.controller?.itemList?.elementAt(index);
        if (item != null) {
          states.controller?.itemList?.insert(index, item..isFavorite = false);
          states.controller?.itemList?.removeAt(index);
          states.controller?.notifyListeners();
        }
      } else {
        final backendId = await _favoriteRepository.addToFavorite(ad);
        final index = states.controller?.itemList?.indexOf(ad) ?? 0;
        final item = states.controller?.itemList?.elementAt(index);
        if (item != null) {
          states.controller?.itemList?.insert(
            index,
            item
              ..isFavorite = true
              ..backendId = backendId,
          );
          states.controller?.itemList?.removeAt(index);
          states.controller?.notifyListeners();
        }
      }
    } catch (error) {
      stateMessageManager.showErrorSnackBar("xatolik yuz  berdi");
      logger.e(error.toString());
    }
  }
}
