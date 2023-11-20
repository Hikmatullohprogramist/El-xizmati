import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/base/base_cubit.dart';

part 'user_ad_detail_cubit.freezed.dart';

part 'user_ad_detail_state.dart';

@Injectable()
class UserAdDetailCubit
    extends BaseCubit<UserAdDetailBuildable, UserAdDetailListenable> {
  UserAdDetailCubit() : super(UserAdDetailBuildable());
}
