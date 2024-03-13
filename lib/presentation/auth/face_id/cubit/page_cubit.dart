import 'dart:math';

import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/core/base_state.dart';
import 'package:onlinebozor/domain/models/face_id/by_passport.dart';
import 'package:onlinebozor/domain/models/face_id/by_passportResponse.dart';

import '../../../../common/core/base_cubit.dart';
import '../../../../data/repositories/auth_repository.dart';

part 'page_cubit.freezed.dart';

part 'page_state.dart';

@injectable
class PageCubit extends BaseCubit<PageState, PageEvent> {
  PageCubit(this._repository) : super(const PageState());

  final AuthRepository _repository;

  void validation() async {
    updateState((state) => state.copyWith(loading: true));
    try {
       var res =await _repository.byPassport(ByPassportModel(
          passportSerial: states.passportSeries,
          passportNumber: states.passportNumber,
          birthDate: states.birthDate));
         final secretKey = ByPassportResponse.fromJson(res.data);
          if(res.statusCode==200){
            updateState((state) => state.copyWith(
              secretKey: secretKey.data.secretKey
            ));
            emitEvent(
              PageEvent(PageEventType.verification),
            );
          }else{
            emitEvent(
              PageEvent(PageEventType.error),
            );
          }
    } on DioException catch (e) {
      emitEvent( emitEvent(
        PageEvent(PageEventType.error),
      ));
      display.error(e.toString());
    } finally {
      updateState((state) => state.copyWith(loading: false));
    }
  }

  void validationByPinfl() async {
    updateState((state) => state.copyWith(loading: true));
    try {
      var res =await _repository.byPassportPinfl(states.passportPinfl);
      final secretKey = ByPassportResponse.fromJson(res.data);
      if(res.statusCode==200){
        updateState((state) => state.copyWith(
            secretKey: secretKey.data.secretKey
        ));
        emitEvent(
          PageEvent(PageEventType.verification),
        );
      }else{
        emitEvent(
          PageEvent(PageEventType.errorPinfl),
        );
      }
    } on DioException catch (e) {
      emitEvent( emitEvent(
        PageEvent(PageEventType.errorPinfl),
      ));
      display.error(e.toString());
    } finally {
      updateState((state) => state.copyWith(loading: false));
    }
  }

  void nextState() {
    updateState((state) =>
        state.copyWith(
            nextState: !states.nextState
        ));
  }

  void setBirthDate(String birthDate) {
    updateState((state) =>
        state.copyWith(
            birthDate: birthDate
        ));
  }

  void setPassportSeries(String passportSeries) {
    updateState((state) =>
        state.copyWith(
            passportSeries: passportSeries
        ));
  }

  void setPassportNumber(String passportNumber) {
    updateState(
          (state) => state.copyWith(
        passportNumber: passportNumber,
      ),
    );
  }

  void setPassportPinfl(String pinfl) {
    updateState(
          (state) => state.copyWith(
         passportPinfl: pinfl,
      ),
    );
  }

  bool enableButton() {
    if (states.passportSeries.length==2 &&
        states.passportNumber.length==7 &&
        states.birthDate != "dd.MM.yyyy") {
      return true;
    }
    return false;
  }

  bool enableButtonPinfl() {
    if (states.passportPinfl.length==14) {
      return true;
    }
    return false;
  }

}