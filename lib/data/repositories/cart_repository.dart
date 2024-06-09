import 'package:onlinebozor/data/datasource/floor/dao/ad_entity_dao.dart';
import 'package:onlinebozor/data/datasource/network/responses/ad/ad/ad_response.dart';
import 'package:onlinebozor/data/datasource/network/responses/add_result/add_result_response.dart';
import 'package:onlinebozor/data/datasource/network/services/cart_service.dart';
import 'package:onlinebozor/data/datasource/preference/auth_preferences.dart';
import 'package:onlinebozor/domain/mappers/ad_mapper.dart';
import 'package:onlinebozor/domain/models/ad/ad.dart';

class CartRepository {
  final AdEntityDao _adEntityDao;
  final CartService _cartService;
  final AuthPreferences _tokenPreferences;

  CartRepository(
    this._adEntityDao,
    this._cartService,
    this._tokenPreferences,
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
    final entities = await _adEntityDao.readCartAds();
    return entities.map((e) => e.toAd()).toList();
  }

  Stream<List<Ad>> watchCartAds() {
    return _adEntityDao
        .watchCartAds()
        .asyncMap((event) => event.map((e) => e.toAd()).toList());
  }

  Future<void> removeOrder({required int tin}) async {
    _cartService.removeOrder(tin: tin);
    return;
  }
}
