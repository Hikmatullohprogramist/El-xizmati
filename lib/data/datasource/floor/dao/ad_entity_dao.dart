import 'package:floor/floor.dart';
import 'package:logger/logger.dart';
import 'package:onlinebozor/data/datasource/floor/entities/ad_entity.dart';

@dao
abstract class AdEntityDao {
  @Query('SELECT * FROM ads ')
  Future<List<AdEntity>> getAllAds();

  @Query('SELECT * FROM ads WHERE ad_is_in_cart == 1')
  Future<List<AdEntity>> getCartAds();

  @Query('SELECT * FROM ads WHERE ad_is_in_cart == 1')
  Stream<List<AdEntity>> watchCartAds();

  @Query('SELECT * FROM ads WHERE ad_is_favorite == 1')
  Future<List<AdEntity>> getFavoriteAds();

  @Query('SELECT COUNT(*) FROM ads WHERE ad_is_in_cart == 1 ')
  Future<int?> getCartAdsCount();

  @Query('SELECT COUNT(*) FROM ads WHERE ad_is_favorite == 1 ')
  Future<int?> getFavoriteAdsCount();

  @Query('SELECT * FROM ads WHERE ad_id = :id')
  Future<AdEntity?> getAdById(int id);

  @Query('SELECT * FROM ads WHERE ad_id IN (:adIds)')
  Future<List<AdEntity>> getAdsByIds(List<int> adIds);

  @Query('SELECT * FROM ads WHERE ad_id IN (:adIds)')
  Stream<List<AdEntity>> watchAdsByIds(List<int> adIds);

  @Query(
      'UPDATE ads SET ad_is_in_cart = 1, ad_backend_id = :backendId WHERE ad_id = :id')
  Future<void> addToCart(int id, int backendId);

  @Query('UPDATE ads SET ad_is_in_cart = 0 WHERE ad_id = :id')
  Future<void> removeFromCart(int id);

  @Query('UPDATE ads SET ad_is_favorite = 1 WHERE ad_id = :id')
  Future<void> addToFavorite(int id);

  @Query('UPDATE ads SET ad_is_favorite = 0 WHERE ad_id = :id')
  Future<void> removeFromFavorite(int id);

  // @transaction
  @Query('DELETE FROM ads ')
  Future<void> clear();

  @Insert(onConflict: OnConflictStrategy.ignore)
  Future<int> insertAd(AdEntity ad);

  @Insert(onConflict: OnConflictStrategy.ignore)
  Future<void> insertAds(List<AdEntity> ads);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateAd(AdEntity ad);

  @transaction
  Future<void> upsertAd(AdEntity ad) async {
    Logger().w(
        "dao => upsertAd received ad isFavorite = ${ad.isFavorite}, isInCart = ${ad.isInCart} ");
    final int id = await insertAd(ad);
    Logger().w("dao => is inserted ad = ${id >= 0}  ");
    if (id == -1) {
      final savedAd = await getAdById(ad.id);
      if (savedAd != null) {
        Logger().w(
            "dao => upsertAd saved ad isFavorite = ${ad.isFavorite}, isInCart = ${ad.isInCart} ");
        ad.isFavorite = ad.isFavorite ?? savedAd.isFavorite;
        ad.isFavorite = ad.isInCart ?? savedAd.isInCart;
        ad.backendId = ad.backendId ?? savedAd.backendId;
      }
      Logger().w(
          "dao => upsertAd mixed ad isFavorite = ${ad.isFavorite}, isInCart = ${ad.isInCart} ");
      await updateAd(ad);
    }
  }

  @transaction
  Future<void> upsertAds(List<AdEntity> ads) async {
    for (final ad in ads) {
      await upsertAd(ad);
    }
  }
}
