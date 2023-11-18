import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/domain/repository/favorite_repository.dart';

import '../../../../common/core/base_cubit.dart';
import '../../../../domain/model/ad_model.dart';
import '../../../../domain/repository/ad_repository.dart';
import '../../../../domain/repository/cart_repository.dart';

part 'cart_cubit.freezed.dart';

part 'cart_state.dart';

@injectable
class CartCubit extends BaseCubit<CartBuildable, CartListenable> {
  CartCubit(this._adRepository, this._cartRepository, this.favoriteRepository)
      : super(CartBuildable()) {
    getController();
  }

  final CartRepository _cartRepository;
  final FavoriteRepository favoriteRepository;
  final AdRepository _adRepository;
  static const _pageSize = 20;

  Future<void> getController() async {
    try {
      final controller =
          buildable.adsPagingController ?? getAdsController(status: 1);
      build((buildable) => buildable.copyWith(adsPagingController: controller));
    } catch (e, stackTrace) {
      log.e(e.toString(), error: e, stackTrace: stackTrace);
      display.error(e.toString());
    } finally {
      log.i(buildable.adsPagingController);
      // build((buildable) => buildable.copyWith(loading: false));
    }
  }

  PagingController<int, AdModel> getAdsController({
    required int status,
  }) {
    final adController = PagingController<int, AdModel>(
        firstPageKey: 1, invisibleItemsThreshold: 100);
    log.i(buildable.adsPagingController);

    adController.addPageRequestListener(
      (pageKey) async {
        final adsList = await _cartRepository.getCartAds();
        if (adsList.length <= 19) {
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

  Future<void> removeCart(AdModel adModel) async {
    try {
      await _cartRepository.removeCart(adModel.id);
      buildable.adsPagingController?.itemList?.remove(adModel);
      buildable.adsPagingController?.notifyListeners();
    } catch (e) {
      display.error(e.toString());
    }
  }

  Future<void> addFavorite(AdModel adModel) async {
    try {
      if (!adModel.favorite) {
        await favoriteRepository.addFavorite(adModel);
      } else {
        await favoriteRepository.removeFavorite(adModel.id);
      }
      final index = buildable.adsPagingController?.itemList?.indexOf(adModel);
      if (index != null) {
        display.success("update");
        final newAdModel = adModel..favorite = !adModel.favorite;
        buildable.adsPagingController?.itemList?.remove(adModel);
        buildable.adsPagingController?.itemList?.insert(index, newAdModel);
        buildable.adsPagingController?.notifyListeners();
      } else {
        display.success(" not update");
      }
      display.success("success");
    } on DioException catch (e) {
      display.error(e.toString());
      // if (e.response?.statusCode == 401 || e.response?.statusCode == 404) {
      //   invoke(DashboardListenable(DashboardEffect.navigationToAuthStart));
      // } else {
      //   display.error(e.toString());
      // }
    }
  }
}
