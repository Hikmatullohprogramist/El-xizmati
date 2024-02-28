import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/core/base_cubit.dart';

import '../../../../common/enum/enums.dart';
import '../../../../data/repositories/ad_creation_repository.dart';
import '../../../../data/repositories/user_repository.dart';
import '../../../../data/responses/region/region_response.dart';

part 'selection_address_cubit.freezed.dart';

part 'selection_address_state.dart';

@Injectable()
class SelectionAddressCubit
    extends BaseCubit<SelectionAddressBuildable, SelectionAddressListenable> {
  SelectionAddressCubit(this._repository, this._userRepository) : super( SelectionAddressBuildable()){
    getRegions();
    getDistrict();
  }

  final AdCreationRepository _repository;
  final UserRepository _userRepository;


  Future<void> getRegions() async {
    try {
      final response = await _userRepository.getRegions();
      build((buildable) => buildable.copyWith(
         items: response,
         itemsLoadState: LoadingState.success
      ));
        } on DioException catch (exception) {
     log.e(exception.toString());
     build(
           (buildable) => buildable.copyWith(
         itemsLoadState: LoadingState.error,
       ),
     );
   }
  }

  Future<void> getDistrict() async {
    final regionId = buildable.regionId;
    log.w(regionId);
    try {
      final response = await _userRepository.getDistricts(regionId ?? 14);
      log.w(response);
      build((buildable) =>
          buildable.copyWith(
              districts: response,
              itemsLoadState: LoadingState.success
          ));
    }on DioException catch (exception) {
      log.e(exception.toString());
      build(
            (buildable) => buildable.copyWith(
          itemsLoadState: LoadingState.error,
        ),
      );
    }

  }




//Future<void> getItems() async {
//  log.d("111");
//  try {
//    final paymentTypes = await _repository.getPaymentTypesForCreationAd();
//    log.i(paymentTypes.toString());
//    build((buildable) => buildable.copyWith(
//        items: paymentTypes,
//        itemsLoadState: LoadingState.success,
//      ),
//    );
//  } on DioException catch (exception) {
//    log.e(exception.toString());
//    build(
//          (buildable) => buildable.copyWith(
//        itemsLoadState: LoadingState.error,
//      ),
//    );
//  }
//}

  void setRegion(int? regionId) {
    log.d(regionId);
    build((buildable) => buildable.copyWith(
        regionId: regionId,
       ));
    getDistrict();
  }



  void setInitialSelectedItems(List<RegionResponse>? paymentTypes) {
    try {
     if (paymentTypes != null) {
       List<RegionResponse> updatedSelectedItems = [];
       updatedSelectedItems.addAll(paymentTypes);
       build((buildable) => buildable.copyWith(selectedItems: updatedSelectedItems,),
       );
     }
   } catch (e) {
     log.e(e.toString());
   }}


   void updateSelectedItems(RegionResponse paymentType) {
     try {
       var updatedSelectedItems = List<RegionResponse>.from(buildable.selectedItems);
       if (buildable.selectedItems.contains(paymentType)) {
         updatedSelectedItems.remove(paymentType);
       } else {
         updatedSelectedItems.add(paymentType);
       }

       build(
             (buildable) => buildable.copyWith(
           selectedItems: updatedSelectedItems,
         ),
       );
     } catch (e) {
       log.e(e.toString());
     }
   }



}
