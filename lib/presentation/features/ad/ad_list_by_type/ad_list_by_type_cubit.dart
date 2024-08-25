import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:El_xizmati/core/enum/enums.dart';
import 'package:El_xizmati/core/extensions/list_extensions.dart';
import 'package:El_xizmati/core/handler/future_handler_exts.dart';
import 'package:El_xizmati/data/repositories/ad_repository.dart';
import 'package:El_xizmati/data/repositories/favorite_repository.dart';
import 'package:El_xizmati/domain/models/ad/ad.dart';
import 'package:El_xizmati/domain/models/ad/ad_type.dart';
import 'package:El_xizmati/presentation/support/cubit/base_cubit.dart';

part 'ad_list_by_type_cubit.freezed.dart';
part 'ad_list_by_type_state.dart';

@injectable
class AdListByTypeCubit
    extends BaseCubit<AdListByTypeState, AdListByTypeEvent> {
  AdListByTypeCubit(
    this._adRepository,
    this._favoriteRepository,
  ) : super(AdListByTypeState());

  final AdRepository _adRepository;
  final FavoriteRepository _favoriteRepository;

  static const _limit = 20;
  StreamSubscription? _cheapestAdsSubs;
  StreamSubscription? _popularAdsSubs;

  @override
  Future<void> close() async {
    await _cheapestAdsSubs?.cancel();
    await _popularAdsSubs?.cancel();

    super.close();
  }

  Future<void> setInitialParams(AdType adType) async {
    updateState((state) => state.copyWith(adType: adType));
    getAds();
  }

  Future<void> getAds() async {
    await Future.wait([
      getCheapAdsByType(),
      getPopularAdsByType(),
      initController(),
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
          final ids = data.adIds();

          _cheapestAdsSubs?.cancel();
          _cheapestAdsSubs = _adRepository.watchAdsByIds(ids).listen((ads) {
            updateState((state) => state.copyWith(
                  cheapAds: ads.map((e) => e.copy()).toList(),
                  cheapAdsState:
                      ads.isEmpty ? LoadingState.empty : LoadingState.success,
                ));
          })
            ..onError((error) {
              updateState((state) => state.copyWith(
                    cheapAdsState: LoadingState.error,
                  ));
            });
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
          final ids = data.adIds();

          _popularAdsSubs?.cancel();
          _popularAdsSubs = _adRepository.watchAdsByIds(ids).listen((ads) {
            updateState((state) => state.copyWith(
                  popularAds: ads.map((e) => e.copy()).toList(),
                  popularAdsState:
                      ads.isEmpty ? LoadingState.empty : LoadingState.success,
                ));
          })
            ..onError((error) {
              updateState((state) => state.copyWith(
                    popularAdsState: LoadingState.error,
                  ));
            });
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

  Future<void> initController() async {
    final controller = states.controller ?? getController(status: 1);
    updateState((state) => state.copyWith(controller: controller));
  }

  PagingController<int, Ad> getController({
    required int status,
  }) {
    final controller = PagingController<int, Ad>(
      firstPageKey: 1,
    );
    logger.i(states.controller);

    controller.addPageRequestListener(
      (pageKey) {
        _adRepository
            .getAdsByType(
              adType: states.adType,
              page: pageKey,
              limit: _limit,
            )
            .initFuture()
            .onStart(() {})
            .onSuccess((data) {
              if (data.length <= 19) {
                controller.appendLastPage(data);
                logger.i(states.controller);
                return;
              }
              controller.appendPage(data, pageKey + 1);
            })
            .onError((error) {
              controller.error = error;
            })
            .onFinished(() {})
            .executeFuture();
      },
    );
    return controller;
  }

  Future<void> cheapAdsAddFavorite(Ad ad) async {
    if (ad.isFavorite == true) {
      await _favoriteRepository.removeFromFavorite(ad.id);
    } else {
      await _favoriteRepository.addToFavorite(ad);
    }
  }

  Future<void> popularAdsAddFavorite(Ad ad) async {
    if (ad.isFavorite == true) {
      await _favoriteRepository.removeFromFavorite(ad.id);
    } else {
      await _favoriteRepository.addToFavorite(ad);
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
