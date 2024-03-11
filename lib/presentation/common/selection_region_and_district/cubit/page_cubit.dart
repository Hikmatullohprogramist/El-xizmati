import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/core/base_cubit.dart';
import 'package:onlinebozor/domain/mappers/region_mapper.dart';
import 'package:onlinebozor/domain/models/district/district.dart';
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
        List<RegionItem> initialSelectedItems = districts
            .map((e) => e.toRegionItem(isSelected: false, isVisible: false))
            .toList();

        updateState(
          (state) => state.copyWith(initialSelectedItems: initialSelectedItems),
        );
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

      var items = states.initialSelectedItems;
      for (var region in allRegions) {
        var regionDistricts = allDistricts
            .where((d) => d.regionId == region.id)
            .map(
              (d) => d.toRegionItem(
                isSelected: items.firstWhereOrNull((e) => e.id == d.id) != null,
              ),
            );

        var selectedCount = regionDistricts.where((e) => e.isSelected).length;
        var totalChildCount = regionDistricts.length;
        allItems.add(region.toRegionItem(
          isSelected: selectedCount == totalChildCount,
          isVisible: true,
          childCount: totalChildCount,
          selectedChildCount: selectedCount,
        ));

        allItems.addAll(regionDistricts);
      }

      log.w("getRegionAndDistricts allItems length = ${allItems.length}");

      updateState(
        (state) => state.copyWith(
          loadState: LoadingState.success,
          allItems: allItems,
          visibleItems: allItems.where((e) => e.isVisible).toList(),
        ),
      );
    } on DioException catch (exception) {
      log.e(exception.toString());
      updateState((state) => state.copyWith(loadState: LoadingState.error));
    }
  }

  void updateSelectedState(RegionItem regionItem) {
    try {
      var allItems = List<RegionItem>.from(states.allItems);

      var state = !regionItem.isSelected;
      if (regionItem.isParent) {
        allItems
            .where((e) => e.parentId == regionItem.id || e.id == regionItem.id)
            .forEach((child) => child.isSelected = state);

        int selectedChildCount = allItems
            .where((e) => e.parentId == regionItem.id && e.isSelected)
            .length;

        int totalChildCount =
            allItems.where((e) => e.parentId == regionItem.id).length;

        allItems.firstWhereOrNull((e) => e.id == regionItem.id)?.isSelected =
            totalChildCount == selectedChildCount;

        allItems
            .firstWhereOrNull((e) => e.id == regionItem.parentId)
            ?.selectedChildCount = selectedChildCount;
      } else {
        allItems
            .firstWhereOrNull((element) => element.id == regionItem.id)
            ?.isSelected = state;

        int selectedChildCount = allItems
            .where((e) => e.parentId == regionItem.parentId && e.isSelected)
            .length;

        int totalChildCount =
            allItems.where((e) => e.parentId == regionItem.parentId).length;

        allItems
            .firstWhereOrNull((e) => e.id == regionItem.parentId)
            ?.isSelected = totalChildCount == selectedChildCount;
        allItems
            .firstWhereOrNull((e) => e.id == regionItem.parentId)
            ?.selectedChildCount = selectedChildCount;
      }

      updateState((state) => state.copyWith(
            allItems: allItems,
            visibleItems: allItems.where((e) => e.isVisible).toList(),
          ));
    } catch (e) {
      log.e("update-selected-state error = ${e.toString()}");
    }
  }

  void openOrClose(RegionItem regionItem) {
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
