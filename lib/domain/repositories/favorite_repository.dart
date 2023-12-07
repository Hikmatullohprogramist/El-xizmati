import '../models/ad.dart';

abstract class FavoriteRepository {
  Future<void> addFavorite(Ad ad);

  Future<void> removeFavorite(Ad ad);

  Future<List<Ad>> getFavoriteAds();

  Future<void> pushAllFavoriteAds();
}
