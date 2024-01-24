import '../models/ad/ad.dart';

abstract class FavoriteRepository {
  Future<int> addFavorite(Ad ad);

  Future<void> removeFavorite(Ad ad);

  Future<List<Ad>> getProductFavoriteAds();

  Future<List<Ad>> getServiceFavoriteAds();

  Future<void> pushAllFavoriteAds();
}
