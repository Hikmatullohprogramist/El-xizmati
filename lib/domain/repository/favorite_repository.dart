import 'package:onlinebozor/domain/model/ad_model.dart';

abstract class FavoriteRepository {
  Future<void> addFavorite(AdModel adModel);

  Future<void> removeFavorite(int adId);

  Future<List<AdModel>> getFavoriteAds();

  Future<void> pushAllFavoriteAds();
}
