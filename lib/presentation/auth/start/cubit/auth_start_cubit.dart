import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/core/base_cubit.dart';

import '../../../../domain/repo/auth_repository.dart';

part 'auth_start_cubit.freezed.dart';

part 'auth_start_state.dart';

@injectable
class AuthStartCubit
    extends BaseCubit<AuthStartBuildable, AuthStartListenable> {
  AuthStartCubit(this._repository) : super(AuthStartBuildable());

  final AuthRepository _repository;

  void setPhone(String phone) {
    log.i(phone);
    build((buildable) =>
        buildable.copyWith(phone: phone, validation: phone.length >= 12));
  }

  void validation() async {
    log.i("call validation  ${buildable.phone}");
    build((buildable) => buildable.copyWith(loading: true));
    try {
      var authStartResponse = await _repository.authStart(buildable.phone);
      if (authStartResponse.data.is_registered) {
        invoke(AuthStartListenable(AuthStartEffect.navigationRegister,
            phone: buildable.phone));
      } else {
        invoke(AuthStartListenable(AuthStartEffect.navigationRegister));
      }
    } catch (e, stackTrace) {
      log.e(e.toString(), error: e, stackTrace: stackTrace);
      display.error(e.toString());
    } finally {
      build((buildable) => buildable.copyWith(loading: false));
    }
  }
}
