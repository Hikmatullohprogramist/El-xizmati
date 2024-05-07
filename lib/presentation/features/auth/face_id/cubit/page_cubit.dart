import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/core/cubit/base_cubit.dart';
import 'package:onlinebozor/data/datasource/network/responses/face_id/validate_bio_doc_request.dart';
import 'package:onlinebozor/data/datasource/network/responses/face_id/validate_bio_doc_response.dart';
import 'package:onlinebozor/data/repositories/auth_repository.dart';

part 'page_cubit.freezed.dart';
part 'page_state.dart';

@injectable
class PageCubit extends BaseCubit<PageState, PageEvent> {
  PageCubit(this._authRepository) : super(const PageState());

  final AuthRepository _authRepository;

  void validateEnteredData() async {
    updateState((state) => state.copyWith(isRequestInProcess: true));
    try {
      String secretKey = "";
      if (states.isFaceIdByPinflEnabled) {
        var response = await _authRepository.validateByPinfl(states.pinfl);
        if (response.statusCode == 200) {
          secretKey =
              ValidateBioDocResponse.fromJson(response.data).data.secret_key;
        }
      } else {
        var response = await _authRepository.validateByBioDoc(
          ValidateBioDocRequest(
            passport_serial: states.bioDocSerial,
            passport_number: states.bioDocNumber,
            birth_date: states.birthDate,
          ),
        );
        if (response.statusCode == 200) {
          secretKey =
              ValidateBioDocResponse.fromJson(response.data).data.secret_key;
        }
      }

      if (secretKey.isNotEmpty) {
        updateState((state) => state.copyWith(secretKey: secretKey));
        emitEvent(PageEvent(PageEventType.onVerificationSuccess));
      } else {
        emitEvent(PageEvent(
          states.isFaceIdByPinflEnabled
              ? PageEventType.onPinflNotFound
              : PageEventType.onBioDocNotFound,
        ));
      }
    } catch (e) {
      emitEvent(PageEvent(
        states.isFaceIdByPinflEnabled
            ? PageEventType.onPinflNotFound
            : PageEventType.onBioDocNotFound,
      ));
    } finally {
      updateState((state) => state.copyWith(isRequestInProcess: false));
    }
  }

  void changePinflEnabledState(bool isEnabled) {
    updateState((state) => state.copyWith(isFaceIdByPinflEnabled: isEnabled));
  }

  void setEnteredBioDocSerial(String bioDocSerial) {
    updateState((state) => state.copyWith(bioDocSerial: bioDocSerial));
  }

  void setEnteredBioDocNumber(String bioDocNumber) {
    updateState((state) => state.copyWith(bioDocNumber: bioDocNumber));
  }

  void setEnteredPinfl(String pinfl) {
    updateState((state) => state.copyWith(pinfl: pinfl));
  }

  void setBirthDate(String birthDate) {
    updateState((state) => state.copyWith(birthDate: birthDate));
  }

  bool getButtonEnableState() {
    if (states.isFaceIdByPinflEnabled) {
      return states.pinfl.length == 14;
    } else {
      return states.bioDocSerial.length == 2 &&
          states.bioDocNumber.length == 7 &&
          states.birthDate != "dd.MM.yyyy";
    }
  }

  bool enableButtonPinfl() {
    if (states.pinfl.length == 14) {
      return true;
    }
    return false;
  }
}
