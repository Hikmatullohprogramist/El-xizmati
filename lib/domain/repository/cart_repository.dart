import '../model/ad_model.dart';

abstract class CartRepository {
  Future<void> addCart(AdModel adModel);

  Future<void> removeCart(int adId);

  Future<List<AdModel>> getCartAds();
}
