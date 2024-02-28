import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/core/base_cubit.dart';

import '../../../../common/enum/enums.dart';
import '../../../../data/repositories/ad_creation_repository.dart';
import '../../../../data/repositories/user_repository.dart';
import '../../../../data/responses/region/region_response.dart';

part 'page_cubit.freezed.dart';

part 'page_state.dart';

@Injectable()
class PageCubit extends BaseCubit<PageState, PageEvent> {
  PageCubit(this._repository, this._userRepository) : super(const PageState());

  final AdCreationRepository _repository;
  final UserRepository _userRepository;

  Future<void> getRegions() async {
    try {
      final response = await _userRepository.getRegions();
      updateState((state) =>
          state.copyWith(items: response, loadState: LoadingState.success));
    } on DioException catch (exception) {
      log.e(exception.toString());
      updateState((state) => state.copyWith(loadState: LoadingState.error));
    }
  }

  Future<void> getDistrict() async {
    final regionId = states.regionId;
    log.w(regionId);
    try {
      final response = await _userRepository.getDistricts(regionId ?? 14);
      log.w(response);
      updateState(
        (state) => state.copyWith(
          districts: response,
          loadState: LoadingState.success,
        ),
      );
    } on DioException catch (exception) {
      log.e(exception.toString());
      updateState((state) => state.copyWith(loadState: LoadingState.error));
    }
  }

  //Future<void> getItems() async {
//  log.d("111");
//  try {
//    final paymentTypes = await _repository.getPaymentTypesForCreationAd();
//    log.i(paymentTypes.toString());
//    build((buildable) => buildable.copyWith(
//        items: paymentTypes,
//        loadState: LoadingState.success,
//      ),
//    );
//  } on DioException catch (exception) {
//    log.e(exception.toString());
//    build(
//          (buildable) => buildable.copyWith(
//        loadState: LoadingState.error,
//      ),
//    );
//  }
//}

  void setRegion(int? regionId) {
    log.d(regionId);
    updateState((state) => state.copyWith(regionId: regionId));
    getDistrict();
  }

  void setInitialSelectedItems(List<RegionResponse>? paymentTypes) {
    try {
      if (paymentTypes != null) {
        List<RegionResponse> selectedItems = [];
        selectedItems.addAll(paymentTypes);
        updateState((state) => state.copyWith(selectedItems: selectedItems));
      }
    } catch (e) {
      log.e(e.toString());
    }
  }

  void updateSelectedItems(RegionResponse paymentType) {
    try {
      var selectedItems = List<RegionResponse>.from(states.selectedItems);

      if (states.selectedItems.contains(paymentType)) {
        selectedItems.remove(paymentType);
      } else {
        selectedItems.add(paymentType);
      }

      updateState((state) => state.copyWith(selectedItems: selectedItems));
    } catch (e) {
      log.e(e.toString());
    }
  }
}
