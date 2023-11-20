import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/base/base_cubit.dart';

part 'user_addresses_cubit.freezed.dart';

part 'user_addresses_state.dart';

@Injectable()
class UserAddressesCubit
    extends BaseCubit<UserAddressesBuildable, UserAddressesListenable> {
  UserAddressesCubit() : super(UserAddressesBuildable());
}
