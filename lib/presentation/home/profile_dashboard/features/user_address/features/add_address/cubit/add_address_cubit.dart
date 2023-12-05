import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/model/address/user_address_response.dart';
import 'package:onlinebozor/data/model/region%20/region_response.dart';
import 'package:onlinebozor/domain/repository/user_repository.dart';

import '../../../../../../../../common/core/base_cubit_new.dart';

part 'add_address_cubit.freezed.dart';
part 'add_address_state.dart';

@injectable
class AddAddressCubit
    extends BaseCubit<AddAddressBuildable, AddAddressListenable> {
  AddAddressCubit(this._userRepository) : super(AddAddressBuildable());

  final UserRepository _userRepository;

  void setAddressName(String addressName) {
    build((buildable) => buildable.copyWith(addressName: addressName));
  }

  Future<void> getRegions() async {
    final response = await _userRepository.getRegions();
    final regionList =
        response.where((element) => element.id == buildable.regionId);
    if (regionList.isNotEmpty) {
      build((buildable) => buildable.copyWith(
            regions: response,
            regionName: regionList.first.name,
          ));
    } else {
      build((buildable) => buildable.copyWith(
            regionName: "",
          ));
    }
  }

  Future<void> getDistrict() async {
    final regionId = buildable.regionId;
    final response = await _userRepository.getDistricts(regionId ?? 14);
    if (buildable.districtId != null) {
      build((buildable) => buildable.copyWith(
          districts: response,
          districtName: response
              .where((element) => element.id == buildable.districtId)
              .first
              .name));
    } else {
      build((buildable) => buildable.copyWith(districts: response));
    }
  }

  Future<void> getStreets() async {
    try {
      final districtId = buildable.districtId;
      final response = await _userRepository.getStreets(districtId ?? 1419);
      if (buildable.streetId != null) {
        build((buildable) => buildable.copyWith(
              streets: response,
              streetName: response
                  .where((element) => element.id == buildable.streetId)
                  .first
                  .name,
            ));
      } else {
        build((buildable) => buildable.copyWith(
              streets: response,
            ));
      }
    } catch (e) {
      display.error("street error ${e}");
      build((buildable) => buildable.copyWith());
    }
  }

  void setRegion(RegionResponse region) {
    build((buildable) => buildable.copyWith(
        regionId: region.id,
        regionName: region.name,
        districtId: null,
        districtName: "",
        streetId: null,
        streetName: ""));
    getDistrict();
  }

  void setDistrict(RegionResponse district) {
    build((buildable) => buildable.copyWith(
        districtId: district.id,
        districtName: district.name,
        streetId: null,
        streetName: ""));
    getStreets();
  }

  void setStreet(RegionResponse street) {
    build((buildable) =>
        buildable.copyWith(streetId: street.id, streetName: street.name));
  }

}
