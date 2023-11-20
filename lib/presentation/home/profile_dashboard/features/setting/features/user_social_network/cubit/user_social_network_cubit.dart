// TODO Implement this library.import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/base/base_cubit.dart';

part 'user_social_network_cubit.freezed.dart';

part 'user_social_network_state.dart';

@Injectable()
class UserSocialNetworkCubit
    extends BaseCubit<UserSocialNetworkBuildable, UserSocialNetworkListenable> {
  UserSocialNetworkCubit() : super(const UserSocialNetworkBuildable());
}
