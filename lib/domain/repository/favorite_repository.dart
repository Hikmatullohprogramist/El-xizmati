import 'package:onlinebozor/domain/model/ad.dart';

abstract class FavoriteRepository {
  Future<void> addFavorite(Ad adModel);

  Future<void> removeFavorite(int adId);

  Future<List<Ad>> getFavoriteAds();

  Future<void> pushAllFavoriteAds();
}
