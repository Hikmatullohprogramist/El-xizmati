import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../common/base/base_cubit.dart';

part 'notification_cubit.freezed.dart';

part 'notification_state.dart';

@injectable
class NotificationCubit
    extends BaseCubit<NotificationBuildable, NotificationListenable> {
  NotificationCubit() : super(NotificationBuildable());
}
