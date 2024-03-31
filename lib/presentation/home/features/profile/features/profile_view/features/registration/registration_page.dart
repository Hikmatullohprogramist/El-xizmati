import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/localization/strings.dart';
import 'package:onlinebozor/common/widgets/bottom_sheet/botton_sheet_for_result.dart';
import 'package:onlinebozor/common/widgets/button/custom_elevated_button.dart';
import 'package:onlinebozor/common/widgets/button/custom_text_button.dart';
import 'package:onlinebozor/presentation/home/features/profile/features/profile_view/features/registration/cubit/page_cubit.dart';

import '../../../../../../../../common/gen/assets/assets.gen.dart';
import '../../../../../../../../common/widgets/divider/custom_diverder.dart';
import '../../../../../../../../common/widgets/text_field/custom_text_form_field.dart';
import '../../../../../../../utils/mask_formatters.dart';

@RoutePage()
class RegistrationPage extends BasePage<PageCubit, PageState, PageEvent> {
   RegistrationPage(this.phoneNumber,  {super.key});
   final phoneNumber;


  TextEditingController datePickerController=TextEditingController();
  TextEditingController fullNameController=TextEditingController();
  TextEditingController emailController=TextEditingController();

  @override
  void onWidgetCreated(BuildContext context) {
     cubit(context).setPhoneNumber(phoneNumber);
  }

  @override
  void onEventEmitted(BuildContext context, PageEvent event) {
    switch(event.type){

      case PageEventType.success:

      case PageEventType.rejected:
      context.showErrorBottomSheet(context, Strings.loadingStateError,
          "Бу шахсий маълумотларингиз бошқа телефон рақамга бириктирилган!");

      case PageEventType.notFound:
      context.showErrorBottomSheet(context, Strings.loadingStateError,
          "Bunday foydalanuvchi mavjud emas");
    }
    }
  @override
  Widget onWidgetBuild(BuildContext context, PageState state) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Изменить",style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black),),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0.5,
        actions: [
          CustomTextButton(
            text: Strings.commonSave,
            isEnabled: state.isRegistration,
            onPressed: () {
              cubit(context).sendUserInfo();
            },
          )
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
            _buildValidateBlock(context),
           _userAddressBlock(context, state),
           _buildContinueButton(context, state),

          ],
        ),
      ),
    );
  }

  Widget _buildValidateBlock(BuildContext context){
    return Column(
      crossAxisAlignment:CrossAxisAlignment.start,
      children: [
        ///title
        Padding(
          padding: const EdgeInsets.only(
              left: 16, top: 20, right: 16, bottom: 12),
          child: "Изменить личные данные"
              .w(700)
              .s(16)
              .c(Color(0xFF41455E)),
        ),
        ///bioDoc
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
              child: CustomTextFormField(
                  onChanged: (value) {
                    cubit(context).setBiometricSerial(value);
                  },
                  inputType: TextInputType.text,
                  maxLength: 2,
                  hint: "AA",
                  textCapitalization: TextCapitalization.characters,
                  textInputAction: TextInputAction.next),
            ),
            SizedBox(width: 12),
            Flexible(
              child: CustomTextFormField(
                maxLength: 9,
                onChanged: (value) {
                  cubit(context).setBiometricNumber(value);
                },
                inputFormatters: biometricNumberMaskFormatter,
                textInputAction: TextInputAction.next,
                inputType: TextInputType.number,
                hint: "0123456",
              ),
            ),
          ]),
        ),
        ///date picker
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Strings.profileEditBrithDate
              .w(500)
              .s(12)
              .c(Color(0xFF41455E)),
        ),
        Padding(
          padding: EdgeInsets.only(right: 16, left: 16, bottom: 12),
          child: Stack(
            alignment: Alignment.centerRight,
            children: [
              CustomTextFormField(
                onChanged: (value) {
                  cubit(context).setBrithDate(value);
                },
                inputType: TextInputType.number,
                textInputAction: TextInputAction.next,
                inputFormatters: brithMaskFormatter,
                maxLength: 12,
                controller:datePickerController,
                hint: "2004-11-28",
              ),
              Container(
                  margin: EdgeInsets.only(right: 15),
                  child: InkWell(
                      onTap: (){
                        showDatePickerDialog(context);
                      },
                      child: Assets.images.icCalendar.svg(height: 28, width:28))),
            ],
          ),
        ),
        /// telephone number
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Strings.profileEditPhone.w(500).s(12).c(Color(0xFF41455E)),
        ),
        Padding(
          padding: EdgeInsets.only(right: 16, left: 16, bottom: 12),
          child: CustomTextFormField(
            autofillHints: const [AutofillHints.telephoneNumber],
            inputType: TextInputType.phone,
            keyboardType: TextInputType.phone,
            maxLines: 1,
            prefixText: "+998 ",
            enabled: false,
            controller: TextEditingController(text: phoneNumber),
            textInputAction: TextInputAction.next,
            //controller: phoneController,
            inputFormatters: phoneMaskFormatter,
            onChanged: (value) {
              cubit(context).setPhoneNumber(value);
            },
          ),
        ),
        Padding(
            padding:
            EdgeInsets.only(left: 16, top: 8, right: 16, bottom: 19),
            child: "Укажите номер и серия паспорта, дата рождения"
                .w(500)
                .s(12)
                .c(Color(0xFF41455E))),

        SizedBox(height: 10),
      ],
    );
  }

  Widget _buildContinueButton(BuildContext context,PageState state){
    return Visibility(
      visible: !state.isRegistration,
      child: Container(
        height: 48,
        margin: EdgeInsets.all(16),
        width: double.infinity,
        child: CustomElevatedButton(
          text: Strings.commonContinue,
          isLoading: state.isLoading,
          onPressed: () {
            cubit(context).validateWithBioDocs();
          },
        ),
      ),
    );
  }

  Widget _userAddressBlock(BuildContext context,PageState state){
    return  Visibility(
        visible: state.isRegistration,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///   Divider
            CustomDivider(),
            ///FullName
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Strings.profileUserName.w(500).s(12).c(Color(0xFF41455E)),
            ),
            Padding(
              padding: EdgeInsets.only(right: 16, left: 16, bottom: 12),
              child: CustomTextFormField(
                controller: TextEditingController(text: state.fullName),
                enabled: false,
                hint: Strings.profileUserName,
                textInputAction: TextInputAction.next,
                onChanged: (value){
                  cubit(context).setFullName(value);
                },
              ),
            ),
            ///email
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Strings.profileUserEmail.w(500).s(12).c(Color(0xFF41455E)),
            ),
            Padding(
              padding: EdgeInsets.only(right: 16, left: 16, bottom: 12),
              child: CustomTextFormField(
                hint: "example@gmail.com",
                controller:emailController,
                textInputAction: TextInputAction.next,
                inputType: TextInputType.emailAddress,
                onChanged: (value){
                  cubit(context).setEmailAddress(value);
                },
              ),
            ),

            ///username
            //   Padding(
            //     padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            //     child: "User name".w(500).s(12).c(Color(0xFF41455E)),
            //   ),
            //   Padding(
            //    padding: EdgeInsets.only(right: 16, left: 16, bottom: 12),
            //    child: CommonTextField(
            //      hint: "User name",
            //      textInputAction: TextInputAction.next,
            //      onChanged: (value){
            //        cubit(context).setFullName(value);
            //      },
            //    ),
            //  ),

            /// region
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Strings.profileEditRegion.w(500).s(12).c(Color(0xFF41455E)),
            ),
            Padding(
                padding: EdgeInsets.only(right: 16, left: 16, bottom: 12),
                child: CustomTextFormField(
                  hint: Strings.profileEditRegion,
                  readOnly: true,
                  enabled: false,
                  controller: TextEditingController(text: state.regionName),
                  inputType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                )),
            /// district
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child:
              Strings.profileEditDistrict.w(500).s(12).c(Color(0xFF41455E)),
            ),
            Padding(
                padding: EdgeInsets.only(right: 16, left: 16, bottom: 12),
                child: CustomTextFormField(
                    hint: Strings.profileEditDistrict,
                    readOnly: true,
                    enabled: false,
                    controller:
                    TextEditingController(text: state.districtName),
                    inputType: TextInputType.text,
                    textInputAction: TextInputAction.next)),
            ///Neighborhood
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Strings.profileEditNeighborhood
                  .w(500)
                  .s(12)
                  .c(Color(0xFF41455E)),
            ),
            Padding(
              padding: EdgeInsets.only(right: 16, left: 16, bottom: 12),
              child: InkWell(
                  onTap: () {
                    log(state.districtId.toString());
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
                                itemCount: state.neighborhoods.length,
                                itemBuilder: (BuildContext buildContext, int index) {
                                  return InkWell(
                                      onTap: () {
                                        cubit(context).setStreet(state.neighborhoods[index]);
                                        Navigator.pop(buildContext);
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.all(16),
                                        child: state.neighborhoods[index].name.w(500),
                                      ));
                                }),
                          );
                        });
                  },
                  child: CustomTextFormField(
                    hint: Strings.profileEditNeighborhood,
                    readOnly: true,
                    controller: TextEditingController(text: state.neighborhoodName),
                    enabled: false,
                    textInputAction: TextInputAction.next,
                    inputType: TextInputType.text,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
                          CustomTextFormField(
                            textInputAction: TextInputAction.next,
                            inputType: TextInputType.number,
                            maxLength: 5,
                            onChanged: (value){
                              cubit(context).setApartmentNumber(value);
                            },
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
                          CustomTextFormField(
                            textInputAction: TextInputAction.done,
                            inputType: TextInputType.number,
                            maxLength: 5,
                            onChanged: (value) {
                              cubit(context).setApartmentNumber(value);
                            },
                          ),
                        ],
                      )),
                ],
              ),
            ),
            ///
            Visibility(
              visible: state.isRegistration,
              child: Container(
                height: 48,
                margin: EdgeInsets.all(16),
                width: double.infinity,
                child: CustomElevatedButton(
                  text: Strings.commonSave,
                  isLoading: state.isLoading,
                  onPressed: () {
                    var result= cubit(context).saveEnableButton();
                    if(!result){
                      context.showErrorBottomSheet(context,Strings.loadingStateError,"Manzilingizni to'liq kiriting");
                    }else{
                      cubit(context).validateUser();
                    }
                  },
                ),
              ),
            ),
          ],
        ));
  }

  void showDatePickerDialog(BuildContext context) {
    var parentContext = context;
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              color: Colors.white,
              height: 350.0,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: DateTime(2000),
                minimumYear: 1930,
                maximumYear: 2024,
                onDateTimeChanged: (DateTime newDateTime) {
                  final formattedDate =
                  DateFormat("yyyy-MM-dd").format(newDateTime);
                  // cubit(parentContext).setBirthDate(formattedDate);
                  cubit(parentContext).setBrithDate(formattedDate);
                  datePickerController.text=formattedDate;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: CustomElevatedButton(
                text: Strings.commonSave,
                onPressed: () {
                  //  cubit(parent).enableButton(passportSeries.text, passportNumber.text, birthDate);
                  Navigator.of(context).pop();
                },
                backgroundColor: context.colors.buttonPrimary,
                isEnabled: true,
                isLoading: false,
              ),
            ),
            SizedBox(
              height: 12,
            ),
          ],
        );
      },
    );
  }
}
