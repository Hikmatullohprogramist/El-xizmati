import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:onlinebozor/domain/mappers/ad_enum_mapper.dart';
import 'package:onlinebozor/domain/mappers/ad_mapper.dart';
import 'package:onlinebozor/domain/repositories/favorite_repository.dart';

import '../../domain/models/ad.dart';
import '../hive_objects/ad/ad_object.dart';
import '../responses/ad/ad/ad_response.dart';
import '../services/favorite_service.dart';
import '../storages/favorite_storage.dart';
import '../storages/sync_storage.dart';
import '../storages/token_storage.dart';

@LazySingleton(as: FavoriteRepository)
class FavoriteRepositoryImp extends FavoriteRepository {
  final FavoriteService _favoriteService;
  final TokenStorage tokenStorage;
  final FavoriteStorage favoriteStorage;
  final SyncStorage syncStorage;

  FavoriteRepositoryImp(
    this._favoriteService,
    this.tokenStorage,
    this.favoriteStorage,
    this.syncStorage,
  );

  @override
  Future<void> addFavorite(Ad ad) async {
    final isLogin = tokenStorage.isLogin.call() ?? false;
    if (isLogin) {
      await _favoriteService.addFavorite(
          adType: ad.adStatusType.name, id: ad.id);
    } else {
      await syncStorage.isFavoriteSync.set(false);
    }
    final allItem = favoriteStorage.allItems.map((e) => e.toMap()).toList();
    if (allItem.where((element) => element.id == ad.id).isEmpty) {
      favoriteStorage.favoriteAds.add(AdObject(
          id: ad.id,
          name: ad.name,
          price: ad.price,
          currency: ad.currency.currencyToString(),
          region: ad.region,
          district: ad.district,
          adRouteType: ad.adRouteType.adRouteTypeToString(),
          adPropertyStatus: ad.adPropertyStatus.adPropertyStatusToString(),
          adStatusType: ad.adStatusType.adStatusTypeToString(),
          adTypeStatus: ad.adTypeStatus.adTypeStatusToString(),
          fromPrice: ad.fromPrice,
          toPrice: ad.toPrice,
          categoryId: ad.categoryId,
          categoryName: ad.categoryName,
          isSort: ad.isSort,
          isSell: ad.isSell,
          isCheck: ad.isCheck,
          sellerId: ad.sellerId,
          maxAmount: ad.maxAmount,
          favorite: true,
          photo: ad.photo,
          sellerName: ad.sellerName,
          backendId: ad.backendId));
    }
    return;
  }

  @override
  Future<void> removeFavorite(Ad ad) async {
    favoriteStorage.removeFavorite(ad.id);
    final isLogin = tokenStorage.isLogin.call() ?? false;
    if (isLogin) {
      await _favoriteService.deleteFavorite(ad.backendId ?? ad.id);
    } else {
      await syncStorage.isFavoriteSync.set(false);
    }
  }

  @override
  Future<List<Ad>> getFavoriteAds() async {
    try {
      final isLogin = tokenStorage.isLogin.call() ?? false;
      if (isLogin) {
        final response = await _favoriteService.getFavoriteAds();
        final allRemoteAds = AdRootResponse.fromJson(response.data)
            .data
            .results
            .map((e) => e.toMap(favorite: true));
        final allItem = favoriteStorage.allItems.map((e) => e.toMap()).toList();
        for (var item in allRemoteAds) {
          if (allItem.where((element) => element.id == item.id).isEmpty) {
            favoriteStorage.favoriteAds.add(AdObject(
                id: item.id,
                name: item.name,
                price: item.price,
                currency: item.currency.currencyToString(),
                region: item.region,
                district: item.district,
                adRouteType: item.adRouteType.adRouteTypeToString(),
                adPropertyStatus:
                    item.adPropertyStatus.adPropertyStatusToString(),
                adStatusType: item.adStatusType.adStatusTypeToString(),
                adTypeStatus: item.adTypeStatus.adTypeStatusToString(),
                fromPrice: item.fromPrice,
                toPrice: item.toPrice,
                categoryId: item.categoryId,
                categoryName: item.categoryName,
                isSort: item.isSort,
                isSell: item.isSell,
                isCheck: item.isCheck,
                sellerId: item.sellerId,
                maxAmount: item.maxAmount,
                favorite: true,
                photo: item.photo,
                sellerName: item.sellerName,
                backendId: item.backendId));
          }
        }
      }
      final result = favoriteStorage.allItems;
      return result.map((e) => e.toMap(favorite: true)).toList();
    } catch (e) {
      return List.empty();
    }
  }

  @override
  Future<void> pushAllFavoriteAds() async {
    try {
      final log = Logger();
      final allItem = favoriteStorage.allItems.map((e) => e.toMap()).toList();
      log.e(allItem.toString());
      await _favoriteService.sendAllFavoriteAds(allItem);
      await syncStorage.isFavoriteSync.set(true);
    } catch (e) {
      rethrow;
    }
  }
}
