import 'dart:async';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/core/gen/assets/assets.gen.dart';
import 'package:onlinebozor/core/gen/localization/strings.dart';
import 'package:onlinebozor/presentation/features/auth/eds_request/crc32.dart';
import 'package:onlinebozor/presentation/features/auth/eds_request/gost_hash.dart';
import 'package:onlinebozor/presentation/router/app_router.dart';
import 'package:onlinebozor/presentation/support/cubit/base_page.dart';
import 'package:onlinebozor/presentation/support/extensions/color_extension.dart';
import 'package:onlinebozor/presentation/support/extensions/controller_exts.dart';
import 'package:onlinebozor/presentation/support/extensions/mask_formatters.dart';
import 'package:onlinebozor/presentation/widgets/app_bar/default_app_bar.dart';
import 'package:onlinebozor/presentation/widgets/button/custom_elevated_button.dart';
import 'package:onlinebozor/presentation/widgets/button/custom_outlined_button.dart';
import 'package:onlinebozor/presentation/widgets/elevation/elevation_widget.dart';
import 'package:onlinebozor/presentation/widgets/form_field/custom_text_form_field.dart';
import 'package:onlinebozor/presentation/widgets/form_field/label_text_field.dart';
import 'package:url_launcher/url_launcher.dart';

import 'auth_start_cubit.dart';

@RoutePage()
class AuthStartPage
    extends BasePage<AuthStartCubit, AuthStartState, AuthStartEvent> {
  AuthStartPage({super.key, this.phone});

  final String? phone;

  final TextEditingController _phoneController = TextEditingController();

  @override
  void onWidgetCreated(BuildContext context) {
    cubit(context).setPhone(phone ?? "");
  }

  @override
  void onEventEmitted(BuildContext context, AuthStartEvent event) {
    switch (event.type) {
      case AuthStartEventType.onOpenLogin:
        context.router.push(LoginRoute(phoneNumber: event.phone!));
      case AuthStartEventType.onOpenRegister:
        context.router.push(RegistrationRoute(phoneNumber: event.phone!));
      case AuthStartEventType.onEdsLoginFailed:
        showErrorBottomSheet(context, Strings.authStartLoginWithEImzoError);
      case AuthStartEventType.onOpenHome:
        context.router.replace(HomeRoute());
    }
  }

  @override
  Widget onWidgetBuild(BuildContext context, AuthStartState state) {
    _phoneController.updateOnRestore(state.phone);

    return Scaffold(
      backgroundColor: context.backgroundWhiteColor,
      resizeToAvoidBottomInset: false,
      appBar: DefaultAppBar(
        titleText: Strings.authStartSingin,
        titleTextColor: context.textPrimary,
        backgroundColor: context.appBarColor,
        onBackPressed: () => context.router.pop(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: AutofillGroup(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Spacer(),
              LabelTextField(Strings.commonPhoneNumber, isRequired: false),
              SizedBox(height: 8),
              CustomTextFormField(
                autofillHints: const [AutofillHints.telephoneNumber],
                inputType: TextInputType.phone,
                keyboardType: TextInputType.phone,
                maxLines: 1,
                hint: Strings.commonPhoneNumber,
                prefixText: "+998",
                textInputAction: TextInputAction.done,
                controller: _phoneController,
                inputFormatters: phoneMaskFormatter,
                onChanged: (value) {
                  cubit(context).setPhone(value);
                },
              ),
              SizedBox(height: 16),
              CustomElevatedButton(
                text: Strings.commonContinue,
                onPressed: () => cubit(context).validation(),
                backgroundColor: context.colors.buttonPrimary,
                isEnabled: state.validation,
                isLoading: state.loading,
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
                        ..onTap = _handleTextClick,
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
              Spacer(),
              ElevationWidget(
                topLeftRadius: 8,
                topRightRadius: 8,
                bottomLeftRadius: 8,
                bottomRightRadius: 8,
                topMargin: 12,
                bottomMargin: 6,
                child: CustomOutlinedButton(
                  text: Strings.authStartLoginWithFaceId,
                  onPressed: () {
                    context.router.push(FaceIdStartRoute());
                  },
                  rightIcon: Assets.images.icFaceId.svg(),
                ),
              ),
              ElevationWidget(
                topLeftRadius: 8,
                topRightRadius: 8,
                bottomLeftRadius: 8,
                bottomRightRadius: 8,
                topMargin: 6,
                bottomMargin: 6,
                child: CustomOutlinedButton(
                  text: Strings.authStartLoginWithOneId,
                  onPressed: () => context.router.push(OneIdRoute()),
                  rightIcon: Assets.images.icOneId.svg(),
                ),
              ),
              ElevationWidget(
                topLeftRadius: 8,
                topRightRadius: 8,
                bottomLeftRadius: 8,
                bottomRightRadius: 8,
                topMargin: 6,
                bottomMargin: 6,
                child: CustomOutlinedButton(
                  text: "Open SmartMarket App",
                  onPressed: () {
                    const deepLink = 'smartmarket://doc_sign_result?doc_id=123&sign_state=SIGNED';
                    _tryLaunchAndroidApp(deepLink, "uz.smartmarket.buyer");
                  },
                  rightIcon: Assets.images.icActiveDevice.svg(),
                ),
              ),
              ElevationWidget(
                topLeftRadius: 8,
                topRightRadius: 8,
                bottomLeftRadius: 8,
                bottomRightRadius: 8,
                topMargin: 6,
                bottomMargin: 20,
                child: CustomOutlinedButton(
                  text: Strings.authStartLoginWithEImzo,
                  onPressed: () {
                    cubit(context).edsAuth().then((value) {
                      _generateEdsQrCode(
                        context,
                        value?.challange ?? "",
                        value?.siteId ?? "",
                        value?.documentId ?? "",
                      );
                    });
                  },
                  // strokeColor: context.colors.borderColor,
                  rightIcon: Assets.images.pngImages.eImzo.image(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleTextClick() async {
    try {
      var url = Uri.parse("https://online-bozor.uz/uz/page/privacy");
      await launchUrl(url);
    } catch (error) {}
  }

  void _generateEdsQrCode(
    BuildContext context,
    String challenge,
    String siteId,
    String documentId,
  ) {
    var docHash = GostHash.hashGost(challenge);
    var qrCodeValue = siteId + documentId + docHash;
    var crc32 = Crc32.calcHex(qrCodeValue);
    qrCodeValue += crc32;

    final edsSignDeepLink = 'eimzo://sign?qc=$qrCodeValue';

    if (Platform.isAndroid) {
      _tryLaunchAndroidApp(edsSignDeepLink, "uz.yt.idcard.eimzo");
      cubit(context).edsCheckStatus(documentId);
    } else {
      _tryLaunchIosApp(edsSignDeepLink);
      cubit(context).edsCheckStatus(documentId);
    }
  }

  void _tryLaunchAndroidApp(
    String deepLink,
    String packageName,
  ) async {
    if (await canLaunchUrl(Uri.parse(deepLink))) {
      await launchUrl(
        Uri.parse(deepLink),
        mode: LaunchMode.externalApplication,
      );
    } else {
      await LaunchApp.openApp(
        androidPackageName: packageName,
        openStore: true
      );
      throw 'Ишга туширилмади $deepLink';
    }
  }

  void _tryLaunchIosApp(String deepLink) async {
    if (await canLaunchUrl(Uri.parse(deepLink))) {
      await launchUrl(Uri.parse(deepLink));
      Timer(Duration(seconds: 3), () async {
        await launchUrl(Uri.parse(deepLink));
      });
    } else {
      await LaunchApp.openApp(
        iosUrlScheme: deepLink,
        appStoreLink:
            'itms-apps://itunes.apple.com/us/app/e-imzo-id-карта/id1563416406',
        openStore: true
      );
    }
  }
}
