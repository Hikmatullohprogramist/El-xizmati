import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/constants/rest_header_keys.dart';
import 'package:onlinebozor/data/constants/rest_query_keys.dart';
import 'package:onlinebozor/data/storage/token_storage.dart';

@lazySingleton
class UserAddressApi {
  final Dio _dio;
  final TokenStorage tokenStorage;

  UserAddressApi(this._dio, this.tokenStorage);

  Future<Response> getUserAddresses() async {
    final headers = {
      RestHeaderKeys.headerAuthorization: "Bearer ${tokenStorage.token.call()}"
    };
    return _dio.get("v1/user/address", options: Options(headers: headers));
  }

  Future<Response> addUserAddress({
    required String name,
    required int regionId,
    required int districtId,
    required int mahallaId,
    required String homeNum,
    required String apartmentNum,
    required String streetNum,
    required bool isMain,
    required String? geo,
  }) {
    final headers = {
      RestHeaderKeys.headerAuthorization: "Bearer ${tokenStorage.token.call()}"
    };
    final data = {
      RestQueryKeys.queryName: name,
      RestQueryKeys.queryRegionId: regionId,
      RestQueryKeys.queryDistrictId: districtId,
      RestQueryKeys.queryMahallaId: mahallaId,
      RestQueryKeys.queryHomeNumber: homeNum,
      RestQueryKeys.queryApartmentNumber: apartmentNum,
      RestQueryKeys.queryStreetNumber: streetNum,
      RestQueryKeys.queryIsMain: isMain,
      RestQueryKeys.queryIsMain: geo,
    };
    return _dio.post('v1/user/address',
        data: data, options: Options(headers: headers));
  }

  Future<Response> updateUserAddress(
      {required String name,
      required int regionId,
      required int districtId,
      required int mahallaId,
      required String homeNum,
      required String apartmentNum,
      required String streetNum,
      required bool isMain,
      required String? geo,
      required int id,
      required String state}) async {
    final headers = {
      RestHeaderKeys.headerAuthorization: "Bearer ${tokenStorage.token.call()}"
    };
    final data = {
      RestQueryKeys.queryName: name,
      RestQueryKeys.queryRegionId: regionId,
      RestQueryKeys.queryDistrictId: districtId,
      RestQueryKeys.queryMahallaId: mahallaId,
      RestQueryKeys.queryHomeNumber: homeNum,
      RestQueryKeys.queryApartmentNumber: apartmentNum,
      RestQueryKeys.queryStreetNumber: streetNum,
      RestQueryKeys.queryIsMain: isMain,
      RestQueryKeys.queryGeo: geo,
      RestQueryKeys.queryId: id,
      RestQueryKeys.queryState: 1
    };
    return _dio.put('v1/user/address',
        data: data, options: Options(headers: headers));
  }

  Future<Response> deleteUserAddress({required int userAddressId}) async {
    final headers = {
      RestHeaderKeys.headerAuthorization: "Bearer ${tokenStorage.token.call()}"
    };
    final data = {
      RestQueryKeys.queryId: userAddressId,
      RestQueryKeys.queryType: "SELECTED"
    };
    return _dio.delete("v1/user/address",
        queryParameters: data, options: Options(headers: headers));
  }

  Future<Response> updateMainAddress(
      {required int userAddressId, required bool isMain}) async {
    final headers = {
      RestHeaderKeys.headerAuthorization: "Bearer ${tokenStorage.token.call()}"
    };
    final data = {
      RestQueryKeys.queryId: userAddressId,
      RestQueryKeys.queryIsMain: isMain
    };
    return _dio.patch("v1/user/address",
        queryParameters: data, options: Options(headers: headers));
  }
}
