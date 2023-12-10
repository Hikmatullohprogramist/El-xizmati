import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';

import '../../../../../common/core/base_cubit.dart';
import '../../../../../domain/models/ad.dart';
import '../../../../../domain/repositories/cart_repository.dart';
import '../../../../../domain/repositories/favorite_repository.dart';

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
          buildable.adsPagingController ?? getAdsController(status: 1);
      build((buildable) => buildable.copyWith(adsPagingController: controller));
    }on DioException  catch (e, stackTrace) {
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
        firstPageKey: 1, invisibleItemsThreshold: 100);
    log.i(buildable.adsPagingController);

    adController.addPageRequestListener(
      (pageKey) async {
        final adsList = await _cartRepository.getCartAds();
        if (adsList.length <= 1000) {
          adController.appendLastPage(adsList);
          log.i(buildable.adsPagingController);
          return;
        }
        adController.appendPage(adsList, pageKey + 1);
        log.i(buildable.adsPagingController);
      },
    );
    return adController;
  }

  Future<void> removeCart(Ad ad) async {
    try {
      await _cartRepository.removeCart(ad);
      buildable.adsPagingController?.itemList?.remove(ad);
      buildable.adsPagingController?.notifyListeners();
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
      final index = buildable.adsPagingController?.itemList?.indexOf(ad);
      if (index != null) {
        final newAdModel = ad..favorite = !ad.favorite;
        buildable.adsPagingController?.itemList?.remove(ad);
        buildable.adsPagingController?.itemList?.insert(index, newAdModel);
        buildable.adsPagingController?.notifyListeners();
      }
    } on DioException catch (e) {
      display.error(e.toString());
    }
  }
}
