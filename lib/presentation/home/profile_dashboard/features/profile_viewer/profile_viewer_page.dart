import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/localization/strings.dart';
import 'package:onlinebozor/common/router/app_router.dart';

import '../../../../../common/gen/assets/assets.gen.dart';
import '../../../../../common/widgets/app_diverder.dart';
import '../../../../../common/widgets/common_button.dart';
import 'cubit/profile_viewer_cubit.dart';

@RoutePage()
class ProfileViewerPage extends BasePage<ProfileViewerCubit,
    ProfileViewerBuildable, ProfileViewerListenable> {
  const ProfileViewerPage({super.key});

  @override
  void init(BuildContext context) {
    context.read<ProfileViewerCubit>().getUserInformation();
  }

  @override
  void listener(BuildContext context, ProfileViewerListenable state) {
    switch (state.effect) {
      case ProfileViewerEffect.success:
        {}
      case ProfileViewerEffect.navigationAuthStart:
        context.router.push(AuthStartRoute());
    }
  }

  @override
  Widget builder(BuildContext context, ProfileViewerBuildable state) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Strings.profileViewTitlle
              .w(500)
              .s(14)
              .c(context.colors.textPrimary),
          centerTitle: true,
          elevation: 0.5,
          actions: [
            if (state.isRegistration)
              CommonButton(
                  type: ButtonType.text,
                  onPressed: () => context.router.replace(ProfileEditRoute()),
                  child: "Изменить".w(500).s(12).c(Color(0xFF5C6AC3)))
          ],
          leading: IconButton(
            icon: Assets.images.icArrowLeft.svg(),
            onPressed: () => context.router.pop(),
          ),
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16, right: 16, bottom: 16, top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Strings.profileViewPersonalData
                            .w(700)
                            .c(Color(0xFF41455E))
                            .s(16),
                        SizedBox(height: 16),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 56,
                              width: 56,
                              margin: EdgeInsets.only(top: 6),
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                  color: Color(0xFFE0E0ED),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Assets.images.icAvatarBoy.svg(),
                            ),
                            SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    state.userName.w(600).s(20).c(Colors.black),
                                    SizedBox(width: 8),
                                    if (state.isRegistration)
                                      Assets.images.profileViewer.icIdentified
                                          .svg()
                                    else
                                      Assets
                                          .images.profileViewer.icNotIdentified
                                          .svg()
                                  ],
                                ),
                                Row(
                                  children: [
                                    CommonButton(
                                      onPressed: () {},
                                      enabled: false,
                                      child: Strings.profileViewPrivatePerson
                                          .w(500)
                                          .s(12)
                                          .c(Color(0xFF999CB2)),
                                    ),
                                    SizedBox(width: 12),
                                    CommonButton(
                                        type: ButtonType.text,
                                        onPressed: () {},
                                        child: Strings
                                            .profileViewChangetobusiness
                                            .w(400)
                                            .c(Color(0xFF5C6AC3))
                                            .s(12))
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 15),
                        AppDivider(indent: 16),
                        SizedBox(height: 16),
                        if (!state.isRegistration)
                          Row(children: [
                            Flexible(
                                child: Container(
                              height: 36,
                              decoration: ShapeDecoration(
                                color: Color(0x1EAEB2CD),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                              child: CommonButton(
                                type: ButtonType.text,
                                enabled: false,
                                color: Color(0x1232B88B),
                                onPressed: () {},
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Assets
                                          .images.profileViewer.icNotIdentified
                                          .svg(),
                                      SizedBox(width: 10),
                                      Strings.profileViewNotIdentified
                                          .w(400)
                                          .s(12)
                                          .c(Color(0xFF9EABBE))
                                    ],
                                  ),
                                ),
                              ),
                            )),
                            SizedBox(width: 16),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        context.colors.buttonPrimary),
                                onPressed: () =>
                                    context.router.replace(RegistrationRoute()),
                                child: Strings.profileViewIdentified
                                    .w(500)
                                    .s(12)
                                    .c(Colors.white))
                          ])
                        else
                          Container(
                            height: 28,
                            decoration: ShapeDecoration(
                              color: Color(0x1E32B88B),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            child: CommonButton(
                              type: ButtonType.text,
                              enabled: true,
                              color: Color(0x1232B88B),
                              onPressed: () {},
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Assets.images.profileViewer.icIdentified
                                        .svg(),
                                    SizedBox(width: 10),
                                    Strings.profileViewIdentified
                                        .w(400)
                                        .s(12)
                                        .c(Color(0xFF32B88B))
                                  ],
                                ),
                              ),
                            ),
                          ),
                        SizedBox(height: 16),
                        AppDivider(height: 2),
                        Padding(
                          padding: EdgeInsets.only(left: 16),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 16),
                                Strings.profileUserName
                                    .w(400)
                                    .s(14)
                                    .c(Color(0xFF9EABBE)),
                                SizedBox(height: 6),
                                state.fullName
                                    .w(500)
                                    .s(16)
                                    .c(Color(0xFF41455E)),
                                SizedBox(height: 16),
                                AppDivider(),
                                SizedBox(height: 16),
                                Strings.profileUserBrithdate
                                    .w(400)
                                    .s(14)
                                    .c(Color(0xFF9EABBE)),
                                SizedBox(height: 6),
                                state.brithDate
                                    .w(500)
                                    .s(16)
                                    .c(Color(0xFF41455E)),
                                SizedBox(height: 16),
                                AppDivider(),
                                SizedBox(height: 16),
                                Strings.profileUserBiometricdate
                                    .w(400)
                                    .s(14)
                                    .c(Color(0xFF9EABBE)),
                                SizedBox(height: 6),
                                state.biometricInformation
                                    .w(500)
                                    .s(16)
                                    .c(Color(0xFF41455E)),
                                SizedBox(height: 16),
                                AppDivider(),
                                SizedBox(height: 16),
                                Strings.profileUserGender
                                    .w(400)
                                    .s(14)
                                    .c(Color(0xFF9EABBE)),
                                SizedBox(height: 6),
                                Row(
                                  children: [
                                    if (state.gender == "MALE")
                                      Assets.images.profileViewer
                                          .icRadioButtonSelected
                                          .svg()
                                    else
                                      Assets.images.profileViewer
                                          .icRadioButtonUsSelected
                                          .svg(),
                                    SizedBox(width: 8),
                                    Strings.profileUserGenderBoy
                                        .w(400)
                                        .s(14)
                                        .c(Color(0xFF9EABBE)),
                                    SizedBox(width: 24),
                                    if (state.gender == "FEMALE")
                                      Assets.images.profileViewer
                                          .icRadioButtonSelected
                                          .svg()
                                    else
                                      Assets.images.profileViewer
                                          .icRadioButtonUsSelected
                                          .svg(),
                                    SizedBox(width: 8),
                                    Strings.profileUserGenderWomen
                                        .w(400)
                                        .s(14)
                                        .c(Color(0xFF9EABBE)),
                                    SizedBox(width: 24)
                                  ],
                                ),
                                SizedBox(height: 16),
                                AppDivider(),
                                SizedBox(height: 16),
                                Strings.profileUserEmail
                                    .w(400)
                                    .s(14)
                                    .c(Color(0xFF9EABBE)),
                                SizedBox(height: 6),
                                state.email.w(500).s(16).c(Color(0xFF41455E)),
                                SizedBox(height: 16),
                                AppDivider(),
                                SizedBox(height: 16),
                                Strings.profileUserPhone
                                    .w(400)
                                    .s(14)
                                    .c(Color(0xFF9EABBE)),
                                SizedBox(height: 6),
                                state.phoneNumber
                                    .w(500)
                                    .s(16)
                                    .c(Color(0xFF41455E)),
                                SizedBox(height: 16),
                                AppDivider(),
                                SizedBox(height: 16),
                                Strings.profileUserRegion
                                    .w(400)
                                    .s(14)
                                    .c(Color(0xFF9EABBE)),
                                SizedBox(height: 6),
                                state.regionName
                                    .w(500)
                                    .s(16)
                                    .c(Color(0xFF41455E)),
                                SizedBox(height: 16),
                                AppDivider(),
                                SizedBox(height: 16),
                                Strings.profileUserDistrict
                                    .w(400)
                                    .s(14)
                                    .c(Color(0xFF9EABBE)),
                                SizedBox(height: 6),
                                state.districtName
                                    .w(500)
                                    .s(16)
                                    .c(Color(0xFF41455E)),
                                SizedBox(height: 16),
                                AppDivider(),
                                SizedBox(height: 16),
                                Strings.profileUserNeighborhood
                                    .w(400)
                                    .s(14)
                                    .c(Color(0xFF9EABBE)),
                                SizedBox(height: 6),
                                state.streetName
                                    .w(500)
                                    .s(16)
                                    .c(Color(0xFF41455E)),
                                SizedBox(height: 16),
                              ]),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (state.isLoading)
              Center(child: CircularProgressIndicator(color: Colors.blue))
          ],
        ));
  }
}
