class Category {
  Category(
    this.id,
    this.name,
    this.key_word,
    this.parent_id,
    this.icon,
    this.icon_home,
    this.is_home,
    this.type,
  );

  int id;
  String? name;
  String? key_word;
  int? parent_id;
  dynamic icon;
  dynamic icon_home;
  bool? is_home;
  String? type;
}
