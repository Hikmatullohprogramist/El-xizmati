import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:onlinebozor/common/base/base_cubit.dart';

part 'auth_verification_cubit.freezed.dart';

part 'auth_verification_state.dart';

class AuthVerificationCubit
    extends BaseCubit<AuthVerificationBuildable, AuthVerificationListenable> {
  AuthVerificationCubit() : super(AuthVerificationBuildable());
}
