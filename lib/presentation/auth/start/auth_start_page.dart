
import 'dart:io';


import 'package:auto_route/auto_route.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/assets/assets.gen.dart';
import 'package:onlinebozor/common/gen/localization/strings.dart';
import 'package:onlinebozor/common/router/app_router.dart';
import 'package:onlinebozor/common/widgets/bottom_sheet/botton_sheet_for_result.dart';
import 'package:onlinebozor/common/widgets/button/custom_elevated_button.dart';
import 'package:onlinebozor/common/widgets/button/custom_outlined_button.dart';
import 'package:onlinebozor/common/widgets/text_field/custom_text_form_field.dart';
import 'package:onlinebozor/presentation/auth/confirm/auth_confirm_page.dart';
import 'package:onlinebozor/presentation/auth/e_imzo/e-imzo_enter/crc32.dart';
import 'package:onlinebozor/presentation/auth/e_imzo/e-imzo_enter/gost_hash.dart';
import 'package:onlinebozor/presentation/auth/start/cubit/page_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../common/widgets/app_bar/default_app_bar.dart';
import '../../utils/mask_formatters.dart';
import 'package:url_launcher/url_launcher.dart';


@RoutePage()
class AuthStartPage extends BasePage<PageCubit, PageState, PageEvent> {
  AuthStartPage({super.key});

  @override
  void onEventEmitted(BuildContext context, PageEvent event) {
    switch (event.type) {
      case PageEventType.verification:
        context.router.push(AuthVerificationRoute(phone: event.phone!));
      case PageEventType.confirmation:
        context.router.push(
          AuthConfirmRoute(
            phone: event.phone!,
            confirmType: ConfirmType.confirm,
          ),
        );
      case PageEventType.onFailureEImzo:
        context.showErrorBottomSheet(context,Strings.loadingStateError,Strings.authStartLoginWithEImzoError);
      case PageEventType.navigationHome:
        context.router.replace(HomeRoute());
    }
  }

  @override
  void onWidgetCreated(BuildContext context) {

  }

  final TextEditingController phoneController = TextEditingController();

  @override
  Widget onWidgetBuild(BuildContext context, PageState state) {
    return Scaffold(
      backgroundColor: context.colors.colorBackgroundPrimary,
      resizeToAvoidBottomInset: false,
      appBar: DefaultAppBar("", () => context.router.pop()),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: AutofillGroup(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(),
              Strings.authStartSingin
                  .w(500)
                  .s(24)
                  .c(context.colors.textPrimary),
              Spacer(),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Strings.commonPhoneNumber
                      .w(500)
                      .s(14)
                      .c(context.colors.textPrimary)),
              SizedBox(height: 10),
              CustomTextFormField(
                autofillHints: const [AutofillHints.telephoneNumber],
                inputType: TextInputType.phone,
                keyboardType: TextInputType.phone,
                maxLines: 1,
                prefixText: "+998 ",
                textInputAction: TextInputAction.done,
                controller: phoneController,
                inputFormatters: phoneMaskFormatter,
                onChanged: (value) {
                  cubit(context).setPhone(value);
                },
              ),
              Spacer(),
              CustomOutlinedButton(
                text: Strings.authStartLoginWithFaceId,
                onPressed: () {
                  context.router.push(FaceIdValidateRoute());
                },
                strokeColor: context.colors.borderColor,
                rightIcon: Assets.images.icFaceId.svg(),
              ),
              SizedBox(height: 10),
              CustomOutlinedButton(
                text: Strings.authStartLoginWithOneId,
                onPressed: () => context.router.push(AuthWithOneIdRoute()),
                strokeColor: context.colors.borderColor,
                rightIcon: Assets.images.icOneId.svg(),
              ),
              SizedBox(height: 10),
              CustomOutlinedButton(
                text: Strings.authStartLoginWithEImzo,
                onPressed: () {
                  cubit(context).loginWithEImzo().then((value) {
                    enter(value?.challange??"", value?.siteId??"", value?.documentId??"", context);
                  });
                },
                strokeColor: context.colors.borderColor,
                rightIcon: Assets.images.pngImages.eImzo.image(),
              ),
              SizedBox(height: 24),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text:   Strings.authPricePoliceStart,
                      style: TextStyle(
                          color: Color(0xFF9EABBE),
                          fontSize: 12,
                          fontWeight: FontWeight.w400
                      ),
                    ),
                    TextSpan(text: " "),
                    TextSpan(
                      text: Strings.authPricePoliceAction,
                      style: TextStyle(
                          color: Color(0xFF5C6AC4),
                          fontSize: 12,
                          fontWeight: FontWeight.w400
                      ),
                      recognizer: TapGestureRecognizer()..onTap = _handleTextClick,
                    ),
                    TextSpan(text: " "),
                    TextSpan(
                      text: Strings.authPricePoliceEnd,
                      style: TextStyle(
                          color: Color(0xFF9EABBE),
                          fontSize: 12,
                          fontWeight: FontWeight.w400
                      ),
                    ),

                  ],
                ),
              ),
              SizedBox(height: 10,),
              CustomElevatedButton(
                text: Strings.commonContinue,
                onPressed: () => cubit(context).validation(),
                backgroundColor: context.colors.buttonPrimary,
                isEnabled: state.validation,
                isLoading: state.loading,
              )
            ],
          ),
        ),
      ),
    );
  }
  void _handleTextClick() async{
    try {
      var url = Uri.parse("https://online-bozor.uz/uz/page/privacy");
      await launchUrl(url);
    } catch (error) {
    }
  }

  void enterWithEimzo(String code) async {
    await LaunchApp.openApp(
      iosUrlScheme: 'eimzo://sign?qc=$code',
      appStoreLink:
      'itms-apps://itunes.apple.com/us/app/e-imzo-id-карта/id1563416406',
      // openStore: false
    );
  }

  void getAppPlayMarket() async {
    await LaunchApp.openApp(
      androidPackageName: 'uz.yt.idcard.eimzo',
      iosUrlScheme: 'eimzo://',
      appStoreLink:
      'itms-apps://itunes.apple.com/us/app/e-imzo-id-карта/id1563416406',
      // openStore: false
    );
  }

  void enter(String challange, String siteId, String documentId, BuildContext context) {
    var docHash = GostHash.hashGost(challange);
    var code = siteId + documentId + docHash;
    var crc32 = Crc32.calcHex(code);
    code += crc32;
    if (Platform.isAndroid) {
      var _deepLink = 'eimzo://sign?qc=$code';
      _launchURL(_deepLink);
      cubit(context).checkStatusEImzo(documentId);
    } else {
      enterWithEimzo(code);
    }
  }

  void _launchURL(String url) async {
    if (await canLaunchUrl(
      Uri.parse(url),
    )) {
      await launchUrl(
        Uri.parse(url),
        mode: LaunchMode.externalApplication,
      );
    } else {
      getAppPlayMarket();
      throw 'Ишга туширилмади $url';
    }
  }

}
