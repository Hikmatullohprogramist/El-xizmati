import 'package:hive/hive.dart';

part 'category_hive_object.g.dart';

@HiveType(typeId: 1)
class CategoryHiveObject {
  CategoryHiveObject({
    required this.id,
    this.name,
    this.icon,
    this.key,
    this.keyWord,
    this.parentId,
    this.iconHome,
    this.isHome,
    this.type,
  });

  @HiveField(1)
  int id;

  @HiveField(2)
  String? name;

  @HiveField(3)
  String? icon;

  @HiveField(4)
  String? key;

  @HiveField(5)
  String? keyWord;

  @HiveField(6)
  int? parentId;

  @HiveField(7)
  String? iconHome;

  @HiveField(8)
  bool? isHome;

  @HiveField(9)
  String? type;
}
