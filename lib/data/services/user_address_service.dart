import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/constants/rest_header_keys.dart';
import 'package:onlinebozor/data/constants/rest_query_keys.dart';

import '../storages/token_storage.dart';

@lazySingleton
class UserAddressService {
  final Dio _dio;
  final TokenStorage tokenStorage;

  UserAddressService(this._dio, this.tokenStorage);

  Future<Response> getUserAddresses() async {
    final headers = {
      RestHeaderKeys.authorization: "Bearer ${tokenStorage.token.call()}"
    };
    return _dio.get("v1/user/address", options: Options(headers: headers));
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
    final headers = {
      RestHeaderKeys.authorization: "Bearer ${tokenStorage.token.call()}"
    };
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
    return _dio.post('v1/user/address',
        data: data, options: Options(headers: headers));
  }

  Future<Response> updateUserAddress(
      {required String name,
      required int regionId,
      required int districtId,
      required int neighborhoodId,
      required String homeNum,
      required String apartmentNum,
      required String streetNum,
      required bool isMain,
      required String? geo,
      required int id,
      required String state}) async {
    final headers = {
      RestHeaderKeys.authorization: "Bearer ${tokenStorage.token.call()}"
    };
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
    return _dio.put('v1/user/address',
        data: data, options: Options(headers: headers));
  }

  Future<Response> deleteUserAddress({required int userAddressId}) async {
    final headers = {
      RestHeaderKeys.authorization: "Bearer ${tokenStorage.token.call()}"
    };
    final data = {
      RestQueryKeys.id: userAddressId,
      RestQueryKeys.type: "SELECTED"
    };
    return _dio.delete("v1/user/address",
        queryParameters: data, options: Options(headers: headers));
  }

  Future<Response> updateMainAddress(
      {required int userAddressId, required bool isMain}) async {
    final headers = {
      RestHeaderKeys.authorization: "Bearer ${tokenStorage.token.call()}"
    };
    final data = {
      RestQueryKeys.id: userAddressId,
      RestQueryKeys.isMain: isMain
    };
    return _dio.patch("v1/user/address",
        queryParameters: data, options: Options(headers: headers));
  }
}
