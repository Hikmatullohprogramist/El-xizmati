import 'dart:developer';

import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/widgets/bottom_sheet/botton_sheet_for_result.dart';
import '../../../common/colors/static_colors.dart';
import '../../../common/core/base_page.dart';
import 'package:onlinebozor/presentation/auth/face_id/cubit/page_cubit.dart';

import '../../../common/gen/assets/assets.gen.dart';
import '../../../common/gen/localization/strings.dart';
import '../../../common/router/app_router.dart';
import '../../../common/widgets/app_bar/default_app_bar.dart';
import '../../../common/widgets/button/custom_elevated_button.dart';
import '../../../common/widgets/switch/custom_toggle.dart';
import '../../../common/widgets/text_field/common_text_field.dart';

@RoutePage()
class FaceIdPage extends BasePage<PageCubit, PageState, PageEvent> {
  FaceIdPage({
    super.key,
  });

  @override
  void onEventEmitted(BuildContext context, PageEvent event) {
    switch (event.type) {
      case PageEventType.verification:
        context.router.push(
            FaceDetectorRoute(secretKey: cubit(context).states.secretKey));
      case PageEventType.error:
        context.showErrorBottomSheet(context, Strings.loadingStateError,
            "Туғилган сана ва паспорт серия-рақамлари мувофиқ эмас");
      case PageEventType.errorPinfl:
        context.showErrorBottomSheet(context, Strings.loadingStateError,
            "Bunday JSHSHIRga ega shaxs topilmadi!");
    }
  }

  final TextEditingController passportNumber = TextEditingController();
  final TextEditingController passportSeries = TextEditingController();

  @override
  Widget onWidgetBuild(BuildContext context, PageState state) {
    return Scaffold(
      appBar: DefaultAppBar(
          "Face-ID orqali tizimga kirish", () => context.router.pop()),
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          SizedBox(height: 80),
          CustomToggle(
            width: 240,
            isChecked: true,
            onChanged: (isChecked) {
              cubit(context).nextState();
            },
            negativeTitle: "JSHSHIR",
            positiveTitle: "Series",
          ),
          if (cubit(context).states.nextState)
            Visibility(
              visible: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    height: 70,
                  ),
                  //   InkWell(
                  //    onTap: () {
                  //      cubit(context).nextState();
                  //    },
                  //    child: Container(
                  //      height: 48,
                  //      width: double.infinity,
                  //      decoration: BoxDecoration(
                  //        color: Color(0xFFFBFAFF),
                  //        borderRadius: BorderRadius.circular(7),
                  //        border: Border.all(
                  //          color: Color(0xFFDFE2E9),
                  //          width: 1.0,
                  //        ),
                  //      ),
                  //      child: Row(
                  //        crossAxisAlignment: CrossAxisAlignment.center,
                  //        mainAxisAlignment: MainAxisAlignment.start,
                  //        children: [
                  //          Checkbox(
                  //            value: true,
                  //            activeColor: StaticColors.slateBlue,
                  //            onChanged: (value) {
                  //              cubit(context).nextState();
                  //            },
                  //            checkColor: Colors.white,
                  //          ),
                  //          "Passport seriya va raqami bilan kirish"
                  //              .w(400)
                  //              .s(16)
                  //              .c(Colors.black),
                  //        ],
                  //      ),
                  //    ),
                  //  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    width: double.infinity,
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 35),
                        "Passport ma'lumotlari".w(450).s(16).c(Colors.black),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            SizedBox(
                              width: 60,
                              child: CommonTextField(
                                autofillHints: const [
                                  AutofillHints.telephoneNumber
                                ],
                                inputType: TextInputType.text,
                                keyboardType: TextInputType.phone,
                                maxLines: 1,
                                hint: "AA",
                                maxLength: 2,
                                controller: passportSeries,
                                textCapitalization: TextCapitalization.characters,
                                textInputAction: TextInputAction.done,
                                onChanged: (value) {
                                  cubit(context).setPassportSeries(value);
                                },
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: CommonTextField(
                                autofillHints: const [
                                  AutofillHints.telephoneNumber
                                ],
                                inputType: TextInputType.number,
                                keyboardType: TextInputType.phone,
                                maxLines: 1,
                                maxLength: 7,
                                controller: passportNumber,
                                hint: "*******",
                                onChanged: (value) {
                                  cubit(context).setPassportNumber(value);
                                },
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        "Tug'ulgan sana".w(400).s(16).c(Colors.black),
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
                                cubit(context)
                                    .states
                                    .birthDate
                                    .w(500)
                                    .s(16)
                                    .c(Color(0xFF9EABBE)),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 80),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:20),
                    child: CustomElevatedButton(
                      text: Strings.commonContinue,
                      onPressed: () {
                        cubit(context).validation();
                      },
                      backgroundColor: context.colors.buttonPrimary,
                      isEnabled: cubit(context).enableButton(),
                      isLoading: cubit(context).states.loading,
                    ),
                  )
                ],
              ),
            ),

          ///
          if (!cubit(context).states.nextState)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 100),
                //  "Face-ID orqali tizimga kirish".w(700).s(22).c(Colors.black),
                  SizedBox(height: 70),
                  SizedBox(height: 10),
                  "PINFL".w(500).s(16).c(Colors.black),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: CommonTextField(
                          autofillHints: const [AutofillHints.telephoneNumber],
                          inputType: TextInputType.number,
                          keyboardType: TextInputType.phone,
                          maxLines: 1,
                          maxLength: 14,
                          hint: "00000000000000",
                          textInputAction: TextInputAction.done,
                          onChanged: (value) {
                            cubit(context).setPassportPinfl(value);
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40),
               //  Container(
               //    height: 48,
               //    width: double.infinity,
               //    decoration: BoxDecoration(
               //      color: Color(0xFFFBFAFF),
               //      borderRadius: BorderRadius.circular(7),
               //      border: Border.all(
               //        color: Color(0xFFDFE2E9),
               //        width: 1.0,
               //      ),
               //    ),
               //    child: InkWell(
               //      onTap: () {
               //        cubit(context).nextState();
               //      },
               //      child: Row(
               //        crossAxisAlignment: CrossAxisAlignment.center,
               //        mainAxisAlignment: MainAxisAlignment.start,
               //        children: [
               //          Checkbox(
               //            value: false,
               //            activeColor: StaticColors.slateBlue,
               //            onChanged: (value) {
               //              cubit(context).nextState();
               //            },
               //            checkColor: Colors.white,
               //          ),
               //          "Passport seriya va raqami bilan kirish"
               //              .w(400)
               //              .s(16)
               //              .c(Colors.black),
               //        ],
               //      ),
               //    ),
               //  ),
                  SizedBox(
                    height: 60,
                  ),
                  CustomElevatedButton(
                    text: Strings.commonContinue,
                    onPressed: () {
                      cubit(context).validationByPinfl();
                    },
                    backgroundColor: context.colors.buttonPrimary,
                    isEnabled: cubit(context).enableButtonPinfl(),
                    isLoading: state.loading
                  )
                ],
              ),
            )
        ],
      ),
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
              color: Colors.white,
              height: 350.0,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: DateTime(2000),
                minimumYear: 1930,
                maximumYear: 2024,
                onDateTimeChanged: (DateTime newDateTime) {
                  final formattedDate =
                      DateFormat("yyyy-MM-dd").format(newDateTime);
                  cubit(parentContext).setBirthDate(formattedDate);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
