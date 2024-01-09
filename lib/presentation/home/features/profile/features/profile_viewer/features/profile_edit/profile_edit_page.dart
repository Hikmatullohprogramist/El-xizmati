import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/localization/strings.dart';
import 'package:onlinebozor/common/widgets/common/common_text_field.dart';
import 'package:onlinebozor/presentation/home/features/profile/features/profile_viewer/features/profile_edit/cubit/profile_edit_cubit.dart';

import '../../../../../../../../common/gen/assets/assets.gen.dart';
import '../../../../../../../../common/widgets/common/common_button.dart';
import '../../../../../../../util.dart';

@RoutePage()
class ProfileEditPage extends BasePage<ProfileEditCubit, ProfileEditBuildable,
    ProfileEditListenable> {
  const ProfileEditPage({super.key});

  @override
  void listener(BuildContext context, ProfileEditListenable state) {
    switch (state.effect) {
      case ProfileEditEffect.success:
        () {};
      case ProfileEditEffect.backToProfileDashboard:
        () => context.router.pop();
    }
  }

  @override
  Widget builder(BuildContext context, ProfileEditBuildable state) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title:
            Strings.profileEditTitle.w(500).s(14).c(context.colors.textPrimary),
        centerTitle: true,
        elevation: 0.5,
        actions: [
          CommonButton(
              type: ButtonType.text,
              onPressed: () {
                context.read<ProfileEditCubit>().sendUserInfo();
              },
              child: Strings.commonSaveTitle.w(500).s(12).c(Color(0xFF5C6AC3)))
        ],
        leading: IconButton(
          icon: Assets.images.icArrowLeft.svg(),
          onPressed: () => context.router.pop(),
        ),
      ),
      body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 16, top: 20, right: 16, bottom: 12),
                child: Strings.profileEditChangePersonalData
                    .w(700)
                    .s(16)
                    .c(Color(0xFF41455E)),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child:
                    Strings.profileUserName.w(500).s(12).c(Color(0xFF41455E)),
              ),
              Padding(
                padding: EdgeInsets.only(right: 16, left: 16, bottom: 12),
                child: CommonTextField(
                    controller: TextEditingController(text: state.fullName),
                    hint: Strings.profileUserName,
                    enabled: false,
                    readOnly: true,
                    textInputAction: TextInputAction.next),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child:
                    Strings.profileUserEmail.w(500).s(12).c(Color(0xFF41455E)),
              ),
              Padding(
                padding: EdgeInsets.only(right: 16, left: 16, bottom: 12),
                child: CommonTextField(
                  hint: "example@gmail.com",
                  controller: TextEditingController(text: state.email),
                  textInputAction: TextInputAction.next,
                  inputType: TextInputType.emailAddress,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child:
                    Strings.profileEditPhone.w(500).s(12).c(Color(0xFF41455E)),
              ),
              Padding(
                padding: EdgeInsets.only(right: 16, left: 16, bottom: 12),
                child: CommonTextField(
                    hint: "+998",
                    readOnly: true,
                    enabled: false,
                    controller: TextEditingController(text: state.phoneNumber),
                    inputFormatters: phoneMaskFormatter,
                    inputType: TextInputType.phone,
                    textInputAction: TextInputAction.next),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Strings.profileEditUserUsername
                    .w(500)
                    .s(12)
                    .c(Color(0xFF41455E)),
              ),
              Padding(
                padding: EdgeInsets.only(right: 16, left: 16, bottom: 12),
                child: CommonTextField(
                    hint: Strings.profileEditUserUsername,
                    controller: TextEditingController(text: state.userName),
                    textInputAction: TextInputAction.next,
                    inputType: TextInputType.text),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Strings.profileEditBrithDate
                    .w(500)
                    .s(12)
                    .c(Color(0xFF41455E)),
              ),
              Padding(
                padding: EdgeInsets.only(right: 16, left: 16, bottom: 12),
                child: CommonTextField(
                  onChanged: (value) {
                    context.read<ProfileEditCubit>().setBrithDate(value);
                  },
                  readOnly: true,
                  enabled: false,
                  inputType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  inputFormatters: brithMaskFormatter,
                  maxLength: 12,
                  controller: TextEditingController(text: state.brithDate),
                  hint: "2004-11-28",
                ),
              ),
              Padding(
                  padding:
                      EdgeInsets.only(left: 16, top: 12, right: 16, bottom: 6),
                  child: Strings.profileEditBiometricInformation
                      .w(500)
                      .s(12)
                      .c(Color(0xFF41455E))),
              Padding(
                padding: const EdgeInsets.only(
                    right: 16, left: 16, bottom: 12, top: 6),
                child: Row(children: [
                  SizedBox(
                    width: 60,
                    child: CommonTextField(
                        readOnly: true,
                        enabled: false,
                        onChanged: (value) {
                          context
                              .read<ProfileEditCubit>()
                              .setBiometricSerial(value);
                        },
                        inputType: TextInputType.text,
                        maxLength: 2,
                        controller:
                            TextEditingController(text: state.biometricSerial),
                        textInputAction: TextInputAction.next),
                  ),
                  SizedBox(width: 12),
                  Flexible(
                    child: CommonTextField(
                      maxLength: 9,
                      readOnly: true,
                      enabled: false,
                      onChanged: (value) {
                        context
                            .read<ProfileEditCubit>()
                            .setBiometricNumber(value);
                      },
                      controller:
                          TextEditingController(text: state.biometricNumber),
                      inputFormatters: biometricNumberMaskFormatter,
                      textInputAction: TextInputAction.next,
                      inputType: TextInputType.number,
                      hint: Strings.profileEditBiometricSerial,
                    ),
                  ),
                ]),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child:
                    Strings.profileEditRegion.w(500).s(12).c(Color(0xFF41455E)),
              ),
              Padding(
                  padding: EdgeInsets.only(right: 16, left: 16, bottom: 12),
                  child: InkWell(
                    onTap: () {
                      showModalBottomSheet(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          backgroundColor: Colors.white,
                          context: context,
                          builder: (BuildContext buildContext) {
                            return Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20.0),
                                  topRight: Radius.circular(20.0),
                                ),
                              ),
                              height: double.infinity,
                              child: ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  itemCount: state.regions.length,
                                  itemBuilder:
                                      (BuildContext buildContext, int index) {
                                    return InkWell(
                                        onTap: () {
                                          context
                                              .read<ProfileEditCubit>()
                                              .setRegion(state.regions[index]);
                                          Navigator.pop(buildContext);
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.all(16),
                                          child:
                                              state.regions[index].name.w(500),
                                        ));
                                  }),
                            );
                          });
                    },
                    child: CommonTextField(
                      hint: Strings.profileEditRegion,
                      readOnly: true,
                      enabled: false,
                      controller: TextEditingController(text: state.regionName),
                      inputType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                    ),
                  )),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Strings.profileEditDistrict
                    .w(500)
                    .s(12)
                    .c(Color(0xFF41455E)),
              ),
              Padding(
                  padding: EdgeInsets.only(right: 16, left: 16, bottom: 12),
                  child: InkWell(
                    onTap: () {
                      showModalBottomSheet(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          backgroundColor: Colors.white,
                          context: context,
                          builder: (BuildContext buildContext) {
                            return Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20.0),
                                  topRight: Radius.circular(20.0),
                                ),
                              ),
                              height: double.infinity,
                              child: ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  itemCount: state.districts.length,
                                  itemBuilder:
                                      (BuildContext buildContext, int index) {
                                    return InkWell(
                                        onTap: () {
                                          context
                                              .read<ProfileEditCubit>()
                                              .setDistrict(
                                                  state.districts[index]);
                                          Navigator.pop(buildContext);
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.all(16),
                                          child: state.districts[index].name
                                              .w(500),
                                        ));
                                  }),
                            );
                          });
                    },
                    child: CommonTextField(
                        hint: Strings.profileEditDistrict,
                        readOnly: true,
                        enabled: false,
                        controller:
                            TextEditingController(text: state.districtName),
                        inputType: TextInputType.text,
                        textInputAction: TextInputAction.next),
                  )),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Strings.profileEditNeighborhood
                    .w(500)
                    .s(12)
                    .c(Color(0xFF41455E)),
              ),
              Padding(
                padding: EdgeInsets.only(right: 16, left: 16, bottom: 12),
                child: InkWell(
                    onTap: () {
                      showModalBottomSheet(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          backgroundColor: Colors.white,
                          context: context,
                          builder: (BuildContext buildContext) {
                            return Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20.0),
                                  topRight: Radius.circular(20.0),
                                ),
                              ),
                              height: double.infinity,
                              child: ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  itemCount: state.streets.length,
                                  itemBuilder:
                                      (BuildContext buildContext, int index) {
                                    return InkWell(
                                        onTap: () {
                                          context
                                              .read<ProfileEditCubit>()
                                              .setStreet(state.streets[index]);
                                          Navigator.pop(buildContext);
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.all(16),
                                          child:
                                              state.streets[index].name.w(500),
                                        ));
                                  }),
                            );
                          });
                    },
                    child: CommonTextField(
                      hint: Strings.profileEditNeighborhood,
                      readOnly: true,
                      controller: TextEditingController(text: state.streetName),
                      enabled: false,
                      textInputAction: TextInputAction.next,
                      inputType: TextInputType.text,
                    )),
              ),
              SizedBox(height: 24),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Flexible(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Strings.profileEditHouse
                                .w(500)
                                .s(12)
                                .c(Color(0xFF41455E)),
                            SizedBox(height: 12),
                            CommonTextField(
                              textInputAction: TextInputAction.next,
                              inputType: TextInputType.number,
                            ),
                          ],
                        )),
                    SizedBox(width: 16),
                    Flexible(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Strings.profileEditApartment
                                .w(500)
                                .s(12)
                                .c(Color(0xFF41455E)),
                            SizedBox(height: 12),
                            CommonTextField(
                              textInputAction: TextInputAction.done,
                              inputType: TextInputType.number,
                              onChanged: (value) {},
                            ),
                          ],
                        ))
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
