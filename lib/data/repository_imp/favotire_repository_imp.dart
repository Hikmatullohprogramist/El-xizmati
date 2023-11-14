import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/api/favorite_api.dart';
import 'package:onlinebozor/domain/model/ad_model.dart';
import 'package:onlinebozor/domain/repository/favorite_repository.dart';

import '../storage/token_storage.dart';

@LazySingleton(as: FavoriteRepository)
class FavoriteRepositoryImp extends FavoriteRepository {
  final FavoriteApi _api;
  final TokenStorage tokenStorage;

  FavoriteRepositoryImp(this._api, this.tokenStorage);

  @override
  Future<void> addFavorite(AdModel adModel) async {
    final isLogin = tokenStorage.isLogin.call() ?? false;
    // if (isLogin) {
      await _api.addFavorite(adType: adModel.adStatusType.name, id: adModel.id);
    // } else {
    //     add local storage;
    // }
    return;
  }

  @override
  Future<void> deleteFavorite(int adId) async {
    final isLogin = tokenStorage.isLogin.call() ?? false;
    if (isLogin) {
      await _api.deleteFavorite();
    } else {}
  }

  @override
  Future<List<AdModel>> getFavoriteAds() async {
    final isLogin = tokenStorage.isLogin.call() ?? false;
    if (isLogin) {
      return List.empty();
    } else {
      return List.empty();
    }
  }
}
