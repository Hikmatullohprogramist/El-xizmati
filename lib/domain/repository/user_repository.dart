import 'package:onlinebozor/data/model/user/user_information_response.dart';

import '../../data/model/region /region_response.dart';

abstract class UserRepository {
  Future<UserInformationResponse> getUserInformation();

  Future<List<RegionResponse>> getRegions();

  Future<List<RegionResponse>> getDistricts(int regionId);

  Future<List<RegionResponse>> getStreets(int streetId);
}
