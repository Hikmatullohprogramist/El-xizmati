class RegionItem {
  RegionItem({
    required this.id,
    required this.parentId,
    required this.name,
    this.isParent = false,
    this.isSelected = false,
    this.isVisible = false,
    this.isOpened = true,
  });

  int id;
  int parentId;
  String name;
  bool isParent;
  bool isSelected;
  bool isVisible;
  bool isOpened;
}
