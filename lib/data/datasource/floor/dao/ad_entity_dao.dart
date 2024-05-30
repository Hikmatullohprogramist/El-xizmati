import 'package:floor/floor.dart';
import 'package:onlinebozor/data/datasource/floor/entities/ad_entity.dart';

@dao
abstract class AdEntityDao {
  @Query('SELECT * FROM ads ')
  Future<List<AdEntity>> getAllAds();

  @Query('SELECT * FROM ads WHERE ad_is_added_to_cart == 1')
  Future<List<AdEntity>> getCartAds();

  @Query('SELECT * FROM ads WHERE ad_is_favorite == 1')
  Future<List<AdEntity>> getFavoriteAds();

  @Query('SELECT COUNT(*) FROM ads WHERE ad_is_added_to_cart == 1 ')
  Future<int?> getCartAdsCount();

  @Query('SELECT COUNT(*) FROM ads WHERE ad_is_favorite == 1 ')
  Future<int?> getFavoriteAdsCount();

  @Query('SELECT * FROM ads WHERE ad_id = :id')
  Future<AdEntity?> getAdById(int id);

  @Query('UPDATE ads SET ad_is_added_to_cart = 1, ad_backend_id = :backendId WHERE ad_id = :id')
  Future<void> addToCart(int id, int backendId);

  @Query('UPDATE ads SET ad_is_added_to_cart = 0 WHERE ad_id = :id')
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
  Future<void> upsert(AdEntity ad) async {
    final int id = await insertAd(ad);
    if (id == -1) {
      await updateAd(ad);
    }
  }

  @transaction
  Future<void> upsertAll(List<AdEntity> ads) async {
    for (final ad in ads) {
      await upsert(ad);
    }
  }
}
