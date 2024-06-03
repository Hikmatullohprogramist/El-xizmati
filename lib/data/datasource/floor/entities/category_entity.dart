import 'package:floor/floor.dart';

@Entity(tableName: "categories")
class CategoryEntity {
  @primaryKey
  @ColumnInfo(name: "category_id")
  int id;

  @ColumnInfo(name: "category_name")
  String name;

  @ColumnInfo(name: "category_parent_id")
  int? parentId;

  @ColumnInfo(name: "category_key_word")
  String? keyWord;

  @ColumnInfo(name: "category_icon")
  String? icon;

  @ColumnInfo(name: "category_type")
  String? type; // product, service, popular, catalog

  @ColumnInfo(name: "category_ad_count")
  int? adCount;

  CategoryEntity({
    required this.id,
    required this.name,
    required this.parentId,
    required this.keyWord,
    required this.icon,
    required this.type,
    required this.adCount,
  });
}
