import 'package:onlinebozor/common/base/base_cubit.dart';
import 'package:onlinebozor/domain/repo/auth_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'verify_cubit.freezed.dart';

part 'verify_state.dart';

@injectable
class VerifyCubit extends BaseCubit<VerifyBuildable, VerifyListenable> {
  VerifyCubit(this._repository) : super(const VerifyBuildable());

  final AuthRepository _repository;

  void setPhone(String phone) {
    build((buildable) => buildable.copyWith(phone: phone));
  }

  void setCode(String code) {
    build((buildable) => buildable.copyWith(code: code));
  }

  Future<void> verify() async {
    build((buildable) => buildable.copyWith(loading: true));
    try {
      await _repository.verify(buildable.phone, buildable.code);
      invoke(VerifyListenable(VerifyEffect.success));
    } catch (e, stackTrace) {
      log.e(e.toString(), error: e, stackTrace: stackTrace);
      display.error(e.toString());
    } finally {
      build((buildable) => buildable.copyWith(loading: false));
    }
  }
}
