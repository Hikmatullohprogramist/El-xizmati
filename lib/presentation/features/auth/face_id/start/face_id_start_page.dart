import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:El_xizmati/core/extensions/text_extensions.dart';
import 'package:El_xizmati/core/gen/assets/assets.gen.dart';
import 'package:El_xizmati/core/gen/localization/strings.dart';
import 'package:El_xizmati/domain/models/faceid/face_id_confirm_type.dart';
import 'package:El_xizmati/presentation/router/app_router.dart';
import 'package:El_xizmati/presentation/support/cubit/base_page.dart';
import 'package:El_xizmati/presentation/support/extensions/color_extension.dart';
import 'package:El_xizmati/presentation/support/extensions/controller_exts.dart';
import 'package:El_xizmati/presentation/widgets/app_bar/default_app_bar.dart';
import 'package:El_xizmati/presentation/widgets/button/custom_elevated_button.dart';
import 'package:El_xizmati/presentation/widgets/form_field/custom_text_form_field.dart';
import 'package:El_xizmati/presentation/widgets/switch/custom_toggle.dart';
import 'package:url_launcher/url_launcher.dart';

import 'face_id_start_cubit.dart';

@RoutePage()
class FaceIdStartPage
    extends BasePage<FaceIdStartCubit, FaceIdStartState, FaceIdStartEvent> {
  FaceIdStartPage({super.key});

  final _birthDateController = TextEditingController();
  final _docNumberController = TextEditingController();
  final _docSeriesController = TextEditingController();
  final _pinflController = TextEditingController();

  @override
  void onEventEmitted(BuildContext context, FaceIdStartEvent event) {
    switch (event.type) {
      case FaceIdStartEventType.onVerificationSuccess:
        context.router.push(FaceIdConfirmationRoute(
          faceIdConfirmType: FaceIdConfirmType.forSingIn,
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
    _birthDateController.updateOnRestore(state.birthDate);
    _docNumberController.updateOnRestore(state.docNumber);
    _docSeriesController.updateOnRestore(state.docSeries);
    _pinflController.updateOnRestore(state.pinfl);

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
              negativeTitle: Strings.commonDocSeries,
              positiveTitle: Strings.commonPinfl,
            ),
          ),
          state.isFaceIdByPinflEnabled
              ? _buildPinflFields(context, state)
              : _buildBioDocFields(context, state),
          // Expanded(child: Container()),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
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
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: Strings.authPricePoliceStart,
                    style: TextStyle(
                      color: context.textPrimary,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextSpan(text: " "),
                  TextSpan(
                    text: Strings.authPricePoliceAction,
                    style: TextStyle(
                      color: Color(0xFF5C6AC4),
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async {
                        try {
                          var url = Uri.parse(
                            "https://online-bozor.uz/uz/page/privacy",
                          );
                          await launchUrl(url);
                        } catch (error) {
                          Logger().w("privacy policy launch error = $error");
                        }
                      },
                  ),
                  TextSpan(text: " "),
                  TextSpan(
                    text: Strings.authPricePoliceEnd,
                    style: TextStyle(
                      color: context.textPrimary,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
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
                  controller: _pinflController,
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
                  controller: _docSeriesController,
                  textCapitalization: TextCapitalization.characters,
                  textInputAction: TextInputAction.next,
                  onChanged: (value) {
                    cubit(context).setEnteredDocSeries(value);
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
                  controller: _docNumberController,
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
              onTap: () {
                showDefaultDatePickerDialog(
                  context,
                  selectedDate: DateTime.tryParse(state.birthDate),
                  onDateSelected: (date) {
                    cubit(context).setBirthDate(date);
                  },
                );
              },
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
}
