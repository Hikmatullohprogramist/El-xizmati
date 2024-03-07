import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/core/base_cubit.dart';
import 'package:onlinebozor/domain/mappers/region_mapper.dart';
import 'package:onlinebozor/domain/models/district/district.dart';
import 'package:onlinebozor/domain/models/region/region.dart';
import 'package:onlinebozor/domain/models/region/region_item.dart';

import '../../../../common/enum/enums.dart';
import '../../../../data/repositories/user_repository.dart';

part 'page_cubit.freezed.dart';

part 'page_state.dart';

@Injectable()
class PageCubit extends BaseCubit<PageState, PageEvent> {
  PageCubit(this.repository) : super(const PageState()) {
    getRegionAndDistricts();
  }

  final UserRepository repository;

  void setInitialParams(List<District>? districts) {
    try {
      if (districts != null) {
        List<District> selectedItems = [];
        selectedItems.addAll(districts);
        updateState((state) => state.copyWith(
              initialSelectedItems: districts
                  .map(
                      (e) => e.toRegionItem(isSelected: true, isVisible: false))
                  .toList(),
            ));
      }
    } catch (e) {
      log.e(e.toString());
    }
  }

  Future<void> getRegionAndDistricts() async {
    try {
      final response = await repository.getRegionAndDistricts();
      var allRegions = response.regions;
      var allDistricts = response.districts;
      List<RegionItem> allItems = [];

      var sd = states.initialSelectedItems;
      for (var region in allRegions) {
        var districts = allDistricts
            .where((district) => district.regionId == region.id)
            .map(
              (district) => district.toRegionItem(
                  isSelected:
                      sd.firstWhereOrNull((e) => e.id == district.id) != null),
            );

        var isAllChildSelected =
            districts.firstWhereOrNull((e) => e.isSelected == false) == null;
        allItems.add(region.toRegionItem(
          isSelected: isAllChildSelected,
          isVisible: true,
        ));
        allItems.addAll(districts);
      }

      log.w("getRegionAndDistricts allItems length = ${allItems.length}");

      updateState(
        (state) => state.copyWith(
          allRegions: allRegions,
          allDistricts: allDistricts,
          allItems: allItems,
          visibleItems: allItems.where((e) => e.isVisible).toList(),
          loadState: LoadingState.success,
        ),
      );
    } on DioException catch (exception) {
      log.e(exception.toString());
      updateState((state) => state.copyWith(loadState: LoadingState.error));
    }
  }

  void setRegion(int? regionId) {
    log.d(regionId);
    updateState((state) => state.copyWith(regionId: regionId));
  }

  void updateSelectedState(RegionItem regionItem) {
    try {
      if (states.visibleItems.contains(regionItem)) {
        var allItems = List<RegionItem>.from(states.allItems);

        if (regionItem.isParent) {
          allItems
              .where((e) => e.parentId == regionItem.id)
              .forEach((child) => child.isSelected = !regionItem.isSelected);

          var index = allItems.indexOf(regionItem);
          allItems[index].isSelected = !regionItem.isSelected;
        } else {
          var index = allItems.indexOf(regionItem);
          allItems[index].isSelected = !regionItem.isSelected;

          bool hasUnSelectedChild = allItems
                  .where((e) => e.id == regionItem.id && !e.isSelected)
                  .firstOrNull != null;

          allItems
              .firstWhereOrNull((e) => e.id == regionItem.parentId)
              ?.isSelected = !hasUnSelectedChild;
        }
        updateState((state) => state.copyWith(
              allItems: allItems,
              visibleItems: allItems.where((e) => e.isVisible).toList(),
            ));
      }
    } catch (e) {
      log.e(e.toString());
    }
  }

  void openOrClose(RegionItem regionItem) {
    var allItems = states.allItems;
    allItems.where((element) => element.parentId == regionItem.id).forEach((e) {
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
