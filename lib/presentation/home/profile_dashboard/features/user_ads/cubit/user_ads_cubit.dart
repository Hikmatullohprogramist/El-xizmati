import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/base/base_cubit.dart';

part 'user_ads_cubit.freezed.dart';

part 'user_ads_state.dart';

@injectable
class UserAdsCubit extends BaseCubit<UserAdsBuildable, UserAdsListenable> {
  UserAdsCubit() : super(const UserAdsBuildable());
}
