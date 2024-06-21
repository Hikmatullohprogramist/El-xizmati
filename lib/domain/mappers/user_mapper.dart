import 'package:onlinebozor/data/datasource/floor/entities/user_address_entity.dart';
import 'package:onlinebozor/data/datasource/network/responses/active_sessions/active_session_response.dart';
import 'package:onlinebozor/data/datasource/network/responses/address/user_address_response.dart';
import 'package:onlinebozor/domain/models/active_sessions/active_session.dart';
import 'package:onlinebozor/domain/models/user/user_address.dart';

extension ActiveSessionsExtension on ActiveSessionResponse {
  ActiveSession toMap(bool isCurrentSession) {
    return ActiveSession(
      id: id,
      token: token,
      lastActivityAt: last_activity_at,
      lastLoginAt: last_login_at,
      userAgent: user_agent,
      userId: user_id,
      lastIpAddress: last_ip_address,
      isCurrentSession: isCurrentSession,
    );
  }
}

extension UserAddressResponseExtension on UserAddressResponse {
  UserAddressEntity toAddressEntity() {
    return UserAddressEntity(
      id: id,
      name: name ?? "",
      regionId: region?.id ?? 0,
      regionName: region?.name ?? "",
      districtId: district?.id ?? 0,
      districtName: district?.name ?? "",
      neighborhoodId: neighborhood?.id ?? 0,
      neighborhoodName: neighborhood?.name ?? "",
      streetName: streetName ?? "",
      houseNumber: houseNum ?? "",
      apartmentNumber: apartmentNum ?? "",
      state: state ?? 0,
      isMain: isMain ?? false,
      geo: geo ?? "",
    );
  }

  UserAddress toAddress() {
    return UserAddress(
      id: id,
      name: name ?? "",
      regionId: region?.id ?? 0,
      regionName: region?.name ?? "",
      districtId: district?.id ?? 0,
      districtName: district?.name ?? "",
      neighborhoodId: neighborhood?.id ?? 0,
      neighborhoodName: neighborhood?.name ?? "",
      streetName: streetName ?? "",
      houseNumber: houseNum ?? "",
      apartmentNumber: apartmentNum ?? "",
      state: state ?? 0,
      isMain: isMain ?? false,
      geo: geo ?? "",
    );
  }
}

extension UserAddressEntityExtension on UserAddressEntity {
  UserAddress toAddress() {
    return UserAddress(
      id: id,
      name: name,
      regionId: regionId,
      regionName: regionName,
      districtId: districtId,
      districtName: districtName,
      neighborhoodId: neighborhoodId,
      neighborhoodName: neighborhoodName,
      streetName: streetName,
      houseNumber: houseNumber,
      apartmentNumber: apartmentNumber,
      state: state,
      isMain: isMain,
      geo: geo,
    );
  }
}
