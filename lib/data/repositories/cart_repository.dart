import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:onlinebozor/common/extensions/list_extensions.dart';
import 'package:onlinebozor/data/responses/add_result/add_result_response.dart';
import 'package:onlinebozor/data/services/cart_service.dart';
import 'package:onlinebozor/domain/mappers/ad_mapper.dart';

import '../../data/responses/ad/ad/ad_response.dart';
import '../../data/storages/cart_storage.dart';
import '../../data/storages/favorite_storage.dart';
import '../../data/storages/token_storage.dart';
import '../../domain/models/ad/ad.dart';

@LazySingleton()
class CartRepository {
  final CartService _cartService;
  final CartStorage cartStorage;
  final TokenStorage tokenStorage;
  final FavoriteStorage favoriteStorage;

  CartRepository(
    this._cartService,
    this.cartStorage,
    this.tokenStorage,
    this.favoriteStorage,
  );

  Future<int> addCart(Ad ad) async {
    final isLogin = tokenStorage.isUserLoggedIn;
    int resultId = ad.id;
    if (isLogin) {
      final response =
          await _cartService.addCart(adType: ad.adStatus.name, id: ad.id);
      final addResultId =
          AddResultRootResponse.fromJson(response.data).data?.products?.id;
      resultId = addResultId ?? ad.id;
    }
    final allItem = cartStorage.allItems.map((e) => e.toMap()).toList();
    if (allItem.where((element) => element.id == ad.id).isEmpty) {
      cartStorage.storage.add(ad.toMap(backendId: resultId));
    } else {
      final index = allItem.indexOf(ad);
      cartStorage.update(index, ad.toMap(backendId: resultId));
    }
    return resultId;
  }

  Future<void> removeCart(Ad ad) async {
    final isLogin = tokenStorage.isUserLoggedIn;
    if (isLogin) {
      await _cartService.removeCart(adId: ad.id);
      cartStorage.removeCart(ad.id);
    } else {
      cartStorage.removeCart(ad.id);
    }
  }

  Future<List<Ad>> getCartAds() async {
    final logger = Logger();
    logger.w("getFavorites Ads");
    try {
      final isLogin = tokenStorage.isUserLoggedIn;
      if (isLogin) {
        final root = await _cartService.getCartAllAds();
        final response = AdRootResponse.fromJson(root.data).data.results;
        final cartAds = response
            .map((e) => e.toMap(isFavorite: false, isAddedToCart: true))
            .toList();

        final allItems = cartStorage.allItems.map((e) => e.toMap()).toList();
        final newItems = cartAds.notContainsItems(allItems);
        for (var item in newItems) {
          cartStorage.storage.add(item.toMap(isFavorite: true));
        }
      }
      final fAds = favoriteStorage.allItems;
      final cAds = cartStorage.allItems;
      return cAds
          .map((c) => c.toMap(isFavorite: fAds.containsIf((f) => c.id == f.id)))
          .toList();
    } catch (e) {
      logger.e(e.toString());
      return List.empty();
    }
  }

  Future<void> orderCreate({
    required int productId,
    required int amount,
    required int paymentTypeId,
    required int tin,
    required int? servicePrice,
  }) async {
    _cartService.orderCreate(
      productId: productId,
      amount: amount,
      paymentTypeId: paymentTypeId,
      tin: tin,
      servicePrice: servicePrice,
    );
    return;
  }

  Future<void> removeOrder({required int tin}) async {
    _cartService.removeOrder(tin: tin);
    return;
  }
}
