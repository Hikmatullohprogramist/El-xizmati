import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/localization/strings.dart';
import 'package:onlinebozor/presentation/home/profile_dashboard/features/profile_viewer/features/registration/cubit/registration_cubit.dart';

import '../../../../../../../common/gen/assets/assets.gen.dart';
import '../../../../../../../common/widgets/common/common_button.dart';
import '../../../../../../../common/widgets/common/common_text_field.dart';
import '../../../../../../../common/widgets/dashboard/app_diverder.dart';
import '../../../../../../util.dart';

@RoutePage()
class RegistrationPage extends BasePage<RegistrationCubit,
    RegistrationBuildable, RegistrationListenable> {
  const RegistrationPage({super.key});

  @override
  void listener(BuildContext context, RegistrationListenable state) {
    switch (state.effect) {
      case RegistrationEffect.success:
        () {};
      case RegistrationEffect.backToProfileDashboard:
        () => context.router.pop();
    }
  }

  @override
  Widget builder(BuildContext context, RegistrationBuildable state) {
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
              enabled: state.isRegistration,
              type: ButtonType.text,
              onPressed: () {
                context.read<RegistrationCubit>().sendUserInfo();
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
                        onChanged: (value) {
                          context
                              .read<RegistrationCubit>()
                              .setBiometricSerial(value);
                        },
                        inputType: TextInputType.text,
                        maxLength: 2,
                        hint: "AA",
                        textInputAction: TextInputAction.next),
                  ),
                  SizedBox(width: 12),
                  Flexible(
                    child: CommonTextField(
                      maxLength: 9,
                      onChanged: (value) {
                        context
                            .read<RegistrationCubit>()
                            .setBiometricNumber(value);
                      },
                      inputFormatters: biometricNumberMaskFormatter,
                      textInputAction: TextInputAction.next,
                      inputType: TextInputType.number,
                      hint: Strings.profileEditBiometricInformation,
                    ),
                  ),
                ]),
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
                    context.read<RegistrationCubit>().setBrithDate(value);
                  },
                  inputType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  inputFormatters: brithMaskFormatter,
                  maxLength: 12,
                  hint: "2004-11-28",
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
                    onChanged: (value) {
                      context.read<RegistrationCubit>().setPhoneNumber(value);
                    },
                    inputFormatters: phoneMaskFormatter,
                    inputType: TextInputType.phone,
                    textInputAction: TextInputAction.done),
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 24),
                child: Strings.profileEditFullBiometric
                    .w(400)
                    .s(12)
                    .c(Color(0xFF9EABBE)),
              ),
              AppDivider(),
              Visibility(
                  visible: !state.isRegistration,
                  child: Container(
                      height: 40,
                      margin: EdgeInsets.all(16),
                      width: double.infinity,
                      child: CommonButton(
                        onPressed: () {
                          context
                              .read<RegistrationCubit>()
                              .getUserInformation();
                        },
                        child: Strings.commonContinueTitle.w(500),
                      ))),
              Visibility(
                  visible: state.isRegistration,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        child: Strings.profileEditUserName
                            .w(500)
                            .s(12)
                            .c(Color(0xFF41455E)),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(right: 16, left: 16, bottom: 12),
                        child: CommonTextField(
                            readOnly: true,
                            enabled: false,
                            controller:
                                TextEditingController(text: state.fullName),
                            hint: Strings.profileEditUserName,
                            textInputAction: TextInputAction.next),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        child: Strings.profileEditUserUsername
                            .w(500)
                            .s(12)
                            .c(Color(0xFF41455E)),
                      ),
                      Padding(
                        padding:
                        EdgeInsets.only(right: 16, left: 16, bottom: 12),
                        child: CommonTextField(
                            hint: Strings.profileEditUserUsername,
                            readOnly: true,
                            enabled: false,
                            controller:
                                TextEditingController(text: state.userName),
                            textInputAction: TextInputAction.next,
                            inputType: TextInputType.text),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        child: Strings.profileEditUserEmail
                            .w(500)
                            .s(12)
                            .c(Color(0xFF41455E)),
                      ),
                      Padding(
                        padding:
                        EdgeInsets.only(right: 16, left: 16, bottom: 12),
                        child: CommonTextField(
                          hint: "example@gmail.com",
                          textInputAction: TextInputAction.next,
                          inputType: TextInputType.emailAddress,
                          onChanged: (value) {},
                          controller: TextEditingController(text: state.email),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        child: Strings.profileEditRegion
                            .w(500)
                            .s(12)
                            .c(Color(0xFF41455E)),
                      ),
                      Padding(
                          padding:
                              EdgeInsets.only(right: 16, left: 16, bottom: 12),
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
                                              (BuildContext buildContext,
                                                  int index) {
                                            return InkWell(
                                                onTap: () {
                                                  context
                                                      .read<RegistrationCubit>()
                                                      .setRegion(
                                                          state.regions[index]);
                                                  Navigator.pop(buildContext);
                                                },
                                                child: Padding(
                                                  padding: EdgeInsets.all(16),
                                                  child: state
                                                      .regions[index].name
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
                                  TextEditingController(text: state.regionName),
                              inputType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                            ),
                          )),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        child: Strings.profileEditDistrict
                            .w(500)
                            .s(12)
                            .c(Color(0xFF41455E)),
                      ),
                      Padding(
                          padding:
                              EdgeInsets.only(right: 16, left: 16, bottom: 12),
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
                                              (BuildContext buildContext,
                                                  int index) {
                                            return InkWell(
                                                onTap: () {
                                                  context
                                                      .read<RegistrationCubit>()
                                                      .setDistrict(state
                                                          .districts[index]);
                                                  Navigator.pop(buildContext);
                                                },
                                                child: Padding(
                                                  padding: EdgeInsets.all(16),
                                                  child: state
                                                      .districts[index].name
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
                                controller: TextEditingController(
                                    text: state.districtName),
                                inputType: TextInputType.text,
                                textInputAction: TextInputAction.next),
                          )),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        child: Strings.profileEditNeighborhood
                            .w(500)
                            .s(12)
                            .c(Color(0xFF41455E)),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(right: 16, left: 16, bottom: 12),
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
                                              (BuildContext buildContext,
                                                  int index) {
                                            return InkWell(
                                                onTap: () {
                                                  context
                                                      .read<RegistrationCubit>()
                                                      .setStreet(
                                                          state.streets[index]);
                                                  Navigator.pop(buildContext);
                                                },
                                                child: Padding(
                                                  padding: EdgeInsets.all(16),
                                                  child: state
                                                      .streets[index].name
                                                      .w(500),
                                                ));
                                          }),
                                    );
                                  });
                            },
                            child: CommonTextField(
                              hint: Strings.profileEditNeighborhood,
                              readOnly: true,
                              controller:
                                  TextEditingController(text: state.streetName),
                              enabled: false,
                              textInputAction: TextInputAction.next,
                              inputType: TextInputType.text,
                            )),
                      ),
                      SizedBox(height: 24),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
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
            ],
          )),
    );
  }
}
