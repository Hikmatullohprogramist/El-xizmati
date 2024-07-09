import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';
import 'package:onlinebozor/data/repositories/auth_repository.dart';
import 'package:onlinebozor/presentation/support/cubit/base_cubit.dart';

part 'registration_cubit.freezed.dart';
part 'registration_state.dart';

@injectable
class RegistrationCubit extends BaseCubit<RegistrationState, RegistrationEvent> {
  RegistrationCubit(this._authRepository) : super(RegistrationState());

  final AuthRepository _authRepository;

  void setInitialParams(String phone) {
    updateState((state) => state.copyWith(
          phoneNumber: phone.clearPhoneWithoutCode(),
        ));
  }

  void setDocSeries(String docSeries) {
    updateState((state) => states.copyWith(docSeries: docSeries));
  }

  void setDocNumber(String docNumber) {
    updateState((state) => states.copyWith(
          docNumber: docNumber.replaceAll(" ", ""),
        ));
  }

  void setBrithDate(String brithDate) {
    updateState((state) => states.copyWith(brithDate: brithDate));
  }

  void setPassword(String password) {
    updateState((state) => state.copyWith(password: password));
    enable();
  }

  void setConfirmPassword(String repeatPassword) {
    updateState((state) => state.copyWith(confirm: repeatPassword));
    enable();
  }

  void enable() {
    logger.w("password = ${states.password}, confirm = ${states.confirm}");
    updateState((state) => state.copyWith(
          enabled: ((states.password.length >= 8) &&
              (states.confirm.length >= 8) &&
              (states.password == states.confirm)),
        ));
  }

  Future<void> requestCreateAccount() async {
    updateState((state) => state.copyWith(loading: true));
    try {
      await _authRepository.requestCreateAccount(
        docSeries: states.docSeries,
        docNumber: states.docNumber,
        birthDate: states.brithDate,
        phoneNumber: states.phoneNumber.clearPhoneWithCode(),
        password: states.password,
        confirm: states.confirm,
      );
      emitEvent(RegistrationEvent(RegistrationEventType.onOpenOtpConfirm));
    } catch (e, stackTrace) {
      logger.e(e.toString(), error: e, stackTrace: stackTrace);
    } finally {
      updateState((state) => state.copyWith(loading: false));
    }
  }
}
