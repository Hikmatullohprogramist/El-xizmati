import 'package:onlinebozor/common/base/base_cubit.dart';
import 'package:onlinebozor/domain/repo/auth_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'login_cubit.freezed.dart';

part 'login_state.dart';

@injectable
class LoginCubit extends BaseCubit<LoginBuildable, LoginListenable> {
  LoginCubit(this._repo) : super(const LoginBuildable());

  final AuthRepository _repo;

  Future<void> login() async {
    build((buildable) => buildable.copyWith(loading: true));

    try {
      await _repo.login(buildable.phone);
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
}
