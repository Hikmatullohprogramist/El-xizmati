import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/base/base_cubit.dart';

part 'user_saved_orders_cubit.freezed.dart';

part 'user_saved_orders_state.dart';

@injectable
class UserSavedOrdersCubit
    extends BaseCubit<UserSavedOrdersBuildable, UserSavedOrdersListenable> {
  UserSavedOrdersCubit() : super(const UserSavedOrdersBuildable());
}
