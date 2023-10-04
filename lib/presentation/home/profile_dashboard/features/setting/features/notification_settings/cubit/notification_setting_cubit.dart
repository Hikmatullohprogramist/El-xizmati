import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/base/base_cubit.dart';

part 'notification_setting_cubit.freezed.dart';

part 'notification_setting_state.dart';

@injectable
class NotificationSettingCubit extends BaseCubit<NotificationSettingBuildable,
    NotificationSettingListenable> {
  NotificationSettingCubit() : super(const NotificationSettingBuildable());
}
