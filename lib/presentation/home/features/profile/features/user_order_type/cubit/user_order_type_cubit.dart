import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../../../common/core/base_cubit.dart';

part 'user_order_type_state.dart';

part 'user_order_type_cubit.freezed.dart';

@Injectable()
class UserOrderTypeCubit
    extends BaseCubit<UserOrderTypeBuildable, UserOrderTypeListenable> {
  UserOrderTypeCubit() : super(UserOrderTypeBuildable());
}
