import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/core/base_cubit.dart';
import 'package:onlinebozor/domain/repo/auth_repository.dart';

part 'register_cubit.freezed.dart';

part 'register_state.dart';

@injectable
class RegisterCubit extends BaseCubit<RegisterBuildable, RegisterListenable> {
  RegisterCubit(this._repository) : super(const RegisterBuildable());

  final AuthRepository _repository;

  void setPhone(String phone) {
    build((buildable) => buildable.copyWith(phone: phone));
  }

  void setCode(String code) {
    build((buildable) =>
        buildable.copyWith(code: code, enable: code.length >= 4));
  }

  Future<void> register() async {
    build((buildable) => buildable.copyWith(loading: true));
    try {
      await _repository.register(buildable.phone, buildable.code);
      invoke(RegisterListenable(RegisterEffect.navigationConfirm));
    } catch (e, stackTrace) {
      log.e(e.toString(), error: e, stackTrace: stackTrace);
      display.error(e.toString());
    } finally {
      build((buildable) => buildable.copyWith(loading: false));
    }
  }
}
