class RegionItem {
  RegionItem({
    required this.id,
    required this.parentId,
    required this.name,
    this.isParent = false,
    this.isSelected = false,
  });

  int id;
  int parentId;
  String name;
  bool isParent;
  bool isSelected;
}
