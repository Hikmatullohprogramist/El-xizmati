import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../../../common/core/base_cubit.dart';

part 'user_order_start_cubit.freezed.dart';

part 'user_order_start_state.dart';

@Injectable()
class UserOrderStartCubit
    extends BaseCubit<UserOrderStartBuildable, UserOrderStartListenable> {
  UserOrderStartCubit() : super(UserOrderStartBuildable());
}
