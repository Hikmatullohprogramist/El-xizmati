import 'dart:developer' as profile_view_page;

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/localization/strings.dart';
import 'package:onlinebozor/common/router/app_router.dart';
import 'package:onlinebozor/common/widgets/app_bar/action_app_bar.dart';
import 'package:onlinebozor/common/widgets/button/custom_elevated_button.dart';
import 'package:onlinebozor/common/widgets/button/custom_text_button.dart';
import 'package:onlinebozor/common/widgets/dashboard/see_all_widget.dart';
import 'package:onlinebozor/common/widgets/device/active_session_widget.dart';
import 'package:onlinebozor/common/widgets/snackbar/snackbar_widget.dart';
import 'package:onlinebozor/domain/models/active_sessions/active_session.dart';

import '../../../../../../common/colors/static_colors.dart';
import '../../../../../../common/constants.dart';
import '../../../../../../common/gen/assets/assets.gen.dart';
import '../../../../../../common/widgets/device/active_session_shimmer.dart';
import '../../../../../../common/widgets/divider/custom_diverder.dart';
import '../../../../../../common/widgets/profile/profile_item_widget.dart';
import '../../../../../../common/widgets/switch/custom_switch.dart';
import 'cubit/page_cubit.dart';

@RoutePage()
class ProfileViewPage extends BasePage<PageCubit, PageState, PageEvent> {
  const ProfileViewPage({super.key});

  @override
  void onWidgetCreated(BuildContext context) {
    cubit(context).getUserInformation();
  }

  @override
  void onEventEmitted(BuildContext context, PageEvent event) {
    switch (event.type) {
      case PageEventType.onLogout:
        context.router.push(AuthStartRoute());
    }
  }

  @override
  Widget onWidgetBuild(BuildContext context, PageState state) {
    try {
      return Scaffold(
          appBar: ActionAppBar(
            titleText: Strings.profileViewTitlle,
            onBackPressed: () => context.router.pop(),
            actions: state.isRegistered
                ? [
              CustomTextButton(
                text: Strings.commonEdit,
                onPressed: () =>
                    context.router.replace(ProfileEditRoute()),
              )
            ]
                : [],
          ),
          backgroundColor: StaticColors.backgroundColor,
          body: Stack(
            children: [
              SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 12),
                        _getHeaderBlock(context, state),
                        SizedBox(height: 12),
                        _getBioBlock(context, state),
                        SizedBox(height: 12),
                        _buildNotificationBlock(context),
                        SizedBox(height: 12),
                        _buildSocialBlock(context),
                        SizedBox(height: 12),
                        _buildActiveDeviceBlock(context, state),
                        SizedBox(
                          height: 12,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: state.isLoading,
                child: Center(
                    child: CircularProgressIndicator(color: Colors.blue)),
              )
            ],
          ));
    } catch (e) {
      profile_view_page.log("profile view page render error $e");
      return Container();
    }
  }

  Widget _getHeaderBlock(BuildContext context, PageState state) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Strings.profilePersonalData.w(700).c(Color(0xFF41455E)).s(16),
          SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                width: 64,
                height: 64,
                imageUrl: "${Constants.baseUrlForImage}${state.photo}",
                imageBuilder: (context, imageProvider) =>
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: imageProvider,
                            colorFilter: ColorFilter.mode(
                                Color(0xFFF6F7FC), BlendMode.colorBurn)),
                      ),
                    ),
                placeholder: (context, url) =>
                    Container(
                      height: 64,
                      width: 64,
                      margin: EdgeInsets.only(top: 6),
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          color: Color(0xFFE0E0ED),
                          borderRadius: BorderRadius.circular(10)),
                      child: Assets.images.icAvatarBoy.svg(),
                    ),
                errorWidget: (context, url, error) =>
                    Container(
                      height: 64,
                      width: 64,
                      margin: EdgeInsets.only(top: 6),
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          color: Color(0xFFE0E0ED),
                          borderRadius: BorderRadius.circular(10)),
                      child: Assets.images.icAvatarBoy.svg(),
                    ),
              ),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8),
                  Row(
                    children: [
                      state.fullName
                          .w(600)
                          .s(12)
                          .c(Colors.black)
                          .copyWith(overflow: TextOverflow.ellipsis),
                      SizedBox(width: 8),
                      if (state.isRegistered)
                        Assets.images.icIdentified.svg()
                      else
                        Assets.images.icNotIdentified.svg()
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        padding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                        decoration: ShapeDecoration(
                          color: Color(0xFFAEB2CD).withAlpha(40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: Strings.profilePrivatePerson
                            .w(500)
                            .s(12)
                            .c(Color(0xFF999CB2)),
                      ),
                      SizedBox(width: 10),
                      CustomTextButton(
                        text: Strings.profileChangeToBusiness,
                        onPressed: () {},
                      )
                    ],
                  )
                ],
              )
            ],
          ),
          SizedBox(height: 6),
          /** Identification views started */
          if (!state.isRegistered)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  height: 42,
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  decoration: ShapeDecoration(
                    color: Color(0x1EAEB2CD),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Assets.images.icNotIdentified.svg(),
                        SizedBox(width: 10),
                        Strings.profileNotIdentified
                            .w(400)
                            .s(12)
                            .c(Color(0xFF9EABBE))
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 16),
                CustomElevatedButton(
                  text: Strings.profileIdentify,
                  onPressed: state.isRegistered
                      ? null
                      : () => context.router.replace(RegistrationRoute()),
                  buttonWidth: 120,
                )
              ],
            )
          else
            Container(
              height: 36,
              decoration: ShapeDecoration(
                color: Color(0x1E32B88B),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Assets.images.icIdentified.svg(),
                    SizedBox(width: 10),
                    Strings.profileIdentified.w(400).s(12).c(Color(0xFF32B88B))
                  ],
                ),
              ),
            )
          /** Identification views finished */
        ],
      ),
    );
  }

  Widget _getBioBlock(BuildContext context, PageState state) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Strings.profileUserDateOfBirth.w(400).s(14).c(Color(0xFF9EABBE)),
        SizedBox(height: 6),
        state.brithDate.w(500).s(16).c(Color(0xFF41455E)),
        SizedBox(height: 8),
        CustomDivider(),
        SizedBox(
          height: 8,
        ),
        Strings.profileUserDateOfDocValidity.w(400).s(14).c(Color(0xFF9EABBE)),
        SizedBox(height: 6),
        state.biometricInformation.w(500).s(16).c(Color(0xFF41455E)),
        SizedBox(height: 8),
        CustomDivider(),
        SizedBox(height: 8),
        Strings.profileUserEmail.w(400).s(14).c(Color(0xFF9EABBE)),
        SizedBox(height: 6),
        //state.email.w(500).s(16).c(Color(0xFF41455E)),
        if (state.email.isNotEmpty)
          state.email.w(500).s(16).c(Color(0xFF41455E)),
        if (state.email.isEmpty)
          "name@gmail.com".w(400).s(15).c(Color(0xFF9EABBE)),
        SizedBox(height: 8),
        CustomDivider(),
        SizedBox(height: 8),
        Strings.profileUserPhone.w(400).s(14).c(Color(0xFF9EABBE)),
        SizedBox(height: 6),
        state.phoneNumber.w(500).s(16).c(Color(0xFF41455E)),
        SizedBox(height: 8),
        CustomDivider(),
        SizedBox(height: 8),
        "Manzil".w(400).s(14).c(Color(0xFF9EABBE)),
        SizedBox(height: 6),
        Row(
          children: [
            state.regionName.w(500).s(16).c(Color(0xFF41455E)),
            ".".w(500).s(16).c(Color(0xFF41455E)),
            SizedBox(
              width: 7,
            ),
            state.districtName.w(500).s(16).c(Color(0xFF41455E)),
            SizedBox(
              width: 7,
            ),
            state.streetName.w(500).s(16).c(Color(0xFF41455E)),
          ],
        ),
        SizedBox(height: 5),
      ]),
    );
  }

  Widget _getSettingsBlock(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          Divider(indent: 46, height: 1),
          ProfileItemWidget(
            name: Strings.settingsReceiveNotification,
            icon: Assets.images.icProfileNotification,
            invoke: () => context.router.push(NotificationSettingsRoute()),
          ),
          Divider(indent: 46, height: 1),
          ProfileItemWidget(
            name: Strings.settingsSocialNetwork,
            icon: Assets.images.icSocialNetwork,
            invoke: () {
              // context.router.push(UserSocialNetworkRoute())
            },
          ),
          Divider(indent: 46, height: 1),
          ProfileItemWidget(
            name: Strings.settingsActiveDevices,
            icon: Assets.images.icActiveDevice,
            invoke: () => context.router.push(UserActiveSessionsRoute()),
          ),
          // Divider(indent: 46, height: 1),
          // ProfileItemWidget(
          //   name: Strings.settingsChangePassword,
          //   icon: Assets.images.icChangePassword,
          //   invoke: () {},
          // )
        ],
      ),
    );
  }

  Widget _buildNotificationBlock(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 18),
          "Способ получения уведомления".w(600).s(14).c(Color(0xFF41455E)),
          SizedBox(height: 18),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              side: BorderSide(
                  color: cubit(context).states.smsNotification
                      ? Color(0xFF5C6AC4)
                      : Color(0xFFAEB2CD)),
            ),
            onPressed: () {
              // cubit(context).setSmsNotification();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xFF5C6AC3)),
                  child: Center(child: Assets.images.icMessage.svg()),
                ),
                SizedBox(width: 16),
                Strings.notificationReceiveSms
                    .w(600)
                    .s(14)
                    .c(Color(0xFF41455E)),
                Expanded(
                    child: SizedBox(
                  height: 1,
                )),
                CustomSwitch(
                  isChecked: cubit(context).states.smsNotification,
                  onChanged: (value) {
                    cubit(context).setSmsNotification();
                  },
                ),
              ]),
            ),
          ),
          SizedBox(height: 10),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              side: BorderSide(
                  color: cubit(context).states.emailNotification
                      ? Color(0xFF5C6AC4)
                      : Color(0xFFAEB2CD)),
            ),
            onPressed: () {
              // cubit(context).setEmailNotification();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFFDFE2E9), width: 1),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white),
                  child: Center(child: Assets.images.icSms.svg()),
                ),
                SizedBox(width: 16),
                Strings.notificationReceiveEmail
                    .w(600)
                    .s(14)
                    .c(Color(0xFF41455E)),
                Expanded(
                    child: SizedBox(
                  height: 1,
                )),
                CustomSwitch(
                  isChecked: cubit(context).states.emailNotification,
                  onChanged: (value) {
                    cubit(context).setEmailNotification();
                  },
                ),
              ]),
            ),
          ),
          SizedBox(height: 10),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              side: BorderSide(
                  color: cubit(context).states.telegramNotification
                      ? Color(0xFF5C6AC4)
                      : Color(0xFFAEB2CD)),
            ),
            onPressed: () {
              // cubit(context).setTelegramNotification();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(children: [
                Assets.images.icTelegram.svg(height: 32, width: 32),
                SizedBox(width: 16),
                Strings.notificationReceiveTelegram
                    .w(600)
                    .s(14)
                    .c(Color(0xFF41455E)),
                Expanded(
                    child: SizedBox(
                  height: 1,
                )),
                CustomSwitch(
                  isChecked: cubit(context).states.telegramNotification,
                  onChanged: (value) {
                    cubit(context).setTelegramNotification();
                  },
                ),
              ]),
            ),
          ),
          SizedBox(height: 12),
          Text.rich(TextSpan(children: [
            TextSpan(
                text: Strings.telegramBotDescription,
                style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: Color(0xFF9EABBE))),
            WidgetSpan(
                child: SizedBox(
              width: 5,
            )),
            TextSpan(
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    cubit(context).openTelegram();
                  },
                text: Strings.linkTitle,
                style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: Color(0xFF5C6AC3)))
          ])),
          SizedBox(height: 15),
          CustomElevatedButton(
            text: Strings.commonSaveChanges,
            isLoading: cubit(context).states.isLoadingNotification,
            isEnabled: !cubit(context)
                .states
                .enableButton
                .every((element) => element == false),
            onPressed: () async {
              var result = await cubit(context).setMessageType("");
              if (result) {
                context.showCustomSnackBar(
                    message: 'Saved!', backgroundColor: Colors.green.shade400);
                cubit(context).clearList();
              } else {
                context.showCustomSnackBar(
                    message: "Do'nt save",
                    backgroundColor: Colors.red.shade400);
              }
            },
            buttonHeight: 45,
            textSize: 12,
          ),
          SizedBox(height: 18),
        ],
      ),
    );
  }

  Widget _buildSocialBlock(BuildContext context) {
    TextEditingController _textEditingController = TextEditingController();
    // var a=state(context).telegram;
    //_textEditingController.text="https://www.instagram.com/";
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 18),
          "Менинг ижтимоий тармоқларим".w(600).s(14).c(Color(0xFF41455E)),
          SizedBox(height: 18),
          SizedBox(height:5,),
          Stack(
            alignment: Alignment.centerRight,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 30),
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    side: BorderSide(
                        color: cubit(context).states.smsNotification
                            ? Color(0xFF5C6AC4)
                            : Color(0xFFAEB2CD)),
                  ),
                  onPressed: () {
                    // cubit(context).setSmsNotification();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 7),
                    child: Row(children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xFF5C6AC3)),
                        child: Center(child: Image(
                          image: AssetImage('assets/images/png_images/instagram.png'),
                        )),
                      ),
                      SizedBox(width: 16),
                       Expanded(
                         child: TextField(
                           controller:_textEditingController,
                           style: TextStyle(fontSize: 14),
                           decoration: InputDecoration(
                             border: InputBorder.none,
                             hintText: "https://www.instagram.com/"
                           ),
                         ),
                       ),
                      Image.asset(
                        'assets/images/clock_social.png',
                        width: 24,
                        height: 20,
                      )
                    ]),
                  ),
                ),
              ),
              SvgPicture.asset(
                'assets/images/ic_minus.svg',
                width: 26,
                height: 26,
              )
            ],
          ),
          SizedBox(height: 10),
          SizedBox(height:5,),
          Stack(
            alignment: Alignment.centerRight,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 30),
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    side: BorderSide(
                        color: cubit(context).states.emailNotification
                            ? Color(0xFF5C6AC4)
                            : Color(0xFFAEB2CD)),
                  ),
                  onPressed: () {
                    // cubit(context).setEmailNotification();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 7),
                    child: Row(children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                            border: Border.all(color: Color(0xFFDFE2E9), width: 1),
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white),
                        child: Center(child: Image(
                          image: AssetImage('assets/images/png_images/telegramm.png'),
                        )),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: TextField(
                          controller:_textEditingController,
                          style: TextStyle(fontSize: 14),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "https://www.instagram.com/"
                          ),
                        ),
                      ),
                      Image.asset(
                        'assets/images/clock_social.png',
                        width: 24,
                        height: 20,
                      )
                    ]),
                  ),
                ),
              ),
              SvgPicture.asset(
                'assets/images/ic_minus.svg',
                width: 26,
                height: 26,
              )
            ],
          ),
          SizedBox(height: 10),
          SizedBox(height:5,),
          Stack(
            alignment: Alignment.centerRight,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 30),
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    side: BorderSide(
                        color: cubit(context).states.telegramNotification
                            ? Color(0xFF5C6AC4)
                            : Color(0xFFAEB2CD)),
                  ),
                  onPressed: () {
                    // cubit(context).setTelegramNotification();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 7),
                    child: Row(children: [
                      Image(
                        width: 32,
                        height: 32,
                        image: AssetImage('assets/images/png_images/facebook.png'
                        ),
                      ),
                      // Container(
                      //   width: 32,
                      //   height: 32,
                      //   decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(10),
                      //       color: Color(0xFF00A4DD)),
                      //   child: Center(child: Assets.images.icSms.svg()),
                      // ),
                      SizedBox(width: 16),
                      Expanded(
                        child: TextField(
                          controller:_textEditingController,
                          style: TextStyle(fontSize: 14),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "https://www.instagram.com/"
                          ),
                        ),
                      ),
                      Image.asset(
                        'assets/images/clock_social.png',
                        width: 24,
                        height: 20,
                      )
                    ]),
                  ),
                ),
              ),
              SvgPicture.asset(
                'assets/images/ic_minus.svg',
                width: 26,
                height: 26,
              )
            ],
          ),
          SizedBox(height: 12),
          SizedBox(height:5,),
          Stack(
            alignment: Alignment.centerRight,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 30),
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    side: BorderSide(
                        color: cubit(context).states.emailNotification
                            ? Color(0xFF5C6AC4)
                            : Color(0xFFAEB2CD)),
                  ),
                  onPressed: () {
                    // cubit(context).setEmailNotification();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 7),
                    child: Row(children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                            border: Border.all(color: Color(0xFFDFE2E9), width: 1),
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white),
                        child: Center(child: Image(
                          image: AssetImage('assets/images/png_images/youtube.png'),
                        )),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: TextField(
                          controller:_textEditingController,
                          style: TextStyle(fontSize: 14),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "https://www.instagram.com/"
                          ),
                        ),
                      ),
                      Image.asset(
                        'assets/images/clock_social.png',
                        width: 24,
                        height: 20,
                      )
                    ]),
                  ),
                ),
              ),
              SvgPicture.asset(
                'assets/images/ic_minus.svg',
                width: 26,
                height: 26,
              )
            ],
          ),
          SizedBox(height: 12),
          Text.rich(TextSpan(children: [
            TextSpan(
                text: "Маҳсулотларингиз изоҳига ижтимоий тармоқдаги саҳифаларни қўшишингиз мумкин. Бу маҳсулотингиз тарғиботига ёрдам беради",
                style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: Color(0xFF9EABBE))),

          ])),
          SizedBox(height: 15),
          CustomElevatedButton(
            text: Strings.commonSaveChanges,
            onPressed: () {
              //context.router.push(CreateProductAdRoute());
              cubit(context).setMessageType("SMS");
              context.showCustomSnackBar(
                  message: 'Saved!',
                  backgroundColor: Colors.green.shade400
              );
            },
            buttonHeight: 45,
            textSize: 12,
          ),
          SizedBox(height: 18),
        ],
      ),
    );
  }

  Widget _buildActiveDeviceBlock(BuildContext context, PageState state) {
    double width;
    double height;
    width = MediaQuery
        .of(context)
        .size
        .width;
    height = MediaQuery
        .of(context)
        .size
        .height;
    return Column(
      children: [
        Container(
          color: Colors.white,
          padding: EdgeInsets.only(top: 8),
          child: SeeAllWidget(
            title: "Активные сеансы",
            onClicked: () => context.router.push(UserActiveSessionsRoute()),
          ),
        ),
        PagedGridView<int, ActiveSession>(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            pagingController: state.controller!,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: width / height,
              crossAxisSpacing: 16,
              mainAxisSpacing: 0,
              mainAxisExtent: 145,
              crossAxisCount: 1,
            ),
            builderDelegate: PagedChildBuilderDelegate<ActiveSession>(
              firstPageErrorIndicatorBuilder: (_) {
                return SizedBox(
                    height: 60,
                    width: double.infinity,
                    child: Center(
                        child: Column(
                          children: [
                            Strings.loadingStateError
                                .w(400)
                                .s(14)
                                .c(context.colors.textPrimary),
                            SizedBox(height: 12),
                            CustomElevatedButton(
                              text: Strings.loadingStateRetry,
                              onPressed: () {},
                            )
                          ],
                        )));
              },
              firstPageProgressIndicatorBuilder: (_) {
                return SingleChildScrollView(
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 2,
                    itemBuilder: (BuildContext context, int index) {
                      return ActiveDeviceShimmer();
                    },
                  ),
                );
              },
              noItemsFoundIndicatorBuilder: (_) {
                return Center(child: Text(Strings.loadingStateNoItemFound));
              },
              newPageProgressIndicatorBuilder: (_) {
                return SizedBox(
                  height: 60,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Colors.blue,
                    ),
                  ),
                );
              },
              newPageErrorIndicatorBuilder: (_) {
                return SizedBox(
                  height: 60,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Colors.blue,
                    ),
                  ),
                );
              },
              transitionDuration: Duration(milliseconds: 100),
              itemBuilder: (context, item, index) {
                return ActiveSessionWidget(
                  session: item,
                  onClicked: (response) {
                    cubit(context).removeActiveDevice(response);
                  },
                );
              },
            )),
      ],
    );
  }
}
