import 'package:dio/dio.dart';
import 'package:onlinebozor/data/datasource/network/constants/rest_query_keys.dart';

class UserAddressService {
  final Dio _dio;

  UserAddressService(this._dio);

  Future<Response> getUserAddresses() async {
    return _dio.get("api/mobile/v1/user/address");
  }

  Future<Response> addUserAddress({
    required String name,
    required int regionId,
    required int districtId,
    required int neighborhoodId,
    required String homeNum,
    required String apartmentNum,
    required String streetNum,
    required bool isMain,
    required String? geo,
  }) {
    final body = {
      RestQueryKeys.name: name,
      RestQueryKeys.regionId: regionId,
      RestQueryKeys.districtId: districtId,
      RestQueryKeys.neighborhoodId: neighborhoodId,
      RestQueryKeys.homeNumber: homeNum,
      RestQueryKeys.apartmentNumber: apartmentNum,
      RestQueryKeys.streetNumber: streetNum,
      RestQueryKeys.isMain: isMain,
      RestQueryKeys.geo: geo,
    };

    return _dio.post('api/mobile/v1/user/address', data: body);
  }

  Future<Response> updateUserAddress({
    required String name,
    required int regionId,
    required int districtId,
    required int neighborhoodId,
    required String homeNum,
    required String apartmentNum,
    required String streetNum,
    required bool isMain,
    required String? geo,
    required int id,
    required String state,
  }) async {
    final body = {
      RestQueryKeys.name: name,
      RestQueryKeys.regionId: regionId,
      RestQueryKeys.districtId: districtId,
      RestQueryKeys.neighborhoodId: neighborhoodId,
      RestQueryKeys.homeNumber: homeNum,
      RestQueryKeys.apartmentNumber: apartmentNum,
      RestQueryKeys.streetNumber: streetNum,
      RestQueryKeys.isMain: isMain,
      RestQueryKeys.geo: geo,
      RestQueryKeys.id: id,
      RestQueryKeys.state: 1
    };

    return _dio.put('api/mobile/v1/user/address', data: body);
  }

  Future<Response> deleteUserAddress({required int userAddressId}) async {
    final body = {
      RestQueryKeys.id: userAddressId,
      RestQueryKeys.type: "SELECTED"
    };

    return _dio.delete("api/mobile/v1/user/address", queryParameters: body);
  }

  Future<Response> updateMainAddress({
    required int userAddressId,
    required bool isMain,
  }) async {
    final body = {
      RestQueryKeys.id: userAddressId,
      RestQueryKeys.isMain: isMain
    };

    return _dio.patch("api/mobile/v1/user/address", queryParameters: body);
  }
}
