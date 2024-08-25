import 'package:El_xizmati/domain/models/district/district.dart';
import 'package:El_xizmati/domain/models/list/expandable_list_item.dart';
import 'package:El_xizmati/domain/models/region/region.dart';

extension RegionExts on Region {
  ExpandableListItem toExpandableListItem({
    bool isSelected = false,
    bool isVisible = false,
    int childCount = 0,
    int selectedChildCount = 0,
  }) {
    return ExpandableListItem(
        item: this,
        id: id,
        parentId: 0,
        name: name,
        isParent: true,
        isSelected: isSelected,
        totalChildCount: childCount,
        selectedChildCount: selectedChildCount,
        isVisible: isVisible,
        isOpened: false);
  }
}

extension DistrictExts on District {
  ExpandableListItem toExpandableListItem({
    bool isSelected = false,
    bool isVisible = false,
  }) {
    return ExpandableListItem(
      item: this,
      id: id,
      parentId: regionId,
      name: name,
      isParent: false,
      totalChildCount: 0,
      selectedChildCount: 0,
      isSelected: isSelected,
      isVisible: isVisible,
      isOpened: false,
    );
  }
}
