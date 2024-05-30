import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/core/enum/enums.dart';
import 'package:onlinebozor/core/handler/future_handler_exts.dart';
import 'package:onlinebozor/data/repositories/cart_repository.dart';
import 'package:onlinebozor/data/repositories/favorite_repository.dart';
import 'package:onlinebozor/domain/models/ad/ad.dart';
import 'package:onlinebozor/presentation/support/cubit/base_cubit.dart';

part 'cart_cubit.freezed.dart';
part 'cart_state.dart';

@injectable
class CartCubit extends BaseCubit<CartState, CartEvent> {
  CartCubit(
    this._cartRepository,
    this._favoriteRepository,
  ) : super(CartState()) {
    getItems();
  }

  final CartRepository _cartRepository;
  final FavoriteRepository _favoriteRepository;

  Future<void> getItems() async {
    _cartRepository
        .getCartAds()
        .initFuture()
        .onStart(() {
          updateState((state) => state.copyWith(
                loadState: LoadingState.loading,
              ));
        })
        .onSuccess((data) {
          logger.w("getCartProducts success = [${data.length}]");
          updateState((state) => state.copyWith(
                items: data,
                loadState:
                    data.isEmpty ? LoadingState.empty : LoadingState.success,
              ));
        })
        .onError((error) {
          logger.w("getCartProducts error = $error");
          updateState((state) => state.copyWith(
                loadState: LoadingState.error,
              ));
        })
        .onFinished(() {})
        .executeFuture();
  }

  Future<void> removeFromCart(Ad ad) async {
    try {
      await _cartRepository.removeFromCart(ad.id);
      final items = states.items.map((e) => e).toList();
      items.removeWhere((e) => e.id == ad.id);
      updateState((state) => state.copyWith(items: items));
    } catch (e) {
      stateMessageManager.showErrorSnackBar(e.toString());
    }
  }

  Future<void> changeFavorite(Ad ad) async {
    try {
      if (!ad.isFavorite) {
        await _favoriteRepository.removeFromFavorite(ad.id);
      } else {
        await _favoriteRepository.addToFavorite(ad);
      }
      final items = states.items.map((e) => e.copy()).toList();
      final index = items.indexWhere((e) => e.id == ad.id);
      final newAd = ad..isFavorite = !ad.isFavorite;
      items.removeWhere((e) => e.id == ad.id);
      items.insert(index, newAd);

      updateState((state) => state.copyWith(items: items));
    } catch (e) {
      stateMessageManager.showErrorSnackBar(e.toString());
    }
  }
}
