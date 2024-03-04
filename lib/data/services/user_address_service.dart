import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/constants/rest_query_keys.dart';

import '../storages/token_storage.dart';

@lazySingleton
class UserAddressService {
  final Dio _dio;
  final TokenStorage tokenStorage;

  UserAddressService(this._dio, this.tokenStorage);

  Future<Response> getUserAddresses() async {
    return _dio.get("v1/user/address");
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
    final data = {
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
    return _dio.post('v1/user/address', data: data);
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
    final data = {
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
    return _dio.put('v1/user/address', data: data);
  }

  Future<Response> deleteUserAddress({required int userAddressId}) async {
    final data = {
      RestQueryKeys.id: userAddressId,
      RestQueryKeys.type: "SELECTED"
    };
    return _dio.delete("v1/user/address", queryParameters: data);
  }

  Future<Response> updateMainAddress({
    required int userAddressId,
    required bool isMain,
  }) async {
    final data = {
      RestQueryKeys.id: userAddressId,
      RestQueryKeys.isMain: isMain
    };
    return _dio.patch("v1/user/address", queryParameters: data);
  }
}
