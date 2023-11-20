import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/base/base_cubit.dart';

part 'user_pending_orders_cubit.freezed.dart';

part 'user_pending_orders_state.dart';

@injectable
class UserPendingOrdersCubit
    extends BaseCubit<UserPendingOrdersBuildable, UserPendingOrdersListenable> {
  UserPendingOrdersCubit() : super(const UserPendingOrdersBuildable());
}
