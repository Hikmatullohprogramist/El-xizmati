import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:El_xizmati/core/enum/enums.dart';
import 'package:El_xizmati/core/extensions/list_extensions.dart';
import 'package:El_xizmati/data/repositories/region_repository.dart';
import 'package:El_xizmati/domain/mappers/item_mapper.dart';
import 'package:El_xizmati/domain/models/district/district.dart';
import 'package:El_xizmati/domain/models/list/expandable_list_item.dart';
import 'package:El_xizmati/domain/models/region/set_region_event.dart';
import 'package:El_xizmati/presentation/stream_controllers/selected_region_stream_controller.dart';
import 'package:El_xizmati/presentation/support/cubit/base_cubit.dart';

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
            regionName: allItems.firstIf((e) => e.id == states.regionId)?.name,
            districtName:
                allItems.firstIf((e) => e.id == states.districtId)?.name,
            allItems: allItems,
            visibleItems: allItems.where((e) => e.isVisible).toList(),
          ));
    } catch (exception) {
      logger.e(exception.toString());
      updateState((state) => state.copyWith(loadState: LoadingState.error));
    }
  }

  void openOrClose(ExpandableListItem regionItem) {
    var allItems = states.allItems.map((e) => e.copy()).toList();

    if (regionItem.isOpened) {
      allItems.filterIf((e) => e.isParent).forEach((e) => e.isOpened = false);

      allItems.filterIf((e) => e.isChild).forEach((e) {
        e.isVisible = false;
      });
    } else {
      allItems
          .filterIf((e) => e.isParent)
          .forEach((e) => e.isOpened = e.id == regionItem.id);

      allItems.filterIf((e) => e.isChild).forEach((e) {
        e.isVisible = e.parentId == regionItem.id;
      });

      if (states.regionId != regionItem.id) {
        allItems.filterIf((e) => e.isChild).forEach((e) {
          e.isSelected = false;
        });
      }
    }

    updateState(
      (state) => state.copyWith(
        regionId: regionItem.id,
        regionName: regionItem.name,
        districtId: null,
        districtName: null,
        allItems: allItems,
        visibleItems: allItems.where((e) => e.isVisible).toList(),
      ),
    );
  }

  void setSelectedDistrict(ExpandableListItem districtItem) {
    var allItems = states.allItems;
    allItems
        .filterIf((e) => e.isChild)
        .forEach((e) => e.isSelected = e.id == districtItem.id);

    updateState((state) => state.copyWith(
          allItems: allItems,
          districtId: districtItem.id,
          districtName: districtItem.name,
        ));
  }

  Future<void> saveSelectedRegion() async {
    if (states.isRegionSelected) {
      await _regionRepository.setSelectedRegion(
        states.regionId!,
        states.regionName!,
        states.districtId!,
        states.districtName!,
      );

      _selectedRegionStreamController.add(SetRegionResult.regionChanged);
    }

    emitEvent(SetRegionEvent(SetRegionEventType.onSave));
  }

  Future<void> clearSelectedRegion() async {
    await _regionRepository.clearSelectedRegion();

    _selectedRegionStreamController.add(SetRegionResult.regionReset);
    emitEvent(SetRegionEvent(SetRegionEventType.onClose));
  }
}
