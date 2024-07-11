import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';
import 'package:onlinebozor/core/handler/future_handler_exts.dart';
import 'package:onlinebozor/data/repositories/auth_repository.dart';
import 'package:onlinebozor/presentation/support/cubit/base_cubit.dart';
import 'package:onlinebozor/presentation/support/extensions/extension_message_exts.dart';

part 'registration_cubit.freezed.dart';
part 'registration_state.dart';

@injectable
class RegistrationCubit
    extends BaseCubit<RegistrationState, RegistrationEvent> {
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
  }

  void setConfirmPassword(String repeatPassword) {
    updateState((state) => state.copyWith(confirm: repeatPassword));
  }

  Future<void> requestCreateAccount() async {
    _authRepository
        .registerRequestOtpCode(
          docSeries: states.docSeries,
          docNumber: states.docNumber,
          birthDate: states.brithDate,
          phoneNumber: states.phoneNumber.clearPhoneWithCode(),
          password: states.password,
          confirm: states.confirm,
        )
        .initFuture()
        .onStart(() {
          updateState((state) => state.copyWith(isLoading: true));
        })
        .onSuccess((data) {
          updateState((state) => state.copyWith(
                isLoading: false,
                sessionToken: data,
              ));
          emitEvent(RegistrationEvent(RegistrationEventType.onOpenOtpConfirm));
        })
        .onError((error) {
          logger.e(error.localizedMessage);
          updateState((state) => state.copyWith(isLoading: false));
          stateMessageManager.showErrorBottomSheet(error.localizedMessage);
        })
        .onFinished(() {})
        .executeFuture();
  }
}
