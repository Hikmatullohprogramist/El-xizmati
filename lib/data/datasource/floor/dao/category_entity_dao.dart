import 'package:floor/floor.dart';
import 'package:El_xizmati/data/datasource/floor/entities/category_entity.dart';

@dao
abstract class CategoryEntityDao {
  @Query('SELECT * FROM categories ')
  Future<List<CategoryEntity>> getCategories();

  @Query('SELECT * FROM categories WHERE category_type = :type ')
  Future<List<CategoryEntity>> getCategoriesByType(String type);

  @Query('SELECT COUNT(*) FROM categories ')
  Future<int?> getCategoriesCount();

  @Query('SELECT COUNT(*) FROM categories WHERE category_type = :type ')
  Future<int?> getCategoriesCountByType(String type);

  // @transaction
  @Query('DELETE FROM categories ')
  Future<void> clear();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> insertCategory(CategoryEntity category);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertCategories(List<CategoryEntity> category);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateCategory(CategoryEntity category);

  @transaction
  Future<void> upsert(CategoryEntity category) async {
    final int id = await insertCategory(category);
    if (id <= 0) {
      await updateCategory(category);
    }
  }

  @transaction
  Future<void> upsertAll(List<CategoryEntity> categories) async {
    for (final category in categories) {
      await upsert(category);
    }
  }
}
