class ExpandableListItem {
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

  ExpandableListItem copy() {
    return ExpandableListItem(
      item: item,
      id: id,
      parentId: parentId,
      name: name,
      isParent: isParent,
      totalChildCount: totalChildCount,
      selectedChildCount: selectedChildCount,
      isSelected: isSelected,
      isVisible: isVisible,
      isOpened: isOpened,
    );
  }

  bool get isChild => !isParent;
}
