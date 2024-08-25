import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:El_xizmati/data/datasource/network/responses/face_id/validate_bio_doc_request.dart';
import 'package:El_xizmati/data/datasource/network/responses/face_id/validate_bio_doc_response.dart';
import 'package:El_xizmati/data/repositories/auth_repository.dart';
import 'package:El_xizmati/presentation/support/cubit/base_cubit.dart';

part 'face_id_start_cubit.freezed.dart';
part 'face_id_start_state.dart';

@injectable
class FaceIdStartCubit extends BaseCubit<FaceIdStartState, FaceIdStartEvent> {
  FaceIdStartCubit(this._authRepository) : super(const FaceIdStartState());

  final AuthRepository _authRepository;

  void validateEnteredData() async {
    updateState((state) => state.copyWith(isRequestInProcess: true));
    try {
      String secretKey = "";
      if (states.isFaceIdByPinflEnabled) {
        var response = await _authRepository.validateByPinfl(states.pinfl);
        if (response.statusCode == 200) {
          secretKey =
              ValidateBioDocResponse.fromJson(response.data).data.secretKey;
        }
      } else {
        var response = await _authRepository.validateByBioDoc(
          ValidateBioDocRequest(
            docSeries: states.docSeries,
            docNumber: states.docNumber,
            birthDate: states.birthDate,
          ),
        );
        if (response.statusCode == 200) {
          secretKey =
              ValidateBioDocResponse.fromJson(response.data).data.secretKey;
        }
      }

      if (secretKey.isNotEmpty) {
        updateState((state) => state.copyWith(secretKey: secretKey));
        emitEvent(FaceIdStartEvent(FaceIdStartEventType.onVerificationSuccess));
      } else {
        emitEvent(FaceIdStartEvent(
          states.isFaceIdByPinflEnabled
              ? FaceIdStartEventType.onPinflNotFound
              : FaceIdStartEventType.onBioDocNotFound,
        ));
      }
    } catch (e) {
      emitEvent(FaceIdStartEvent(
        states.isFaceIdByPinflEnabled
            ? FaceIdStartEventType.onPinflNotFound
            : FaceIdStartEventType.onBioDocNotFound,
      ));
    } finally {
      updateState((state) => state.copyWith(isRequestInProcess: false));
    }
  }

  void changePinflEnabledState(bool isEnabled) {
    updateState((state) => state.copyWith(isFaceIdByPinflEnabled: isEnabled));
  }

  void setEnteredDocSeries(String docSeries) {
    updateState((state) => state.copyWith(docSeries: docSeries));
  }

  void setEnteredBioDocNumber(String docNumber) {
    updateState((state) => state.copyWith(docNumber: docNumber));
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
      return states.docSeries.length == 2 &&
          states.docNumber.length == 7 &&
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
