import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/presentation/support/cubit/base_cubit.dart';

part 'notification_list_cubit.freezed.dart';
part 'notification_list_state.dart';

@injectable
class NotificationListCubit
    extends BaseCubit<NotificationListState, NotificationListEvent> {
  NotificationListCubit() : super(NotificationListState());
}
