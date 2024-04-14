import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';

import '../../../../../common/core/base_cubit.dart';
import '../../../../../data/repositories/cart_repository.dart';
import '../../../../../data/repositories/favorite_repository.dart';
import '../../../../../domain/models/ad/ad.dart';

part 'page_cubit.freezed.dart';

part 'page_state.dart';

@injectable
class PageCubit extends BaseCubit<PageState, PageEvent> {
  PageCubit(
    this.repository,
    this.favoriteRepository,
  ) : super(PageState()) {
    getController();
  }
  final CartRepository repository;
  final FavoriteRepository favoriteRepository;

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
      invisibleItemsThreshold: 100,
    );
    log.i(states.controller);

    adController.addPageRequestListener(
      (pageKey) async {
        final adsList = await repository.getCartAds();
        if (adsList.length <= 1000) {
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

  Future<void> removeFromCart(Ad ad) async {
    try {
      await repository.removeCart(ad);
      final items = states.items.map((e) => e).toList();
      items.removeWhere((e) => e.id == ad.id);
      updateState((state) => state.copyWith(items: items));
    } catch (e) {
      display.error(e.toString());
    }
  }

  Future<void> changeFavorite(Ad ad) async {
    try {
      if (!ad.favorite) {
        await favoriteRepository.removeFromFavorite(ad.id);
      } else {
        await favoriteRepository.addToFavorite(ad);
      }
      final items = states.items.map((e) => e.copy()).toList();
      final index = items.indexWhere((e) => e.id == ad.id);
      final newAd = ad..favorite = !ad.favorite;
      items.removeWhere((e) => e.id ==  ad.id);
      items.insert(index, newAd);

      updateState((state) => state.copyWith(items: items));
    } catch (e) {
      display.error(e.toString());
    }
  }
}
