import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:onlinebozor/core/extensions/list_extensions.dart';
import 'package:onlinebozor/data/datasource/hive/storages/ad_storage.dart';
import 'package:onlinebozor/data/datasource/hive/storages/token_storage.dart';
import 'package:onlinebozor/data/datasource/network/responses/ad/ad/ad_response.dart';
import 'package:onlinebozor/data/datasource/network/responses/add_result/add_result_response.dart';
import 'package:onlinebozor/data/datasource/network/services/cart_service.dart';
import 'package:onlinebozor/domain/mappers/ad_mapper.dart';

import '../../domain/models/ad/ad.dart';

@LazySingleton()
class CartRepository {
  final AdStorage _adStorage;
  final CartService _cartService;
  final TokenStorage _tokenStorage;

  CartRepository(this._adStorage, this._cartService, this._tokenStorage);

  Future<int> addToCart(Ad ad) async {
    final isLogin = _tokenStorage.isUserLoggedIn;
    int resultId = ad.id;
    if (isLogin) {
      final response =
          await _cartService.addCart(adType: ad.adStatus.name, id: ad.id);
      final addResultId =
          AddResultRootResponse.fromJson(response.data).data?.products?.id;
      resultId = addResultId ?? ad.id;
    }

    _adStorage.addToCart(ad.toMap(backendId: resultId));
    return resultId;
  }

  Future<void> removeFromCart(Ad ad) async {
    final isLogin = _tokenStorage.isUserLoggedIn;
    if (isLogin) {
      await _cartService.removeCart(adId: ad.id);
    }

    _adStorage.removeFromCart(ad.id);
  }

  Future<List<Ad>> getCartAds() async {
    final logger = Logger();
    logger.w("getFavorites Ads");
    try {
      final isLogin = _tokenStorage.isUserLoggedIn;
      if (isLogin) {
        final root = await _cartService.getCartAllAds();
        final response = AdRootResponse.fromJson(root.data).data.results;
        final responseAds = response
            .map((e) => e.toMap(isAddedToCart: true))
            .toList();

        final savedAds = _adStorage.cartAds.map((e) => e.toMap()).toList();
        final notSavedAds = responseAds.notContainsItems(savedAds);
        for (var item in notSavedAds) {
          _adStorage.addToCart(item.toMap());
        }
      }
      return _adStorage.cartAds.map((e) => e.toMap()).toList();
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
