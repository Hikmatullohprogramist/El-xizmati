import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/responses/user_ad/user_ad_response.dart';

import '../../../../common/core/base_cubit.dart';

part 'user_ad_detail_cubit.freezed.dart';

part 'user_ad_detail_state.dart';

@Injectable()
class UserAdDetailCubit
    extends BaseCubit<UserAdDetailBuildable, UserAdDetailListenable> {
  UserAdDetailCubit() : super(UserAdDetailBuildable());
}
