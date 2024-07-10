import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';
import 'package:onlinebozor/core/gen/assets/assets.gen.dart';
import 'package:onlinebozor/core/gen/localization/strings.dart';
import 'package:onlinebozor/presentation/router/app_router.dart';
import 'package:onlinebozor/presentation/support/cubit/base_page.dart';
import 'package:onlinebozor/presentation/support/extensions/color_extension.dart';
import 'package:onlinebozor/presentation/support/extensions/controller_exts.dart';
import 'package:onlinebozor/presentation/support/extensions/mask_formatters.dart';
import 'package:onlinebozor/presentation/support/extensions/platform_sizes.dart';
import 'package:onlinebozor/presentation/widgets/app_bar/default_app_bar.dart';
import 'package:onlinebozor/presentation/widgets/button/custom_elevated_button.dart';
import 'package:onlinebozor/presentation/widgets/button/custom_text_button.dart';
import 'package:onlinebozor/presentation/widgets/form_field/custom_text_form_field.dart';
import 'package:onlinebozor/presentation/widgets/form_field/label_text_field.dart';

import 'registration_cubit.dart';

@RoutePage()
class RegistrationPage
    extends BasePage<RegistrationCubit, RegistrationState, RegistrationEvent> {
  final String phone;

   RegistrationPage({
    super.key,
    required this.phone,
  });

  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _docNumberController = TextEditingController();
  final TextEditingController _docSeriesController = TextEditingController();

  @override
  void onWidgetCreated(BuildContext context) {
    cubit(context).setInitialParams(phone);
  }

  @override
  void onEventEmitted(BuildContext context, RegistrationEvent event) {
    switch (event.type) {
      case RegistrationEventType.onOpenOtpConfirm:
        context.router.replace(HomeRoute());
    }
  }

  @override
  Widget onWidgetBuild(BuildContext context, RegistrationState state) {
    _birthDateController
        .updateOnRestore(birthDateMaskFormatter.formatString(state.brithDate));
    _docNumberController
        .updateOnRestore(docNumberMaskFormatter.formatString(state.docNumber));
    _docSeriesController.updateOnRestore(state.docSeries.toUpperCase());

    return Scaffold(
      backgroundColor: context.backgroundWhiteColor,
      resizeToAvoidBottomInset: false,
      appBar: DefaultAppBar(
        titleText: Strings.authRegisterRegister,
        titleTextColor: context.textPrimary,
        backgroundColor: context.backgroundGreyColor,
        onBackPressed: () => context.router.pop(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: AutofillGroup(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 24),
              LabelTextField(Strings.profileEditBiometricInformation),
              SizedBox(height: 8),
              Row(
                children: [
                  SizedBox(
                    width: 60,
                    child: CustomTextFormField(
                      hint: "AA",
                      maxLength: 2,
                      inputType: TextInputType.text,
                      textCapitalization: TextCapitalization.characters,
                      textInputAction: TextInputAction.next,
                      controller: _docSeriesController,
                      onChanged: (value) {
                        cubit(context).setDocSeries(value);
                      },
                    ),
                  ),
                  SizedBox(width: 12),
                  Flexible(
                    child: CustomTextFormField(
                      hint: "0123456",
                      maxLength: 9,
                      textInputAction: TextInputAction.next,
                      inputType: TextInputType.number,
                      controller: _docNumberController,
                      inputFormatters: docNumberMaskFormatter,
                      onChanged: (value) {
                        cubit(context).setDocNumber(value);
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              LabelTextField(Strings.profileEditBrithDate),
              SizedBox(height: 8),
              Stack(
                alignment: Alignment.centerRight,
                children: [
                  CustomTextFormField(
                    inputType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    inputFormatters: birthDateMaskFormatter,
                    hint: "2004-11-28",
                    maxLength: 12,
                    controller: _birthDateController,
                    onChanged: (value) {
                      cubit(context).setBrithDate(value);
                    },
                  ),
                  Container(
                    width: 42,
                    height: 42,
                    margin: EdgeInsets.only(right: 6, bottom: 6),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(6),
                        onTap: () {
                          showDatePickerDialog(context);
                          HapticFeedback.lightImpact();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(6),
                          child: Assets.images.icCalendar.svg(
                            width: 20,
                            height: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              LabelTextField(Strings.commonPhoneNumber),
              SizedBox(height: 8),
              CustomTextFormField(
                autofillHints: const [AutofillHints.telephoneNumber],
                enabled: false,
                readOnly: true,
                maxLines: 1,
                prefixText: "+998",
                label: state.phoneNumber,
                onChanged: (value) {},
              ),
              SizedBox(height: 23),
              LabelTextField(Strings.authCommonPassword),
              SizedBox(height: 8),
              CustomTextFormField(
                autofillHints: const [AutofillHints.password],
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.next,
                obscureText: true,
                inputType: TextInputType.visiblePassword,
                maxLines: 1,
                onChanged: (value) {
                  cubit(context).setPassword(value);
                },
                // controller: textController,
              ),
              SizedBox(height: 12),
              LabelTextField(Strings.authRegisterRepeatPassword),
              SizedBox(height: 8),
              CustomTextFormField(
                autofillHints: const [AutofillHints.password],
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.done,
                readOnly: false,
                maxLines: 1,
                obscureText: true,
                onChanged: (value) {
                  cubit(context).setConfirmPassword(value);
                },
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: CustomTextButton(
                  text: Strings.authRegisterPasswordContainLeastCharacters,
                  onPressed: () {},
                ),
              ),
              CustomElevatedButton(
                text: Strings.authRegisterRegister,
                onPressed: () {
                  TextInput.finishAutofillContext(shouldSave: true);
                  cubit(context).requestCreateAccount();
                },
                isEnabled: state.enabled,
                isLoading: state.loading,
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
