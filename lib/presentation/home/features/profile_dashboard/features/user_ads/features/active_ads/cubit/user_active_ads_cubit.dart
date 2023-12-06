import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../../../common/core/base_cubit.dart';

part 'user_active_ads_cubit.freezed.dart';

part 'user_active_ads_state.dart';

@Injectable()
class UserActiveAdsCubit
    extends BaseCubit<UserActiveAdsBuildable, UserActiveAdsListenable> {
  UserActiveAdsCubit() : super(const UserActiveAdsBuildable());
}
