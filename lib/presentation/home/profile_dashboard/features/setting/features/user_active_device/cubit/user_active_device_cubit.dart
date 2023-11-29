import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../../common/core/base_cubit.dart';

part 'user_active_device_cubit.freezed.dart';

part 'user_active_device_state.dart';

@injectable
class UserActiveDeviceCubit
    extends BaseCubit<UserActiveDeviceBuildable, UserActiveDeviceListenable> {
  UserActiveDeviceCubit() : super(UserActiveDeviceBuildable());
}
