import 'package:floor/floor.dart';
import 'package:onlinebozor/data/datasource/floor/entities/user_entity.dart';

@dao
abstract class UserEntityDao {
  @Query('SELECT * FROM users LIMIT 1 ')
  Future<UserEntity?> getUser();

  // @transaction
  @Query('DELETE FROM users ')
  Future<void> clear();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertUser(UserEntity user);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateUser(UserEntity user);
}
