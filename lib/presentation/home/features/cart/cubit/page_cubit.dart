import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/enum/enums.dart';

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
    getItems();
  }

  final CartRepository repository;
  final FavoriteRepository favoriteRepository;

  Future<void> getItems() async {
    updateState((state) => state.copyWith(loadState: LoadingState.loading));
    try {
      final ads = await repository.getCartAds();
      updateState((state) => state.copyWith(
            items: ads,
            loadState: ads.isEmpty ? LoadingState.empty : LoadingState.success,
          ));
    } catch (e) {
      log.w("getCartProducts error = $e");
      updateState((state) => state.copyWith(loadState: LoadingState.error));
    }
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
