import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/base/base_cubit.dart';

part 'user_orders_cubit.freezed.dart';

part 'user_orders_state.dart';

@injectable
class UserOrdersCubit
    extends BaseCubit<UserOrdersBuildable, UserOrdersListenable> {
  UserOrdersCubit() : super(const UserOrdersBuildable());
}
