import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/localization/strings.dart';
import 'package:onlinebozor/common/router/app_router.dart';

import '../../../../../../common/constants.dart';
import '../../../../../../common/gen/assets/assets.gen.dart';
import '../../../../../../common/widgets/common/common_button.dart';
import '../../../../../../common/widgets/dashboard/app_diverder.dart';
import 'cubit/page_cubit.dart';

@RoutePage()
class ProfileViewPage extends BasePage<PageCubit, PageState, PageEvent> {
  const ProfileViewPage({super.key});

  @override
  void onWidgetCreated(BuildContext context) {
    context.read<PageCubit>().getUserInformation();
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
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Strings.profileViewTitlle
                .w(500)
                .s(14)
                .c(context.colors.textPrimary),
            centerTitle: true,
            elevation: 0.0,
            actions: _getAppBarActions(context, state),
            leading: IconButton(
              icon: Assets.images.icArrowLeft.svg(),
              onPressed: () => context.router.pop(),
            ),
          ),
          backgroundColor: Color(0xFFF2F4FB),
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
                        AppDivider(),
                        _getHeaderBlock(context, state),
                        SizedBox(height: 12),
                        _getBioBlock(context, state),
                        SizedBox(height: 12),
                        // _getNotificationBlock(context, state),
                        // SizedBox(height: 12),
                        // _getSessionsBlock(context, state)
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
      log("profile view page render error $e");
      return Container();
    }
  }

  List<Widget> _getAppBarActions(BuildContext context, PageState state) {
    return [
      if (state.isRegistered)
        CommonButton(
          type: ButtonType.text,
          onPressed: () => context.router.replace(ProfileEditRoute()),
          child: Strings.profileEditTitle.w(500).s(12).c(Color(0xFF5C6AC3)),
        )
    ];
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
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: imageProvider,
                        colorFilter: ColorFilter.mode(
                            Color(0xFFF6F7FC), BlendMode.colorBurn)),
                  ),
                ),
                placeholder: (context, url) => Container(
                  height: 64,
                  width: 64,
                  margin: EdgeInsets.only(top: 6),
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: Color(0xFFE0E0ED),
                      borderRadius: BorderRadius.circular(10)),
                  child: Assets.images.icAvatarBoy.svg(),
                ),
                errorWidget: (context, url, error) => Container(
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
                      CommonButton(
                          type: ButtonType.text,
                          onPressed: () {},
                          child: Strings.profileChangeToBusiness
                              .w(500)
                              .c(Color(0xFF5C6AC3))
                              .s(13))
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
                CommonButton(
                  type: ButtonType.elevated,
                  onPressed: state.isRegistered
                      ? null
                      : () => context.router.replace(RegistrationRoute()),
                  child: SizedBox(
                    height: 42,
                    child: Center(
                      child:
                          Strings.profileIdentify.w(500).s(12).c(Colors.white),
                    ),
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
              child: CommonButton(
                type: ButtonType.text,
                enabled: true,
                color: Color(0x1232B88B),
                onPressed: () {},
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Assets.images.icIdentified.svg(),
                      SizedBox(width: 10),
                      Strings.profileIdentified
                          .w(400)
                          .s(12)
                          .c(Color(0xFF32B88B))
                    ],
                  ),
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
        Strings.profileUserName.w(400).s(14).c(Color(0xFF9EABBE)),
        SizedBox(height: 6),
        state.fullName.w(500).s(16).c(Color(0xFF41455E)),
        SizedBox(height: 8),
        AppDivider(),
        SizedBox(height: 8),
        Strings.profileUserDateOfBirth.w(400).s(14).c(Color(0xFF9EABBE)),
        SizedBox(height: 6),
        state.brithDate.w(500).s(16).c(Color(0xFF41455E)),
        SizedBox(height: 8),
        AppDivider(),
        SizedBox(height: 8),
        Strings.profileUserDateOfDocValidity.w(400).s(14).c(Color(0xFF9EABBE)),
        SizedBox(height: 6),
        state.biometricInformation.w(500).s(16).c(Color(0xFF41455E)),
        SizedBox(height: 8),
        AppDivider(),
        SizedBox(height: 8),
        Strings.profileUserGender.w(400).s(14).c(Color(0xFF9EABBE)),
        SizedBox(height: 6),
        Row(
          children: [
            if (state.gender == "MALE")
              Assets.images.icRadioButtonSelected.svg()
            else
              Assets.images.icRadioButtonUnSelected.svg(),
            SizedBox(width: 8),
            Strings.profileUserGenderBoy.w(400).s(14).c(Color(0xFF9EABBE)),
            SizedBox(width: 24),
            if (state.gender == "FEMALE")
              Assets.images.icRadioButtonSelected.svg()
            else
              Assets.images.icRadioButtonUnSelected.svg(),
            SizedBox(width: 8),
            Strings.profileUserGenderWomen.w(400).s(14).c(Color(0xFF9EABBE)),
            SizedBox(width: 24)
          ],
        ),
        SizedBox(height: 8),
        AppDivider(),
        SizedBox(height: 8),
        Strings.profileUserEmail.w(400).s(14).c(Color(0xFF9EABBE)),
        SizedBox(height: 6),
        state.email.w(500).s(16).c(Color(0xFF41455E)),
        SizedBox(height: 8),
        AppDivider(),
        SizedBox(height: 8),
        Strings.profileUserPhone.w(400).s(14).c(Color(0xFF9EABBE)),
        SizedBox(height: 6),
        state.phoneNumber.w(500).s(16).c(Color(0xFF41455E)),
        SizedBox(height: 8),
        AppDivider(),
        SizedBox(height: 8),
        Strings.profileUserRegion.w(400).s(14).c(Color(0xFF9EABBE)),
        SizedBox(height: 6),
        state.regionName.w(500).s(16).c(Color(0xFF41455E)),
        SizedBox(height: 8),
        AppDivider(),
        SizedBox(height: 8),
        Strings.profileUserDistrict.w(400).s(14).c(Color(0xFF9EABBE)),
        SizedBox(height: 6),
        state.districtName.w(500).s(16).c(Color(0xFF41455E)),
        SizedBox(height: 8),
        AppDivider(),
        SizedBox(height: 8),
        Strings.profileUserNeighborhood.w(400).s(14).c(Color(0xFF9EABBE)),
        SizedBox(height: 6),
        state.streetName.w(500).s(16).c(Color(0xFF41455E)),
        SizedBox(height: 16),
      ]),
    );
  }
}
