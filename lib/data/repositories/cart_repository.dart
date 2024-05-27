import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:onlinebozor/core/extensions/list_extensions.dart';
import 'package:onlinebozor/data/datasource/hive/storages/ad_storage.dart';
import 'package:onlinebozor/data/datasource/hive/storages/token_storage.dart';
import 'package:onlinebozor/data/datasource/network/responses/ad/ad/ad_response.dart';
import 'package:onlinebozor/data/datasource/network/responses/add_result/add_result_response.dart';
import 'package:onlinebozor/data/datasource/network/services/cart_service.dart';
import 'package:onlinebozor/data/error/app_locale_exception.dart';
import 'package:onlinebozor/data/repositories/state_repository.dart';
import 'package:onlinebozor/data/repositories/user_repository.dart';
import 'package:onlinebozor/domain/mappers/ad_mapper.dart';

import '../../domain/models/ad/ad.dart';

@LazySingleton()
class CartRepository {
  CartRepository(
    this._adStorage,
    this._cartService,
    this._tokenStorage,
    this._stateRepository,
    this._userRepository,
  );

  final AdStorage _adStorage;
  final CartService _cartService;
  final TokenStorage _tokenStorage;
  final StateRepository _stateRepository;
  final UserRepository _userRepository;

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

  Future<void> removeFromCart(int adId) async {
    final isLogin = _tokenStorage.isUserLoggedIn;
    if (isLogin) {
      await _cartService.removeCart(adId: adId);
    }

    _adStorage.removeFromCart(adId);
  }

  Future<List<Ad>> getCartAds() async {
    final logger = Logger();
    logger.w("getFavorites Ads");
    try {
      final isLogin = _tokenStorage.isUserLoggedIn;
      if (isLogin) {
        final root = await _cartService.getCartAllAds();
        final response = AdRootResponse.fromJson(root.data).data.results;
        final responseAds =
            response.map((e) => e.toMap(isAddedToCart: true)).toList();

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
    required int adId,
    required int amount,
    required int paymentTypeId,
    required int tin,
    required int? servicePrice,
  }) async {
    if (_stateRepository.isNotAuthorized()) throw NotAuthorizedException();
    if (_userRepository.isNotIdentified()) throw NotIdentifiedException();

    var neighborhoodId = _userRepository.getSavedUser()?.neighborhoodId ?? 0;

    await _cartService.orderCreate(
      productId: adId,
      amount: amount,
      paymentTypeId: paymentTypeId,
      tin: tin,
      neighborhoodId: neighborhoodId,
      servicePrice: servicePrice,
    );

    await removeOrder(tin: tin);
    await removeFromCart(adId);
  }

  Future<void> removeOrder({required int tin}) async {
    _cartService.removeOrder(tin: tin);
    return;
  }
}
