class ExpandableListItem {
  ExpandableListItem({
    required this.item,
    required this.id,
    required this.parentId,
    required this.name,
    required this.isParent,
    required this.totalChildCount,
    required this.selectedChildCount,
    required this.isSelected,
    required this.isVisible,
    required this.isOpened,
  });

  dynamic item;
  int id;
  int parentId;
  String name;
  bool isParent;
  int totalChildCount;
  int selectedChildCount;
  bool isSelected;
  bool isVisible;
  bool isOpened;
}
