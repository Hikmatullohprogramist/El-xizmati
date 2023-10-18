import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/core/base_cubit.dart';
import 'package:onlinebozor/presentation/auth/confirm/confirm_page.dart';

import '../../../../domain/repo/auth_repository.dart';

part 'confirm_cubit.freezed.dart';

part 'confirm_state.dart';

@injectable
class ConfirmCubit extends BaseCubit<ConfirmBuildable, ConfirmListenable> {
  ConfirmCubit(this._repository) : super(ConfirmBuildable());

  final AuthRepository _repository;

  void setPhone(String phone, ConfirmType confirmType) {
    build((buildable) =>
        buildable.copyWith(phone: phone, confirmType: confirmType));
  }

  void setCode(String code) {
    build((buildable) =>
        buildable.copyWith(code: code, enable: code.length >= 4));
  }

  Future<void> register() async {
    build((buildable) => buildable.copyWith(loading: true));
    try {
      await _repository.register(buildable.phone, buildable.code);
    } catch (e, stackTrace) {
      log.e(e.toString(), error: e, stackTrace: stackTrace);
      display.error(e.toString());
    } finally {
      build((buildable) => buildable.copyWith(loading: false));
    }
  }
}
