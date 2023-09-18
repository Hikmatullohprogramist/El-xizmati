import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/base/base_cubit.dart';
import 'package:onlinebozor/domain/repo/auth_repository.dart';

part 'set_password_cubit.freezed.dart';
part 'set_password_state.dart';

@injectable
class SetPasswordCubit
    extends BaseCubit<SetPasswordBuildable, SetPasswordListenable> {
  SetPasswordCubit(this._repository) : super(SetPasswordBuildable());

  final AuthRepository _repository;

  void setPassword(String password) {
    build((buildable) => buildable.copyWith(password: password));
    enable();
  }

  void setRepeatPassword(String repeatPassword) {
    build((buildable) => buildable.copyWith(
          repeatPassword: repeatPassword,
        ));
    enable();
  }

  void enable() {
    log.w(
        "password= ${buildable.password}, repeatPassword=${buildable.repeatPassword}");
    build((buildable) => buildable.copyWith(
        enabled: ((buildable.password.length >= 8) &&
            (buildable.repeatPassword.length >= 8))));
  }

  Future<void> createPassword() async {
    build((buildable) => buildable.copyWith(loading: true));
    try {
      _repository.setPassword(buildable.password, buildable.repeatPassword);
      invoke(SetPasswordListenable(SetPasswordEffect.success));
    } catch (e, stackTrace) {
      log.e(e.toString(), error: e, stackTrace: stackTrace);
      display.error(e.toString());
    } finally {
      build((buildable) => buildable.copyWith(loading: false));
    }
  }
}
