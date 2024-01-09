part of 'user_active_device_cubit.dart';

@freezed
class UserActiveDeviceBuildable with _$UserActiveDeviceBuildable {
  const factory UserActiveDeviceBuildable({
    PagingController<int, ActiveDeviceResponse>? devicesPagingController,
  }) = _UserActiveDeviceBuildable;
}

@freezed
class UserActiveDeviceListenable with _$UserActiveDeviceListenable {
  const factory UserActiveDeviceListenable() = _UserActiveDeviceListenable;
}
