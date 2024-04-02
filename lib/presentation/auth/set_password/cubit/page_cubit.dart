import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/core/base_cubit.dart';

import '../../../../data/repositories/auth_repository.dart';

part 'page_cubit.freezed.dart';

part 'page_state.dart';

@injectable
class PageCubit extends BaseCubit<PageState, PageEvent> {
  PageCubit(this._repository) : super(PageState());

  final AuthRepository _repository;

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
    log.w("password= ${states.password}, repeatPass=${states.repeatPassword}");
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
      await _repository.registerOrResetPassword(
        states.password,
        states.repeatPassword,
      );
      emitEvent(PageEvent(PageEventType.navigationToHome));
    } catch (e, stackTrace) {
      log.e(e.toString(), error: e, stackTrace: stackTrace);
    } finally {
      updateState((state) => state.copyWith(loading: false));
    }
  }
}
