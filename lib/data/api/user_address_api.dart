import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/storage/token_storage.dart';

@lazySingleton
class UserAddressApi {
  final Dio _dio;
  final TokenStorage tokenStorage;

  UserAddressApi(this._dio, this.tokenStorage);

  Future<Response> getUserAddresses() async {
    final headers = {"Authorization": "Bearer ${tokenStorage.token.call()}"};
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
    final headers = {"Authorization": "Bearer ${tokenStorage.token.call()}"};
    final data = {
      "name": name,
      "region_id": regionId,
      "district_id": districtId,
      "mahalla_id": mahallaId,
      "home_num": homeNum,
      "apartment_num": apartmentNum,
      "street_num": streetNum,
      "is_main": isMain,
      "geo": geo,
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
    final headers = {"Authorization": "Bearer ${tokenStorage.token.call()}"};
    final data = {
      "name": name,
      "region_id": regionId,
      "district_id": districtId,
      "mahalla_id": mahallaId,
      "home_num": homeNum,
      "apartment_num": apartmentNum,
      "street_num": streetNum,
      "is_main": isMain,
      "geo": geo,
      "id": id,
      "state": state
    };
    return _dio.put('v1/user/address',
        data: data, options: Options(headers: headers));
  }

  Future<Response> deleteUserAddress({required int userAddressId}) async {
    final headers = {"Authorization": "Bearer ${tokenStorage.token.call()}"};
    final data = {"id": userAddressId, "type": "SELECTED"};
    return _dio.delete("v1/user/address",
        queryParameters: data, options: Options(headers: headers));
  }

  Future<Response> updateMainAddress(
      {required int userAddressId, required bool isMain}) async {
    final headers = {"Authorization": "Bearer ${tokenStorage.token.call()}"};
    final data = {"id": userAddressId, "is_main": isMain};
    return _dio.patch("v1/user/address",
        queryParameters: data, options: Options(headers: headers));
  }
}
