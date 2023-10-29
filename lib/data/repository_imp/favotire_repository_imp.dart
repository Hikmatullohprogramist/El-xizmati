import 'package:injectable/injectable.dart';
import 'package:onlinebozor/domain/model/ad_model.dart';
import 'package:onlinebozor/domain/repository/favorite_repository.dart';

@LazySingleton(as: FavoriteRepository)
class FavoriteRepositoryImp extends FavoriteRepository {
  @override
  Future<void> addFavoriteForLocal(AdModel adModel) {
    // TODO: implement addFavoriteForLocal
    throw UnimplementedError();
  }

  @override
  Future<void> deleteFavoriteForLocal(AdModel adModel) {
    // TODO: implement deleteFavoriteForLocal
    throw UnimplementedError();
  }

  @override
  Future<void> addFavorite(AdModel adModel) {
    // TODO: implement addFavorite
    throw UnimplementedError();
  }

  @override
  Future<void> deleteFavorite(int adId) {
    // TODO: implement deleteFavorite
    throw UnimplementedError();
  }

  @override
  Future<List<AdModel>> getFavoriteAds() {
    // TODO: implement getFavoriteAds
    throw UnimplementedError();
  }
}
