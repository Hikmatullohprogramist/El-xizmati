import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/base/base_cubit.dart';
import 'package:onlinebozor/domain/repo/auth_repository.dart';

part 'login_cubit.freezed.dart';

part 'login_state.dart';

@injectable
class LoginCubit extends BaseCubit<LoginBuildable, LoginListenable> {
  LoginCubit(this._repo) : super(const LoginBuildable());

  final AuthRepository _repo;

  Future<void> login() async {
    build((buildable) => buildable.copyWith(loading: true));
    try {
      await _repo.login(buildable.phone, buildable.password);
      invoke(LoginListenable(LoginEffect.success, phone: buildable.phone));
    } catch (e, stackTrace) {
      log.e(e.toString(), error: e, stackTrace: stackTrace);
      display.error(e.toString());
    } finally {
      build((buildable) => buildable.copyWith(loading: false));
    }
  }

  void setPhone(String phone) {
    build((buildable) => buildable.copyWith(phone: phone));
  }

  void setPassword(String password) {
    build((buildable) =>
        buildable.copyWith(password: password, enabled: password.length >= 4));
  }
}
