import '../model/ad.dart';

abstract class CartRepository {
  Future<void> addCart(Ad adModel);

  Future<void> removeCart(int adId);

  Future<List<Ad>> getCartAds();

  Future<void> orderCreate(
      {required int productId,
      required int amount,
      required int paymentTypeId,
      required int tin});
}
