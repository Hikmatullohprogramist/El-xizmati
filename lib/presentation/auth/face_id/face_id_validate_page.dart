import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/controller/controller_exts.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/widgets/bottom_sheet/botton_sheet_for_result.dart';
import 'package:onlinebozor/presentation/auth/face_id/cubit/page_cubit.dart';

import '../../../common/core/base_page.dart';
import '../../../common/gen/assets/assets.gen.dart';
import '../../../common/gen/localization/strings.dart';
import '../../../common/router/app_router.dart';
import '../../../common/widgets/app_bar/default_app_bar.dart';
import '../../../common/widgets/button/custom_elevated_button.dart';
import '../../../common/widgets/switch/custom_toggle.dart';
import '../../../common/widgets/text_field/common_text_field.dart';

@RoutePage()
class FaceIdValidatePage extends BasePage<PageCubit, PageState, PageEvent> {
  FaceIdValidatePage({super.key});

  final bioDocNumberController = TextEditingController();
  final bioDocSerialController = TextEditingController();
  final pinflController = TextEditingController();

  @override
  void onEventEmitted(BuildContext context, PageEvent event) {
    switch (event.type) {
      case PageEventType.onVerificationSuccess:
        context.router.push(
          FaceIdIdentityRoute(secretKey: cubit(context).states.secretKey),
        );
      case PageEventType.onBioDocNotFound:
        context.showErrorBottomSheet(
          context,
          Strings.loadingStateError,
          Strings.faceIdDocNotMatched,
        );
      case PageEventType.onPinflNotFound:
        context.showErrorBottomSheet(
          context,
          Strings.loadingStateError,
          Strings.faceIdPinflNotFound,
        );
    }
  }

  @override
  Widget onWidgetBuild(BuildContext context, PageState state) {
    bioDocNumberController.updateOnRestore(state.bioDocNumber);
    bioDocSerialController.updateOnRestore(state.bioDocSerial);
    pinflController.updateOnRestore(state.pinfl);

    return Scaffold(
      appBar: DefaultAppBar(
        Strings.faceIdTitle,
        () => context.router.pop(),
      ),
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 16, top: 24, right: 16),
            child: CustomToggle(
              isChecked: state.isFaceIdByPinflEnabled,
              onChanged: (isChecked) {
                cubit(context).changePinflEnabledState(isChecked);
              },
              negativeTitle: Strings.commonBioDocSeries,
              positiveTitle: Strings.commonPinfl,
            ),
          ),
          state.isFaceIdByPinflEnabled
              ? _buildPinflFields(context, state)
              : _buildBioDocFields(context, state),
          Expanded(child: Container()),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CustomElevatedButton(
              text: Strings.commonContinue,
              onPressed: () {
                if(!cubit(context).getButtonEnableState()){
                  context.showErrorBottomSheet(
                      context,
                      Strings.loadingStateError,
                      Strings.faceIdErrorInvalidFields);
                }else{
                  cubit(context).validateEnteredData();
                }
              },
              backgroundColor: context.colors.buttonPrimary,
              isLoading: state.isRequestInProcess,
            ),
          ),
          SizedBox(height: 10,)
        ],
      ),
    );
  }

  Widget _buildPinflFields(BuildContext context, PageState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 100),
          SizedBox(height: 70),
          SizedBox(height: 10),
          Strings.commonPinfl.w(500).s(16).c(Colors.black),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: CommonTextField(
                  autofillHints: const [AutofillHints.telephoneNumber],
                  inputType: TextInputType.number,
                  keyboardType: TextInputType.phone,
                  controller: pinflController,
                  maxLines: 1,
                  maxLength: 14,
                  hint: Strings.commonPinflHint,
                  textInputAction: TextInputAction.done,
                  onChanged: (value) => cubit(context).setEnteredPinfl(value),
                ),
              ),
            ],
          ),
          SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildBioDocFields(BuildContext context, PageState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 35),
              Strings.profileUserDateOfDocValidity.w(450).s(16).c(Colors.black),
              SizedBox(height: 8),
              Row(
                children: [
                  SizedBox(
                    width: 60,
                    child: CommonTextField(
                      autofillHints: const [AutofillHints.telephoneNumber],
                      inputType: TextInputType.text,
                      keyboardType: TextInputType.phone,
                      maxLines: 1,
                      hint: "AA",
                      maxLength: 2,
                      controller: bioDocSerialController,
                      textCapitalization: TextCapitalization.characters,
                      textInputAction: TextInputAction.next,
                      onChanged: (value) {
                        cubit(context).setEnteredBioDocSerial(value);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: CommonTextField(
                      autofillHints: const [AutofillHints.telephoneNumber],
                      inputType: TextInputType.number,
                      keyboardType: TextInputType.phone,
                      maxLines: 1,
                      maxLength: 7,
                      controller: bioDocNumberController,
                      textInputAction: TextInputAction.done,
                      hint: "0123456",
                      onChanged: (value) {
                        cubit(context).setEnteredBioDocNumber(value);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                ],
              ),
              SizedBox(height: 10),
              Strings.profileUserDateOfBirth.w(400).s(16).c(Colors.black),
              SizedBox(height: 10),
              InkWell(
                onTap: () {
                  showDatePickerDialog(context);
                },
                child: Container(
                  height: 48,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xFFFBFAFF),
                    borderRadius: BorderRadius.circular(7),
                    border: Border.all(
                      color: Color(0xFFDFE2E9),
                      width: 1.0,
                    ),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 15,
                      ),
                      Assets.images.icCalendar.svg(height: 24, width: 24),
                      SizedBox(
                        width: 10,
                      ),
                      if(state.birthDate=="dd.mm.yyyy")
                        state.birthDate.w(500).s(16).c(Color(0xFF9EABBE)),
                      if(state.birthDate!="dd.mm.yyyy")
                        state.birthDate.w(400).s(15).c(Colors.black87),

                    ],
                  ),
                ),
              ),
              SizedBox(height: 80),
            ],
          ),
        ),
      ],
    );
  }

  void showDatePickerDialog(BuildContext context) {
    var parentContext = context;
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25),
                  topLeft: Radius.circular(25),
                ),
              ),
              height: 350.0,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: DateTime(2000),
                minimumYear: 1945,
                maximumYear: 2024,
                onDateTimeChanged: (DateTime newDateTime) {
                  final formattedDate =
                      DateFormat("yyyy-MM-dd").format(newDateTime);
                  cubit(parentContext).setBirthDate(formattedDate);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: CustomElevatedButton(
                text: Strings.commonSave,
                onPressed: () {
                  //  cubit(parent).enableButton(passportSeries.text, passportNumber.text, birthDate);
                  Navigator.of(context).pop();
                },
                backgroundColor: context.colors.buttonPrimary,
                isEnabled: true,
                isLoading: false,
              ),
            ),
            SizedBox(
              height: 12,
            ),
          ],
        );
      },
    );
  }
}
