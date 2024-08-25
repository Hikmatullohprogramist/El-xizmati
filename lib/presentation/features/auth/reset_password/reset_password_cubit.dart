import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:El_xizmati/presentation/support/cubit/base_cubit.dart';
import 'package:El_xizmati/data/repositories/auth_repository.dart';

part 'reset_password_cubit.freezed.dart';
part 'reset_password_state.dart';

@injectable
class ResetPasswordCubit extends BaseCubit<ResetPasswordState, ResetPasswordEvent> {
  ResetPasswordCubit(this._authRepository) : super(ResetPasswordState());

  final AuthRepository _authRepository;

  void setPassword(String password) {
    updateState((state) => state.copyWith(password: password));
    enable();
  }

  void setRepeatPassword(String repeatPassword) {
    updateState((state) => state.copyWith(
          repeatPassword: repeatPassword,
        ));
    enable();
  }

  void enable() {
    logger
        .w("password= ${states.password}, repeatPass=${states.repeatPassword}");
    updateState(
      (state) => state.copyWith(
        enabled: ((state.password.length >= 8) &&
            (state.repeatPassword.length >= 8) &&
            (state.password == state.repeatPassword)),
      ),
    );
  }

  Future<void> createPassword() async {
    updateState((state) => state.copyWith(loading: true));
    try {
      await _authRepository.setNewPassword(
        states.password,
        states.repeatPassword,
      );
      emitEvent(ResetPasswordEvent(ResetPasswordEventType.navigationToHome));
    } catch (e, stackTrace) {
      logger.e(e.toString(), error: e, stackTrace: stackTrace);
    } finally {
      updateState((state) => state.copyWith(loading: false));
    }
  }
}
