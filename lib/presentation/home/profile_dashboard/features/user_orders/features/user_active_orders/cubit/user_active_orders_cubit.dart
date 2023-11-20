import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/base/base_cubit.dart';

part 'user_active_orders_cubit.freezed.dart';

part 'user_active_orders_state.dart';

@injectable
class UserActiveOrdersCubit
    extends BaseCubit<UserActiveOrdersBuildable, UserActiveOrdersListenable> {
  UserActiveOrdersCubit() : super(const UserActiveOrdersBuildable());
}
