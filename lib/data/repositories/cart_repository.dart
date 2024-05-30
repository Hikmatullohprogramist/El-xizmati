import 'package:onlinebozor/data/datasource/floor/dao/ad_entity_dao.dart';
import 'package:onlinebozor/data/datasource/floor/dao/user_entity_dao.dart';
import 'package:onlinebozor/data/datasource/network/responses/ad/ad/ad_response.dart';
import 'package:onlinebozor/data/datasource/network/responses/add_result/add_result_response.dart';
import 'package:onlinebozor/data/datasource/network/services/cart_service.dart';
import 'package:onlinebozor/data/datasource/preference/token_preferences.dart';
import 'package:onlinebozor/data/datasource/preference/user_preferences.dart';
import 'package:onlinebozor/data/error/app_locale_exception.dart';
import 'package:onlinebozor/domain/mappers/ad_mapper.dart';
import 'package:onlinebozor/domain/models/ad/ad.dart';

// @LazySingleton()
class CartRepository {
  final AdEntityDao _adEntityDao;
  final CartService _cartService;
  final TokenPreferences _tokenPreferences;
  final UserPreferences _userPreferences;
  final UserEntityDao _userEntityDao;

  CartRepository(
    this._adEntityDao,
    this._cartService,
    this._tokenPreferences,
    this._userEntityDao,
    this._userPreferences,
  );

  Future<int> addToCart(Ad ad) async {
    final isLogin = _tokenPreferences.isAuthorized;
    int resultId = ad.id;
    if (isLogin) {
      final response =
          await _cartService.addCart(adType: ad.priorityLevel.name, id: ad.id);
      final addResultId =
          AddResultRootResponse.fromJson(response.data).data?.products?.id;
      resultId = addResultId ?? ad.id;
    }

    await _adEntityDao.addToCart(ad.id, resultId);
    return resultId;
  }

  Future<void> removeFromCart(int adId) async {
    final isLogin = _tokenPreferences.isAuthorized;
    if (isLogin) {
      await _cartService.removeCart(adId: adId);
    }

    await _adEntityDao.removeFromCart(adId);
  }

  Future<List<Ad>> getCartAds() async {
    final isLogin = _tokenPreferences.isAuthorized;
    if (isLogin) {
      final root = await _cartService.getCartAllAds();
      final ads = AdRootResponse.fromJson(root.data).data.results;
      _adEntityDao.insertAds(ads.map((e) => e.toAdEntity()).toList());
    }
    final entities = await _adEntityDao.getCartAds();
    return entities.map((e) => e.toAd()).toList();
  }

  Future<void> orderCreate({
    required int adId,
    required int amount,
    required int paymentTypeId,
    required int tin,
    required int? servicePrice,
  }) async {
    if (_tokenPreferences.isNotAuthorized) throw NotAuthorizedException();
    if (_userPreferences.isNotIdentified) throw NotIdentifiedException();

    var user = await _userEntityDao.getUser();
    var neighborhoodId = user?.neighborhoodId ?? 0;

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
