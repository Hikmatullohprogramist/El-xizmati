import 'package:floor/floor.dart';
import 'package:logger/logger.dart';
import 'package:onlinebozor/data/datasource/floor/entities/ad_entity.dart';

@dao
abstract class AdEntityDao {

  @Query('SELECT * FROM ads WHERE ad_is_in_cart == 1')
  Future<List<AdEntity>> readCartAds();

  @Query('SELECT * FROM ads WHERE ad_is_in_cart == 1')
  Stream<List<AdEntity>> watchCartAds();

  @Query('SELECT * FROM ads WHERE ad_is_favorite == 1')
  Future<List<AdEntity>> readFavoriteAds();

  @Query('SELECT * FROM ads WHERE ad_is_favorite == 1')
  Stream<List<AdEntity>> watchFavoriteAds();

  @Query('SELECT COUNT(*) FROM ads WHERE ad_is_in_cart == 1 ')
  Future<int?> readCartAdsCount();

  @Query('SELECT COUNT(*) FROM ads WHERE ad_is_in_cart == 1 ')
  Stream<int?> watchCartAdsCount();

  @Query('SELECT COUNT(*) FROM ads WHERE ad_is_favorite == 1 ')
  Future<int?> readFavoriteAdsCount();

  @Query('SELECT * FROM ads WHERE ad_id = :id')
  Future<AdEntity?> readAdById(int id);

  @Query('SELECT * FROM ads WHERE ad_id = :id')
  Stream<AdEntity?> watchAdById(int id);

  @Query('SELECT * FROM ads WHERE ad_id IN (:adIds)')
  Future<List<AdEntity>> readAdsByIds(List<int> adIds);

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
    final int id = await insertAd(ad);
    if (id <= 0) {
      final savedAd = await readAdById(ad.id);
      if (savedAd != null) {
        ad.isFavorite = ad.isFavorite ?? savedAd.isFavorite;
        ad.isFavorite = ad.isInCart ?? savedAd.isInCart;
        ad.backendId = ad.backendId ?? savedAd.backendId;
      }
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
