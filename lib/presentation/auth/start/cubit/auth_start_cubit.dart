import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/core/base_cubit.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';

import '../../../../domain/repositories/auth_repository.dart';

part 'auth_start_cubit.freezed.dart';
part 'auth_start_state.dart';

@injectable
class AuthStartCubit extends BaseCubit<AuthStartBuildable, AuthStartListenable> {
  AuthStartCubit(this._repository) : super(AuthStartBuildable());

  final AuthRepository _repository;

  void setPhone(String phone) {
    log.i(phone);
    build((buildable) =>
        buildable.copyWith(phone: phone, validation: phone.length >= 12));
  }

  void validation() async {
    build((buildable) => buildable.copyWith(loading: true));
    try {
      var authStartResponse =
          await _repository.authStart(buildable.phone.clearSpaceInPhone());
      if (authStartResponse.data.is_registered == true) {
        invoke(AuthStartListenable(AuthStartEffect.verification,
            phone: buildable.phone));
      } else {
        invoke(AuthStartListenable(AuthStartEffect.confirmation,
            phone: buildable.phone));
      }
    } on DioException catch (e, stackTrace) {
      display.error(e.toString());
    } finally {
      build((buildable) => buildable.copyWith(loading: false));
    }
  }
}
