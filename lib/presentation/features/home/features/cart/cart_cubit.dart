import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/core/enum/enums.dart';
import 'package:onlinebozor/core/extensions/list_extensions.dart';
import 'package:onlinebozor/core/handler/future_handler_exts.dart';
import 'package:onlinebozor/data/repositories/cart_repository.dart';
import 'package:onlinebozor/data/repositories/favorite_repository.dart';
import 'package:onlinebozor/domain/models/ad/ad.dart';
import 'package:onlinebozor/presentation/support/cubit/base_cubit.dart';
import 'package:onlinebozor/presentation/support/extensions/extension_message_exts.dart';

part 'cart_cubit.freezed.dart';
part 'cart_state.dart';

@injectable
class CartCubit extends BaseCubit<CartState, CartEvent> {
  final CartRepository _cartRepository;
  final FavoriteRepository _favoriteRepository;

  CartCubit(
    this._cartRepository,
    this._favoriteRepository,
  ) : super(CartState()) {
    // getCartAds();
    watchCardAds();
  }

  StreamSubscription? _cartSubscription;

  @override
  Future<void> close() async {
    await _cartSubscription?.cancel();
    super.close();
  }

  void watchCardAds() {
    _cartSubscription = _cartRepository.watchCartAds().listen((ads) {
      logger.w("watchCardAds ads count = ${ads.length}, cart count = ${ads.cartCount()}, favorite count = ${ads.favoriteCount()}");
      updateState((state) => state.copyWith(
            cardAds: ads,
            cartAdsState:
                ads.isEmpty ? LoadingState.empty : LoadingState.success,
          ));
    })
      ..onError((error) {
        logger.w("watchCardAds error = $error");
        updateState(
            (state) => state.copyWith(cartAdsState: LoadingState.error));
      });
  }

  Future<void> getCartAds() async {
    _cartRepository
        .getCartAds()
        .initFuture()
        .onStart(() {
          updateState((state) => state.copyWith(
                cartAdsState: LoadingState.loading,
              ));
        })
        .onSuccess((data) {
          logger.w("getCartProducts success = [${data.length}]");
          updateState((state) => state.copyWith(
                cardAds: data,
                cartAdsState:
                    data.isEmpty ? LoadingState.empty : LoadingState.success,
              ));
        })
        .onError((error) {
          logger.w("getCartProducts error = $error");
          updateState((state) => state.copyWith(
                cartAdsState: LoadingState.error,
              ));
        })
        .onFinished(() {})
        .executeFuture();
  }

  Future<void> removeFromCart(Ad ad) async {
    _cartRepository
        .removeFromCart(ad.id)
        .initFuture()
        .onStart(() {})
        .onSuccess((data) {
          // final items = states.cardAds.map((e) => e).toList();
          // items.removeWhere((e) => e.id == ad.id);
          // updateState((state) => state.copyWith(cardAds: items));
        })
        .onError((error) {
          stateMessageManager.showErrorSnackBar(error.localizedMessage);
        })
        .onFinished(() {})
        .executeFuture();
  }

  Future<void> changeFavorite(Ad ad) async {
    try {
      if (ad.isFavorite) {
        logger.w("cubit => ${ad.isFavorite} before remove");
        await _favoriteRepository.removeFromFavorite(ad.id);
        logger.w("cubit => ${ad.isFavorite} after remove");
      } else {
        logger.w("cubit => ${ad.isFavorite} before add");
        await _favoriteRepository.addToFavorite(ad);
        logger.w("cubit => ${ad.isFavorite} after add");
      }
      // final items = states.cardAds.map((e) => e.copy()).toList();
      // final index = items.indexWhere((e) => e.id == ad.id);
      // final newAd = ad..isFavorite = !ad.isFavorite;
      // items.removeWhere((e) => e.id == ad.id);
      // items.insert(index, newAd);

      // updateState((state) => state.copyWith(cardAds: items));
    } catch (e) {
      stateMessageManager.showErrorSnackBar(e.localizedMessage);
    }
  }
}
