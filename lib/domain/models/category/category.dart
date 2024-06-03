import 'package:onlinebozor/domain/models/category/category_type.dart';

class Category {
  int id;
  String name;
  String? keyWord;
  int? parentId;
  String? icon;
  CategoryType type;
  int? adCount;

  Category({
    required this.id,
    required this.name,
    this.keyWord,
    this.parentId,
    this.icon,
    this.type = CategoryType.other,
    this.adCount,
  });

  bool get isParent => parentId == null || parentId! <= 0;

  bool get isNotParent => parentId == null;

  bool get hasAdCount => adCount != null && adCount! > 0;
}
