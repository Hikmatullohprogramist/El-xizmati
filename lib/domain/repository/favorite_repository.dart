import 'package:onlinebozor/domain/model/ad_model.dart';

abstract class FavoriteRepository {
  Future<void> addFavoriteForLocal(AdModel adModel);

  Future<void> deleteFavoriteForLocal(AdModel adModel);

  Future<void> addFavorite(AdModel adModel);

  Future<void> deleteFavorite(int adId);

  Future<List<AdModel>> getFavoriteAds();
}
