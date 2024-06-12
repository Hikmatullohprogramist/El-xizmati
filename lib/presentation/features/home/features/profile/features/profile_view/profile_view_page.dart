import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:onlinebozor/core/enum/social_enum.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';
import 'package:onlinebozor/core/gen/assets/assets.gen.dart';
import 'package:onlinebozor/core/gen/localization/strings.dart';
import 'package:onlinebozor/domain/models/active_sessions/active_session.dart';
import 'package:onlinebozor/presentation/router/app_router.dart';
import 'package:onlinebozor/presentation/support/cubit/base_page.dart';
import 'package:onlinebozor/presentation/support/extensions/color_extension.dart';
import 'package:onlinebozor/presentation/support/extensions/controller_exts.dart';
import 'package:onlinebozor/presentation/support/extensions/resource_exts.dart';
import 'package:onlinebozor/presentation/widgets/app_bar/action_app_bar.dart';
import 'package:onlinebozor/presentation/widgets/button/custom_elevated_button.dart';
import 'package:onlinebozor/presentation/widgets/button/custom_text_button.dart';
import 'package:onlinebozor/presentation/widgets/dashboard/see_all_widget.dart';
import 'package:onlinebozor/presentation/widgets/device/active_session_shimmer.dart';
import 'package:onlinebozor/presentation/widgets/device/active_session_widget.dart';
import 'package:onlinebozor/presentation/widgets/divider/custom_divider.dart';
import 'package:onlinebozor/presentation/widgets/image/rounded_cached_network_image_widget.dart';
import 'package:onlinebozor/presentation/widgets/loading/default_error_widget.dart';
import 'package:onlinebozor/presentation/widgets/profile/profil_view_shimmer.dart';
import 'package:onlinebozor/presentation/widgets/switch/custom_switch.dart';

import 'profile_view_cubit.dart';

@RoutePage()
class ProfileViewPage
    extends BasePage<ProfileViewCubit, ProfileViewState, ProfileViewEvent> {
  ProfileViewPage({super.key});

  final _instagramController = TextEditingController();
  final _telegramController = TextEditingController();
  final _facebookController = TextEditingController();
  final _youtubeController = TextEditingController();

  @override
  void onWidgetCreated(BuildContext context) {
    cubit(context).getUser();
  }

  @override
  void onEventEmitted(BuildContext context, ProfileViewEvent event) {
    switch (event.type) {
      case ProfileViewEventType.onLogout:
        context.router.replace(AuthStartRoute());
    }
  }

  @override
  Widget onWidgetBuild(BuildContext context, ProfileViewState state) {
    _instagramController.updateOnRestore(state.instagramInfo?.link ?? "");
    _telegramController.updateOnRestore(state.telegramInfo?.link ?? "");
    _facebookController.updateOnRestore(state.facebookInfo?.link ?? "");
    _youtubeController.updateOnRestore(state.youtubeInfo?.link ?? "");

    return Scaffold(
        appBar: ActionAppBar(
          titleText: Strings.profileViewTitlle,
          titleTextColor: context.textPrimary,
          backgroundColor: context.appBarColor,
          onBackPressed: () => context.router.pop(),
          actions: state.isRegistered
              ? [
                  CustomTextButton(
                    text: Strings.commonEdit,
                    onPressed: () => context.router.push(ProfileEditRoute()),
                  )
                ]
              : [],
        ),
        backgroundColor: context.backgroundGreyColor,
        body: Stack(
          children: [
            Visibility(
              visible: !state.isUserLoading,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 12),
                    _getHeaderBlock(context, state),
                    SizedBox(height: 12),
                    _getBioBlock(context, state),
                    SizedBox(height: 12),
                    _buildNotificationBlock(context, state),
                    SizedBox(height: 12),
                    _buildSocialBlock(context, state),
                    SizedBox(height: 12),
                    _buildActiveDeviceBlock(context, state),
                    SizedBox(height: 12),
                  ],
                ),
              ),
            ),
            Visibility(visible: state.isUserLoading, child: profilShimmer())
          ],
        ));
  }

  Widget _getHeaderBlock(BuildContext context, ProfileViewState state) {
    return Container(
      color: context.cardColor,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Strings.profilePersonalData.w(700).s(16),
          SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RoundedCachedNetworkImage(
                imageWidth: 64,
                imageHeight: 64,
                imageId: state.photo,
                placeHolderIcon: Assets.images.icAvatarBoy.svg(),
                errorIcon: Assets.images.icAvatarBoy.svg(),
              ),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8),
                  Row(
                    children: [
                      state.fullName
                          .capitalizePersonName()
                          .w(600)
                          .s(14)
                          .copyWith(overflow: TextOverflow.ellipsis),
                      SizedBox(width: 8),
                      if (state.isRegistered) Assets.images.icIdentified.svg()
                      // else
                      //   Assets.images.icNotIdentified.svg()
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 5,
                        ),
                        margin: EdgeInsets.fromLTRB(0, 6, 6, 16),
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
                      // SizedBox(width: 10),
                      // CustomTextButton(
                      //   text: Strings.profileChangeToBusiness,
                      //   onPressed: () {},
                      // )
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
                        // Assets.images.icNotIdentified.svg(),
                        // SizedBox(width: 10),
                        Strings.profileNotIdentified
                            .w(400)
                            .s(12)
                            .c(context.textSecondary)
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: CustomElevatedButton(
                    text: Strings.profileIdentify,
                    buttonHeight: 40,
                    onPressed: state.isRegistered
                        ? null
                        : () => context.router.push(
                              IdentityVerificationRoute(
                                phoneNumber: state.phoneNumber.substring(3),
                              ),
                            ),
                    // buttonWidth: w,
                  ),
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

  Widget _getBioBlock(BuildContext context, ProfileViewState state) {
    return Container(
      color: context.cardColor,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Strings.profileUserDateOfBirth.w(400).s(14).c(context.textSecondary),
        SizedBox(height: 6),
        state.brithDate.w(500).s(16),
        SizedBox(height: 8),
        CustomDivider(),
        SizedBox(height: 8),
        Strings.profileUserDateOfDocValidity
            .w(400)
            .s(14)
            .c(context.textSecondary),
        SizedBox(height: 6),
        state.biometricInformation.w(500).s(16),
        SizedBox(height: 8),
        CustomDivider(),
        SizedBox(height: 8),
        Strings.commonEmail.w(400).s(14).c(context.textSecondary),
        SizedBox(height: 6),
        state.email.w(500).s(16),
        SizedBox(height: 8),
        CustomDivider(),
        SizedBox(height: 8),
        Strings.commonPhoneNumber.w(400).s(14).c(context.textSecondary),
        SizedBox(height: 6),
        state.phoneNumber.w(500).s(16),
        SizedBox(height: 8),
        CustomDivider(),
        SizedBox(height: 8),
        Strings.adDetailLocation.w(400).s(14).c(context.textSecondary),
        SizedBox(height: 6),
        Row(
          children: [
            state.regionName.w(500).s(16),
            ".".w(500).s(16),
            SizedBox(width: 7),
            state.districtName.w(500).s(16),
            SizedBox(width: 7),
            state.neighborhoodName.w(500).s(16),
          ],
        ),
        SizedBox(height: 5),
      ]),
    );
  }

  Widget _buildNotificationBlock(BuildContext context, ProfileViewState state) {
    return Container(
      color: context.cardColor,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 18),
          Strings.settingsReceiveNotification.w(600).s(14),
          SizedBox(height: 18),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              side: BorderSide(
                  color: state.actualSmsState
                      ? Color(0xFF5C6AC4)
                      : Color(0xFFAEB2CD)),
            ),
            onPressed: () {
              // cubit(context).setSmsNotification();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xFF5C6AC3),
                    ),
                    child: Center(child: Assets.images.icNotificationSms.svg()),
                  ),
                  SizedBox(width: 16),
                  Strings.notificationReceiveSms
                      .w(600)
                      .s(14)
                      .c(context.textPrimary),
                  Expanded(child: SizedBox(height: 1)),
                  CustomSwitch(
                    isChecked: state.actualSmsState,
                    onChanged: (value) {
                      cubit(context).changeSmsNotificationState();
                    },
                  ),
                ],
              ),
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
                  color: state.actualEmailState
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
                    // border: Border.all(color: Color(0xFF5C6AC3), width: 1),
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xFFC04646),
                  ),
                  child: Center(child: Assets.images.icNotificationEmail.svg()),
                ),
                SizedBox(width: 16),
                Strings.notificationReceiveEmail
                    .w(600)
                    .s(14)
                    .c(context.textPrimary),
                Expanded(child: SizedBox(height: 1)),
                CustomSwitch(
                  isChecked: state.actualEmailState,
                  onChanged: (value) {
                    cubit(context).changeEmailNotificationState();
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
                  color: state.actualTelegramState
                      ? Color(0xFF5C6AC4)
                      : Color(0xFFAEB2CD)),
            ),
            onPressed: () {
              // cubit(context).setTelegramNotification();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(children: [
                Assets.images.icNotificationTelegram.svg(height: 32, width: 32),
                SizedBox(width: 16),
                Strings.notificationReceiveTelegram
                    .w(600)
                    .s(14)
                    .c(context.textPrimary),
                Expanded(child: SizedBox(height: 1)),
                CustomSwitch(
                  isChecked: state.actualTelegramState,
                  onChanged: (value) {
                    cubit(context).changeTelegramNotificationState();
                  },
                ),
              ]),
            ),
          ),
          SizedBox(height: 12),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                    text: Strings.telegramBotDescription,
                    style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: context.textSecondary)),
                WidgetSpan(child: SizedBox(width: 5)),
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
                    color: Color(0xFF5C6AC3),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 15),
          CustomElevatedButton(
            text: Strings.commonSaveChanges,
            isLoading: state.isUpdatingNotification,
            isEnabled: cubit(context).hasNotSavedNotificationChanges(),
            onPressed: () async {
              await cubit(context).setMessageType();
            },
            buttonHeight: 45,
            textSize: 12,
          ),
          SizedBox(height: 18),
        ],
      ),
    );
  }

  Widget _buildSocialBlock(BuildContext context, ProfileViewState state) {
    // _instagramController.selection = TextSelection.fromPosition(
    //   TextPosition(offset: _instagramController.text.length),
    // );
    // _telegramController.selection = TextSelection.fromPosition(
    //   TextPosition(offset: _telegramController.text.length),
    // );
    // _facebookController.selection = TextSelection.fromPosition(
    //   TextPosition(offset: _facebookController.text.length),
    // );
    // _youtubeController.selection = TextSelection.fromPosition(
    //   TextPosition(offset: _youtubeController.text.length),
    // );

    return Container(
      color: context.cardColor,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 18),
          Strings.settingsSocialNetwork.w(600).s(14),
          SizedBox(height: 18),
          SizedBox(
            height: 5,
          ),
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
                        color: state.instagramInfo?.status == "WAIT"
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
                        child: Center(
                          child: Assets.images.pngImages.instagram.image(),
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: TextField(
                          controller: _instagramController,
                          style: TextStyle(fontSize: 14),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "https://www.instagram.com/"),
                          onChanged: (value) {
                            state.instagramInfo?.link = value;
                          },
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      CustomSwitch(
                        isChecked: state.instagramInfo?.status == "WAIT",
                        onChanged: (value) {
                          // cubit(context).setSmsNotification();
                          cubit(context).setInstagramSocial("");
                          HapticFeedback.lightImpact();
                        },
                      ),
                    ]),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  showSocialIdBottomSheet(context, SocialType.instagram);
                },
                child: SizedBox(
                  width: 28,
                  height: 28,
                  child: Center(
                    child: Assets.images.icQuestion.svg(
                      color: Color(0xFFAEB2CD),
                    ),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 10),
          SizedBox(
            height: 5,
          ),
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
                        color: state.telegramInfo?.status == "WAIT"
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
                          border:
                              Border.all(color: Color(0xFFDFE2E9), width: 1),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: Center(
                          child: Assets.images.pngImages.telegramm.image(),
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: TextField(
                          controller: _telegramController,
                          style: TextStyle(fontSize: 14),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "https://www.telegram.org/",
                          ),
                          onChanged: (value) {
                            state.telegramInfo?.link = value;
                          },
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      CustomSwitch(
                        isChecked: state.telegramInfo?.status == "WAIT",
                        onChanged: (value) {
                          cubit(context).setTelegramSocial("");
                          HapticFeedback.lightImpact();
                        },
                      ),
                    ]),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  showSocialIdBottomSheet(context, SocialType.telegram);
                },
                child: SizedBox(
                  width: 28,
                  height: 28,
                  child: Center(
                    child: Assets.images.icQuestion.svg(
                      color: Color(0xFFAEB2CD),
                    ),
                  ),
                ),
              ),
            ],
          ),

          ///telegram
          SizedBox(height: 10),
          SizedBox(
            height: 5,
          ),
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
                        color: state.facebookInfo?.status == "WAIT"
                            ? Color(0xFF5C6AC4)
                            : Color(0xFFAEB2CD)),
                  ),
                  onPressed: () {
                    // cubit(context).setTelegramNotification();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 7),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 32,
                          height: 32,
                          child: Assets.images.pngImages.facebook.image(),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: TextField(
                            controller: _facebookController,
                            style: TextStyle(fontSize: 14),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "https://www.instagram.com/"),
                            onChanged: (value) {
                              state.facebookInfo?.link = value;
                            },
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        CustomSwitch(
                          isChecked: state.facebookInfo?.status == "WAIT",
                          onChanged: (value) {
                            cubit(context).setFacebookSocial("");
                            HapticFeedback.lightImpact();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  showSocialIdBottomSheet(context, SocialType.facebook);
                },
                child: SizedBox(
                  width: 28,
                  height: 28,
                  child: Center(
                    child: Assets.images.icQuestion.svg(
                      color: Color(0xFFAEB2CD),
                    ),
                  ),
                ),
              ),
            ],
          ),

          ///facebook
          SizedBox(height: 12),
          SizedBox(
            height: 5,
          ),
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
                        color: state.youtubeInfo?.status == "WAIT"
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
                            border:
                                Border.all(color: Color(0xFFDFE2E9), width: 1),
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white),
                        child: Center(
                          child: Assets.images.pngImages.youtube.image(),
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: TextField(
                          controller: _youtubeController,
                          style: TextStyle(fontSize: 14),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "https://www.instagram.com/"),
                          onChanged: (value) {
                            state.youtubeInfo?.link = value;
                          },
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      CustomSwitch(
                        isChecked: state.youtubeInfo?.status == "WAIT",
                        onChanged: (value) {
                          cubit(context).setYoutubeSocial("");
                          HapticFeedback.lightImpact();
                        },
                      ),
                    ]),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  showSocialIdBottomSheet(context, SocialType.youtube);
                },
                child: SizedBox(
                  width: 28,
                  height: 28,
                  child: Center(
                    child: Assets.images.icQuestion.svg(
                      color: Color(0xFFAEB2CD),
                    ),
                  ),
                ),
              ),
            ],
          ),

          ///youtube
          SizedBox(height: 12),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text:
                      "Маҳсулотларингиз изоҳига ижтимоий тармоқдаги саҳифаларни қўшишингиз мумкин. Бу маҳсулотингиз тарғиботига ёрдам беради",
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: context.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 15),
          CustomElevatedButton(
            text: Strings.commonSaveChanges,
            isEnabled: state.instagramInfo != null,
            isLoading: state.isUpdatingSocialInfo,
            onPressed: () async {
              await cubit(context).updateSocialAccountInfo();
            },
            buttonHeight: 45,
            textSize: 12,
          ),
          SizedBox(height: 18),
        ],
      ),
    );
  }

  Widget _buildActiveDeviceBlock(BuildContext context, ProfileViewState state) {
    double width;
    double height;
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Container(
          color: context.backgroundGreyColor,
          padding: EdgeInsets.only(top: 8),
          child: SeeAllWidget(
            title: Strings.settingsActiveDevices,
            onClicked: () => context.router.push(UserActiveSessionsRoute()),
          ),
        ),
        PagedGridView<int, ActiveSession>(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          pagingController: state.controller!,
          showNewPageProgressIndicatorAsGridChild: false,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: width / height,
            crossAxisSpacing: 16,
            mainAxisSpacing: 0,
            mainAxisExtent: 145,
            crossAxisCount: 1,
          ),
          builderDelegate: PagedChildBuilderDelegate<ActiveSession>(
            firstPageErrorIndicatorBuilder: (_) {
              return DefaultErrorWidget(
                isFullScreen: true,
                onRetryClicked: () =>
                    cubit(context).states.controller?.refresh(),
              );
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
              return Center(child: Text(Strings.commonEmptyMessage));
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
              return DefaultErrorWidget(
                isFullScreen: false,
                onRetryClicked: () =>
                    cubit(context).states.controller?.refresh(),
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
          ),
        ),
      ],
    );
  }

  void showSocialIdBottomSheet(BuildContext context, SocialType type) async {
    await showCupertinoModalBottomSheet(
      context: context,
      builder: (context) => Material(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(color: Colors.white),
                            child: Center(
                                child: Stack(
                              children: [
                                if (type == SocialType.instagram)
                                  Assets.images.pngImages.instagram.image(),
                                if (type == SocialType.telegram)
                                  Assets.images.pngImages.telegramm.image(),
                                if (type == SocialType.facebook)
                                  Assets.images.pngImages.facebook.image(),
                                if (type == SocialType.youtube)
                                  Assets.images.pngImages.youtube.image(),
                              ],
                            )),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        type.linkTitle.w(700).s(16),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            type.openApp.w(700).s(14).c(Colors.grey),
                            SizedBox(width: 1),
                            Container(
                              width: 16,
                              height: 16,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              child: Center(
                                child: Assets.images.pngImages.openLink.image(),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 42,
                          height: 42,
                          child: Material(
                            child: InkWell(
                              borderRadius: BorderRadius.circular(12),
                              onTap: () {
                                Navigator.pop(context);
                                HapticFeedback.lightImpact();
                              },
                              child: Container(
                                padding: EdgeInsets.all(8),
                                child: Assets.images.icClose.svg(),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: CustomDivider(height: 1),
                ),
                SizedBox(height: 8),
                Strings.profileSocialStepFirst.w(500).s(13).c(Colors.green),
                SizedBox(height: 6),
                type.firstStep.w(500).s(16),
                SizedBox(height: 12),
                Strings.profileSocialStepSecond.w(500).s(13).c(Colors.green),
                SizedBox(height: 6),
                type.secondStep.w(500).s(16),
                SizedBox(height: 12),
                Strings.profileSocialStepThird.w(500).s(13).c(Colors.green),
                SizedBox(height: 6),
                type.thirdStep.w(500).s(16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
