import '../models/ad.dart';

abstract class CartRepository {
  Future<void> addCart(Ad ad);

  Future<void> removeCart(Ad ad);

  Future<List<Ad>> getCartAds();

  Future<void> orderCreate(
      {required int productId,
      required int amount,
      required int paymentTypeId,
      required int tin});
}
