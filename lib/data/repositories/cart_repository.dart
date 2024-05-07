import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:onlinebozor/core/extensions/list_extensions.dart';
import 'package:onlinebozor/data/datasource/hive/storages/cart_storage.dart';
import 'package:onlinebozor/data/datasource/hive/storages/favorite_storage.dart';
import 'package:onlinebozor/data/datasource/hive/storages/token_storage.dart';
import 'package:onlinebozor/data/datasource/network/responses/ad/ad/ad_response.dart';
import 'package:onlinebozor/data/datasource/network/responses/add_result/add_result_response.dart';
import 'package:onlinebozor/data/datasource/network/services/cart_service.dart';
import 'package:onlinebozor/domain/mappers/ad_mapper.dart';

import '../../domain/models/ad/ad.dart';

@LazySingleton()
class CartRepository {
  final CartService _cartService;
  final CartStorage _cartStorage;
  final FavoriteStorage _favoriteStorage;
  final TokenStorage _tokenStorage;

  CartRepository(
    this._cartService,
    this._cartStorage,
    this._tokenStorage,
    this._favoriteStorage,
  );

  Future<int> addCart(Ad ad) async {
    final isLogin = _tokenStorage.isUserLoggedIn;
    int resultId = ad.id;
    if (isLogin) {
      final response =
          await _cartService.addCart(adType: ad.adStatus.name, id: ad.id);
      final addResultId =
          AddResultRootResponse.fromJson(response.data).data?.products?.id;
      resultId = addResultId ?? ad.id;
    }
    final allItem = _cartStorage.allItems.map((e) => e.toMap()).toList();
    if (allItem.where((element) => element.id == ad.id).isEmpty) {
      _cartStorage.storage.add(ad.toMap(backendId: resultId));
    } else {
      final index = allItem.indexOf(ad);
      _cartStorage.update(index, ad.toMap(backendId: resultId));
    }
    return resultId;
  }

  Future<void> removeCart(Ad ad) async {
    final isLogin = _tokenStorage.isUserLoggedIn;
    if (isLogin) {
      await _cartService.removeCart(adId: ad.id);
      _cartStorage.removeCart(ad.id);
    } else {
      _cartStorage.removeCart(ad.id);
    }
  }

  Future<List<Ad>> getCartAds() async {
    final logger = Logger();
    logger.w("getFavorites Ads");
    try {
      final isLogin = _tokenStorage.isUserLoggedIn;
      if (isLogin) {
        final root = await _cartService.getCartAllAds();
        final response = AdRootResponse.fromJson(root.data).data.results;
        final cartAds = response
            .map((e) => e.toMap(isFavorite: false, isAddedToCart: true))
            .toList();

        final allItems = _cartStorage.allItems.map((e) => e.toMap()).toList();
        final newItems = cartAds.notContainsItems(allItems);
        for (var item in newItems) {
          _cartStorage.storage.add(item.toMap(isFavorite: true));
        }
      }
      final fAds = _favoriteStorage.allItems;
      final cAds = _cartStorage.allItems;
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
