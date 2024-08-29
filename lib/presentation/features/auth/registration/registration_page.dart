import 'package:El_xizmati/core/extensions/text_extensions.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:El_xizmati/core/gen/assets/assets.gen.dart';
import 'package:El_xizmati/core/gen/localization/strings.dart';
import 'package:El_xizmati/presentation/router/app_router.dart';
import 'package:El_xizmati/presentation/support/cubit/base_page.dart';
import 'package:El_xizmati/presentation/support/extensions/color_extension.dart';
import 'package:El_xizmati/presentation/support/extensions/controller_exts.dart';
import 'package:El_xizmati/presentation/support/extensions/mask_formatters.dart';
import 'package:El_xizmati/presentation/widgets/button/custom_elevated_button.dart';
import 'package:El_xizmati/presentation/widgets/button/custom_text_button.dart';
import 'package:El_xizmati/presentation/widgets/form_field/custom_text_form_field.dart';
import 'package:El_xizmati/presentation/widgets/form_field/label_text_field.dart';
import 'package:El_xizmati/presentation/widgets/form_field/validator/birth_date_validator.dart';
import 'package:El_xizmati/presentation/widgets/form_field/validator/doc_number_validator.dart';
import 'package:El_xizmati/presentation/widgets/form_field/validator/doc_series_validator.dart';
import 'package:El_xizmati/presentation/widgets/form_field/validator/password_confirm_validator.dart';
import 'package:El_xizmati/presentation/widgets/form_field/validator/password_validator.dart';
import 'package:url_launcher/url_launcher.dart';

import 'registration_cubit.dart';

@RoutePage()
class RegistrationPage
    extends BasePage<RegistrationCubit, RegistrationState, RegistrationEvent> {
  final String phoneNumber;

  RegistrationPage({
    super.key,
    required this.phoneNumber,
  });

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _docNumberController = TextEditingController();
  final TextEditingController _docSeriesController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void onWidgetCreated(BuildContext context) {
    cubit(context).setInitialParams(phoneNumber);
  }

  @override
  void onEventEmitted(BuildContext context, RegistrationEvent event) {
    switch (event.type) {
      case RegistrationEventType.onOpenOtpConfirm:
        context.router.push(OtpConfirmationRoute(
          phoneNumber: cubit(context).states.phoneNumber,
        ));
    }
  }

  @override
  Widget onWidgetBuild(BuildContext context, RegistrationState state) {
    _birthDateController.updateOnRestore(birthDateMaskFormatter.formatString(state.brithDate));
    _docNumberController.updateOnRestore(docNumberMaskFormatter.formatString(state.docNumber));
    _docSeriesController.updateOnRestore(state.docSeries.toUpperCase());
    _passwordController.updateOnRestore(state.password);
    _confirmController.updateOnRestore(state.confirm);

    return Scaffold(
      backgroundColor: context.backgroundWhiteColor,
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
          child: AutofillGroup(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height*0.06),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Assets.images.pngImages.appLogo.image(width: 64, height: 64),
                      SizedBox(width: 10),
                      Column(children: [
                        Text("el xizmati").w(700).s(32).c(Color(0xFF703EDB)),
                        Text("ishchilar jamiyati").w(300).s(18).c(Color(0xFF2A174E)),
                      ],)
                    ],),
                  SizedBox(height: 30),
                  Text("Shaxsingizni tasdiqlovchi ma'lumotlaringizni kiriting").w(700).s(20).c(Color(0xFF2A174E)).copyWith(textAlign: TextAlign.center),
                  SizedBox(height: 30),

                  /// name
                  LabelTextField("Ismingiz"),
                  SizedBox(height: 8),
                  CustomTextFormField(
                    autofillHints: const [AutofillHints.name],
                    inputType: TextInputType.name,
                    keyboardType: TextInputType.name,
                    maxLines: 1,
                   hint: "Ismingiz",
                   // label: state.phoneNumber,
                    controller: _firstNameController,
                    onChanged: (value) {},
                  ),
                  ///
                  LabelTextField(Strings.commonDocInfo),
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
                          validator: (v) => DocSeriesValidator.validate(v),
                          onChanged: (value) {
                            cubit(context).setDocSeries(value);
                          },
                        ),
                      ),
                      SizedBox(width: 12),
                      Flexible(
                        child: CustomTextFormField(
                          hint: "123-45-67",
                          maxLength: 9,
                          textInputAction: TextInputAction.next,
                          inputType: TextInputType.number,
                          controller: _docNumberController,
                          inputFormatters: docNumberMaskFormatter,
                          validator: (v) => DocNumberValidator.validate(v),
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
                        validator: (v) => BirthDateValidator.validate(v),
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
                              showDefaultDatePickerDialog(
                                context,
                                selectedDate:
                                    DateTime.tryParse(state.brithDate),
                                onDateSelected: (date) {
                                  _birthDateController.text = date;
                                  cubit(context).setBrithDate(date);
                                },
                              );
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
                    validator: (value) => PasswordValidator.validate(value),
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
                    validator: (value) => PasswordConfirmValidator.validate(
                        _passwordController.value.text, value),
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
                      if (_formKey.currentState?.validate() == true) {
                        TextInput.finishAutofillContext(shouldSave: true);
                        cubit(context).requestCreateAccount();
                      }
                    },
                    isLoading: state.isLoading,
                  ),
                  SizedBox(height: 16),
                  RichText(
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
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
