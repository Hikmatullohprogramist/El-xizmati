import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../common/core/base_cubit_new.dart';

part 'user_orders_cubit.freezed.dart';
part 'user_orders_state.dart';

@injectable
class UserOrdersCubit extends BaseCubit<UserOrdersBuildable, UserOrdersListenable> {
  UserOrdersCubit() : super(const UserOrdersBuildable());
}
