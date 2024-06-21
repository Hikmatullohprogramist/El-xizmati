import 'package:floor/floor.dart';
import 'package:onlinebozor/data/datasource/floor/entities/user_address_entity.dart';

@dao
abstract class UserAddressEntityDao {
  @Query('SELECT * FROM user_addresses ORDER BY user_address_is_main DESC ')
  Future<List<UserAddressEntity>> readAddresses();

  @Query('SELECT * FROM user_addresses WHERE user_address_id = :id ')
  Future<UserAddressEntity?> readAddressById(int id);

  @Query('SELECT * FROM user_addresses WHERE user_address_is_main = TRUE ')
  Future<UserAddressEntity?> readMainAddress();

  @Query('SELECT COUNT(*) FROM user_addresses ')
  Future<int?> readAddressesCount();

  @Query('DELETE FROM user_addresses WHERE user_address_id = :id ')
  Future<void> deleteAddressById(int id);

  @Query('UPDATE user_addresses SET user_address_is_main = CASE WHEN user_address_id = :id THEN TRUE ELSE FALSE END ')
  Future<void> updateMainAddressById(int id);

  @Query('DELETE FROM user_addresses')
  Future<void> clear();

  @Insert(onConflict: OnConflictStrategy.ignore)
  Future<int> insertAddress(UserAddressEntity address);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateAddress(UserAddressEntity address);

  @transaction
  Future<void> upsert(UserAddressEntity address) async {
    final int id = await insertAddress(address);
    if (id <= 0) {
      await updateAddress(address);
    }
  }

  @transaction
  Future<void> upsertAll(List<UserAddressEntity> addresses) async {
    for (final address in addresses) {
      await upsert(address);
    }
  }

  @delete
  Future<void> deleteAddress(UserAddressEntity address);
}
