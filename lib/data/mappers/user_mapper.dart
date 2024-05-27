
import 'package:onlinebozor/data/datasource/hive/hive_objects/user/user_hive_object.dart';
import 'package:onlinebozor/data/datasource/network/responses/auth/confirm/confirm_response.dart';

extension ConfirmResponseMapper on ConfirmResponse{
  UserHiveObject toUserHiveObject(){
    return UserHiveObject(
      neighborhoodId: user?.neighborhoodId,
      fullName: user?.fullName,
      email: user?.email,
      tin: user?.tin,
      id: user?.id,
      apartmentName: user?.apartmentName,
      districtId: user?.districtId,
      username: user?.username,
      birthDate: user?.birthDate,
      eimzoAllowToLogin: user?.eimzoAllowToLogin,
      gender: user?.gender,
      homeName: user?.homeName,
      isPassword: user?.isPassword,
      isIdentityVerified: user?.isRegistered,
      mobilePhone: user?.mobilePhone,
      regionId: user?.regionId,
      passportNumber: user?.passportNumber,
      passportSerial: user?.passportSerial,
      photo: user?.photo,
      pinfl: user?.pinfl,
      postName: user?.username,
      // registeredWithEimzo: user?.registeredWithEimzo,
      state: user?.state,
    );
  }
}