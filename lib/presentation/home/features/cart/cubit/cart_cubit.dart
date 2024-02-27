import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';

import '../../../../../common/core/base_cubit.dart';
import '../../../../../data/repositories/cart_repository.dart';
import '../../../../../data/repositories/favorite_repository.dart';
import '../../../../../domain/models/ad/ad.dart';

part 'cart_cubit.freezed.dart';
part 'cart_state.dart';

@injectable
class CartCubit extends BaseCubit<CartBuildable, CartListenable> {
  CartCubit(this._cartRepository, this.favoriteRepository)
      : super(CartBuildable()) {
    getController();
  }

  final CartRepository _cartRepository;
  final FavoriteRepository favoriteRepository;

  Future<void> getController() async {
    try {
      final controller =
          currentState.adsPagingController ?? getAdsController(status: 1);
      updateState((buildable) => buildable.copyWith(adsPagingController: controller));
    }on DioException  catch (e, stackTrace) {
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
        firstPageKey: 1, invisibleItemsThreshold: 100);
    log.i(currentState.adsPagingController);

    adController.addPageRequestListener(
      (pageKey) async {
        final adsList = await _cartRepository.getCartAds();
        if (adsList.length <= 1000) {
          adController.appendLastPage(adsList);
          log.i(currentState.adsPagingController);
          return;
        }
        adController.appendPage(adsList, pageKey + 1);
        log.i(currentState.adsPagingController);
      },
    );
    return adController;
  }

  Future<void> removeCart(Ad ad) async {
    try {
      await _cartRepository.removeCart(ad);
      currentState.adsPagingController?.itemList?.remove(ad);
      currentState.adsPagingController?.notifyListeners();
    } on DioException catch (e) {
      display.error(e.toString());
    }
  }

  Future<void> addFavorite(Ad ad) async {
    try {
      if (!ad.favorite) {
        await favoriteRepository.addFavorite(ad);
      } else {
        await favoriteRepository.removeFavorite(ad);
      }
      final index = currentState.adsPagingController?.itemList?.indexOf(ad);
      if (index != null) {
        final newAd = ad..favorite = !ad.favorite;
        currentState.adsPagingController?.itemList?.remove(ad);
        currentState.adsPagingController?.itemList?.insert(index, newAd);
        currentState.adsPagingController?.notifyListeners();
      }
    } on DioException catch (e) {
      display.error(e.toString());
    }
  }
}
