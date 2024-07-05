import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/core/enum/enums.dart';
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
    // watchCardAds();

    getCartAds();
  }

  StreamSubscription? _cartSubscription;

  @override
  Future<void> close() async {
    await _cartSubscription?.cancel();
    super.close();
  }

  void watchCardAds() {
    _cartSubscription = _cartRepository.watchCartAds().listen((ads) {
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
        .getActualCartAds()
        .initFuture()
        .onStart(() {
          updateState((state) => state.copyWith(
                cartAdsState: LoadingState.loading,
              ));
        })
        .onSuccess((data) => watchCardAds())
        .onError((error) {
          logger.w("getActualCartAds error = $error");
        })
        .onFinished(() {})
        .executeFuture();
  }

  Future<void> removeFromCart(Ad ad) async {
    _cartRepository
        .removeFromCart(ad.id)
        .initFuture()
        .onStart(() {})
        .onSuccess((data) {})
        .onError((error) {
          stateMessageManager.showErrorSnackBar(error.localizedMessage);
        })
        .onFinished(() {})
        .executeFuture();
  }

  Future<void> changeFavorite(Ad ad) async {
    try {
      if (ad.isFavorite) {
        await _favoriteRepository.removeFromFavorite(ad.id);
      } else {
        await _favoriteRepository.addToFavorite(ad);
      }
    } catch (e) {
      stateMessageManager.showErrorSnackBar(e.localizedMessage);
    }
  }
}
