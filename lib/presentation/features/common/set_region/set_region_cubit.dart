import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/core/enum/enums.dart';
import 'package:onlinebozor/core/extensions/list_extensions.dart';
import 'package:onlinebozor/data/repositories/region_repository.dart';
import 'package:onlinebozor/domain/mappers/item_mapper.dart';
import 'package:onlinebozor/domain/models/district/district.dart';
import 'package:onlinebozor/domain/models/list/expandable_list_item.dart';
import 'package:onlinebozor/presentation/stream_controllers/selected_region_stream_controller.dart';
import 'package:onlinebozor/presentation/support/cubit/base_cubit.dart';

part 'set_region_cubit.freezed.dart';

part 'set_region_state.dart';

@Injectable()
class SetRegionCubit extends BaseCubit<SetRegionState, SetRegionEvent> {
  final RegionRepository _regionRepository;
  final SelectedRegionStreamController _selectedRegionStreamController;

  SetRegionCubit(
    this._regionRepository,
    this._selectedRegionStreamController,
  ) : super(const SetRegionState()) {
    getSelectedRegion();
    getRegionAndDistricts();
  }

  void setInitialParams(List<District>? districts) {
    try {
      if (districts != null) {
        List<ExpandableListItem> initialSelectedItems = districts
            .map((e) =>
                e.toExpandableListItem(isSelected: false, isVisible: false))
            .toList();

        updateState((state) => state.copyWith(
              initialSelectedItems: initialSelectedItems,
            ));
      }
    } catch (e) {
      logger.e(e.toString());
    }
  }

  void getSelectedRegion() {
    final regionId = _regionRepository.getSelectedRegionId();
    final districtId = _regionRepository.getSelectedDistrictId();

    updateState((state) => state.copyWith(
          regionId: regionId,
          districtId: districtId,
        ));
  }

  Future<void> getRegionAndDistricts() async {
    try {
      final response = await _regionRepository.getRegionAndDistricts();
      var allRegions = response.regions;
      var allDistricts = response.districts;
      List<ExpandableListItem> allItems = [];

      for (var region in allRegions) {
        var regionDistricts =
            allDistricts.where((d) => d.regionId == region.id).map(
                  (d) => d.toExpandableListItem(
                      isSelected: d.id == states.districtId)
                    ..isVisible = region.id == states.regionId,
                );

        var selectedCount = regionDistricts.where((e) => e.isSelected).length;
        var totalChildCount = regionDistricts.length;
        allItems.add(
          region.toExpandableListItem(
            isSelected: selectedCount == totalChildCount,
            isVisible: true,
            childCount: totalChildCount,
            selectedChildCount: selectedCount,
          )..isOpened = region.id == states.regionId,
        );

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
    if (regionItem.isChild) {
      for (var district in allItems) {
        district.isSelected = district.id == regionItem.id;
      }
      updateState((state) => state.copyWith(
          allItems: allItems,
          districtId: regionItem.id,
          districtName: regionItem.name));
      return;
    } else {
      allItems.where((e) => e.parentId == regionItem.id).forEach((e) {
        e.isVisible = !e.isVisible;
      });
      // for (var region in allItems) {
      //   region.isSelected = region.id == regionItem.id;
      // }
      allItems.firstWhere((e) => e.id == regionItem.id).isOpened =
          !regionItem.isOpened;

      updateState(
        (state) => state.copyWith(
          regionId: regionItem.id,
          regionName: regionItem.name,
          allItems: allItems,
          visibleItems: allItems.where((e) => e.isVisible).toList(),
        ),
      );
    }
  }

  Future<void> saveSelectedRegion(state) async {
    await _regionRepository.setSelectedRegion(state.regionId, state.regionName,
        state.districtId, state.districtName);

    _selectedRegionStreamController.add(states.districtId!);
    emitEvent(SetRegionEvent(SetRegionEventType.onSave));
  }

  Future<void> clearSelectedRegion() async {
    await _regionRepository.clearSelectedRegion();

    _selectedRegionStreamController.add(0);
    emitEvent(SetRegionEvent(SetRegionEventType.onClose));
  }
}
