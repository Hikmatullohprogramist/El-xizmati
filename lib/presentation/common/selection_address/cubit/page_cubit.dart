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
        updateState(
          (state) => state.copyWith(
            selectedItems: districts.map((e) => e.toRegionItem()).toList(),
          ),
        );
      }
    } catch (e) {
      log.e(e.toString());
    }
  }

  Future<void> getRegionAndDistricts() async {
    try {
      final response = await repository.getRegionAndDistricts();
      updateState(
        (state) => state.copyWith(
          allRegions: response.regions,
          allDistricts: response.districts,
          visibleItems: response.regions.map((e) => e.toRegionItem()).toList(),
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

  void updateSelectedItems(District district) {
    try {
      var selectedItems = List<RegionItem>.from(states.selectedItems);
      var regionItem = district.toRegionItem();
      if (states.selectedItems.contains(regionItem)) {
        selectedItems.remove(regionItem);
      } else {
        selectedItems.add(regionItem);
      }

      updateState((state) => state.copyWith(selectedItems: selectedItems));
    } catch (e) {
      log.e(e.toString());
    }
  }
}
