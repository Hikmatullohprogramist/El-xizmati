import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/base/base_cubit.dart';

part 'my_active_device_cubit.freezed.dart';

part 'my_active_device_state.dart';

@injectable
class MyActiveDeviceCubit
    extends BaseCubit<MyActiveDeviceBuildable, MyActiveDeviceListenable> {
  MyActiveDeviceCubit() : super(MyActiveDeviceBuildable());
}
