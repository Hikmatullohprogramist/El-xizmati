import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/core/enum/enums.dart';
import 'package:onlinebozor/data/repositories/region_repository.dart';
import 'package:onlinebozor/domain/mappers/item_mapper.dart';
import 'package:onlinebozor/domain/models/district/district.dart';
import 'package:onlinebozor/domain/models/list/expandable_list_item.dart';
import 'package:onlinebozor/presentation/support/cubit/base_cubit.dart';

part 'region_selection_cubit.freezed.dart';
part 'region_selection_state.dart';

@Injectable()
class RegionSelectionCubit
    extends BaseCubit<RegionSelectionState, RegionSelectionEvent> {
  RegionSelectionCubit(
    this._regionRepository,
  ) : super(const RegionSelectionState()) {
    getRegionAndDistricts();
  }

  final RegionRepository _regionRepository;

  void setInitialParams(List<District>? districts) {
    try {
      if (districts != null) {
        List<ExpandableListItem> initialSelectedItems = districts
            .map((e) =>
                e.toExpandableListItem(isSelected: false, isVisible: false))
            .toList();

        updateState(
          (state) => state.copyWith(initialSelectedItems: initialSelectedItems),
        );
      }
    } catch (e) {
      logger.e(e.toString());
    }
  }

  Future<void> getRegionAndDistricts() async {
    try {
      final response = await _regionRepository.getRegionAndDistricts();
      var allRegions = response.regions;
      var allDistricts = response.districts;
      List<ExpandableListItem> allItems = [];

      var items = states.initialSelectedItems;
      for (var region in allRegions) {
        var regionDistricts = allDistricts
            .where((d) => d.regionId == region.id)
            .map(
              (d) => d.toExpandableListItem(
                isSelected: items.firstWhereOrNull((e) => e.id == d.id) != null,
              ),
            );

        var selectedCount = regionDistricts.where((e) => e.isSelected).length;
        var totalChildCount = regionDistricts.length;
        allItems.add(region.toExpandableListItem(
          isSelected: selectedCount == totalChildCount,
          isVisible: true,
          childCount: totalChildCount,
          selectedChildCount: selectedCount,
        ));

        allItems.addAll(regionDistricts);
      }

      updateState((state) => state.copyWith(
            loadState: LoadingState.success,
            allItems: allItems,
            visibleItems: allItems.where((e) => e.isVisible).toList(),
          ));
    } catch (exception) {
      logger.e(exception.toString());
      updateState((state) => state.copyWith(loadState: LoadingState.error));
    }
  }

  void updateSelectedState(ExpandableListItem item) {
    try {
      var allItems = states.allItems.map((e) => e.copy()).toList();
      bool state = !item.isSelected;
      if (item.isParent) {
        allItems
            .where((e) => e.parentId == item.id || e.id == item.id)
            .forEach((child) => child.isSelected = state);

        int selectedChildCount =
            allItems.where((e) => e.parentId == item.id && e.isSelected).length;

        int totalChildCount =
            allItems.where((e) => e.parentId == item.id).length;

        allItems.firstWhereOrNull((e) => e.id == item.id)?.isSelected =
            totalChildCount == selectedChildCount;

        allItems
            .firstWhereOrNull((e) => e.id == item.parentId)
            ?.selectedChildCount = selectedChildCount;
      } else {
        allItems
            .firstWhereOrNull((element) => element.id == item.id)
            ?.isSelected = state;

        int selectedChildCount = allItems
            .where((e) => e.parentId == item.parentId && e.isSelected)
            .length;

        int totalChildCount =
            allItems.where((e) => e.parentId == item.parentId).length;

        allItems.firstWhereOrNull((e) => e.id == item.parentId)?.isSelected =
            totalChildCount == selectedChildCount;

        allItems
            .firstWhereOrNull((e) => e.id == item.parentId)
            ?.selectedChildCount = selectedChildCount;
      }

      updateState((state) => state.copyWith(
            allItems: allItems,
            visibleItems: allItems.where((e) => e.isVisible).toList(),
          ));
    } catch (e) {
      logger.e("update-selected-state ERROR = ${e.toString()}");
    }
  }

  void openOrClose(ExpandableListItem regionItem) {
    var allItems = states.allItems;

    allItems.where((e) => e.parentId == regionItem.id).forEach((e) {
      e.isVisible = !e.isVisible;
    });
    allItems.firstWhere((e) => e.id == regionItem.id).isOpened =
        !regionItem.isOpened;

    updateState(
      (state) => state.copyWith(
        allItems: allItems,
        visibleItems: allItems.where((e) => e.isVisible).toList(),
      ),
    );
  }
}
