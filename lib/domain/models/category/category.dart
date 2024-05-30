class Category {
  int id;
  String name;
  String? keyWord;
  int? parentId;
  String? icon;
  String? type;
  int? adCount;

  Category({
    required this.id,
    required this.name,
    this.keyWord,
    this.parentId,
    this.icon,
    this.type,
    this.adCount,
  });

  bool get isParent => parentId != null;

  bool get isNotParent => parentId == null;

  bool get hasAdCount => adCount != null && adCount! > 0;
}
