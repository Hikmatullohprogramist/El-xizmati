import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/core/base_cubit.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';

import '../../../../data/repositories/auth_repository.dart';

part 'auth_start_cubit.freezed.dart';

part 'auth_start_state.dart';

@injectable
class AuthStartCubit
    extends BaseCubit<AuthStartBuildable, AuthStartListenable> {
  AuthStartCubit(this._repository) : super(AuthStartBuildable());

  final AuthRepository _repository;

  void setPhone(String phone) {
    log.i(phone);
    updateState(
      (buildable) => buildable.copyWith(
        phone: phone,
        validation: phone.length >= 9,
      ),
    );
  }

  void validation() async {
    updateState((buildable) => buildable.copyWith(loading: true));
    try {
      var authStartResponse =
          await _repository.authStart("998${currentState.phone.clearSpaceInPhone()}");
      if (authStartResponse.data.is_registered == true) {
        emitEvent(AuthStartListenable(AuthStartEffect.verification,
            phone: currentState.phone));
      } else {
        emitEvent(AuthStartListenable(AuthStartEffect.confirmation,
            phone: currentState.phone));
      }
    } on DioException catch (e) {
      display.error(e.toString());
    } finally {
      updateState((buildable) => buildable.copyWith(loading: false));
    }
  }
}
