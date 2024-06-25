import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';
import 'package:onlinebozor/core/gen/assets/assets.gen.dart';
import 'package:onlinebozor/core/gen/localization/strings.dart';
import 'package:onlinebozor/presentation/router/app_router.dart';
import 'package:onlinebozor/presentation/support/cubit/base_page.dart';
import 'package:onlinebozor/presentation/support/extensions/color_extension.dart';
import 'package:onlinebozor/presentation/support/extensions/controller_exts.dart';
import 'package:onlinebozor/presentation/widgets/app_bar/default_app_bar.dart';
import 'package:onlinebozor/presentation/widgets/button/custom_elevated_button.dart';
import 'package:onlinebozor/presentation/widgets/form_field/custom_text_form_field.dart';
import 'package:onlinebozor/presentation/widgets/switch/custom_toggle.dart';

import 'face_id_start_cubit.dart';

@RoutePage()
class FaceIdStartPage
    extends BasePage<FaceIdStartCubit, FaceIdStartState, FaceIdStartEvent> {
  FaceIdStartPage({super.key});

  final bioDocNumberController = TextEditingController();
  final bioDocSerialController = TextEditingController();
  final pinflController = TextEditingController();

  @override
  void onEventEmitted(BuildContext context, FaceIdStartEvent event) {
    switch (event.type) {
      case FaceIdStartEventType.onVerificationSuccess:
        context.router.push(FaceIdConfirmationRoute(
          secretKey: cubit(context).states.secretKey,
        ));
      case FaceIdStartEventType.onBioDocNotFound:
        showErrorBottomSheet(context, Strings.faceIdDocNotMatched);
      case FaceIdStartEventType.onPinflNotFound:
        showErrorBottomSheet(context, Strings.faceIdPinflNotFound);
    }
  }

  @override
  Widget onWidgetBuild(BuildContext context, FaceIdStartState state) {
    bioDocNumberController.updateOnRestore(state.bioDocNumber);
    bioDocSerialController.updateOnRestore(state.bioDocSerial);
    pinflController.updateOnRestore(state.pinfl);

    return Scaffold(
      appBar: DefaultAppBar(
        titleText: Strings.faceIdTitle,
        titleTextColor: context.textPrimary,
        backgroundColor: context.appBarColor,
        onBackPressed: () => context.router.pop(),
      ),
      backgroundColor: context.backgroundWhiteColor,
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16),
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
          // Expanded(child: Container()),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
            child: CustomElevatedButton(
              text: Strings.commonContinue,
              onPressed: () {
                if (!cubit(context).getButtonEnableState()) {
                  showErrorBottomSheet(
                      context, Strings.faceIdErrorInvalidFields);
                } else {
                  cubit(context).validateEnteredData();
                }
              },
              backgroundColor: context.colors.buttonPrimary,
              isLoading: state.isRequestInProcess,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPinflFields(BuildContext context, FaceIdStartState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 32),
          SizedBox(height: 64),
          SizedBox(height: 12),
          SizedBox(height: 16),
          Strings.commonPinfl.s(16).w(450),
          SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: CustomTextFormField(
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
          SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildBioDocFields(BuildContext context, FaceIdStartState state) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 32),
          Strings.profileUserDateOfDocValidity.s(16).w(450),
          SizedBox(height: 8),
          Row(
            children: [
              SizedBox(
                width: 60,
                child: CustomTextFormField(
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
              SizedBox(width: 12),
              Expanded(
                child: CustomTextFormField(
                  autofillHints: const [AutofillHints.telephoneNumber],
                  inputType: TextInputType.number,
                  keyboardType: TextInputType.phone,
                  maxLines: 1,
                  maxLength: 7,
                  controller: bioDocNumberController,
                  textInputAction: TextInputAction.done,
                  hint: "123 45 67",
                  onChanged: (value) {
                    cubit(context).setEnteredBioDocNumber(value);
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Strings.profileUserDateOfBirth.s(16).w(450),
          SizedBox(height: 10),
          Container(
            height: 48,
            width: double.infinity,
            decoration: BoxDecoration(
              color: context.inputBackgroundColor,
              borderRadius: BorderRadius.circular(7),
              border: Border.all(
                color: context.inputStrokeInactiveColor,
                width: 1.0,
              ),
            ),
            child: InkWell(
              onTap: () => showDatePickerDialog(context),
              child: Row(
                children: [
                  SizedBox(width: 15),
                  Assets.images.icCalendar.svg(height: 24, width: 24),
                  SizedBox(width: 10),
                  if (state.birthDate == "dd.mm.yyyy")
                    state.birthDate.w(500).s(16).c(context.textSecondary),
                  if (state.birthDate != "dd.mm.yyyy")
                    state.birthDate.w(400).s(15).c(context.textPrimary),
                ],
              ),
            ),
          ),
          SizedBox(height: 21),
        ],
      ),
    );
  }

  void showDatePickerDialog(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext buildContext) {
        return Container(
          decoration: BoxDecoration(
            color: context.bottomSheetColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 320,
                    child: CupertinoTheme(
                      data: CupertinoThemeData(brightness: context.brightness),
                      child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.date,
                        initialDateTime: DateTime(2000),
                        minimumYear: 1930,
                        maximumYear: 2024,
                        onDateTimeChanged: (DateTime newDateTime) {
                          final formattedDate =
                              DateFormat("yyyy-MM-dd").format(newDateTime);
                          cubit(context).setBirthDate(formattedDate);
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: CustomElevatedButton(
                      text: Strings.commonSave,
                      onPressed: () => Navigator.of(buildContext).pop(),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
