import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';
import 'package:onlinebozor/core/gen/assets/assets.gen.dart';
import 'package:onlinebozor/core/gen/localization/strings.dart';
import 'package:onlinebozor/presentation/support/cubit/base_page.dart';
import 'package:onlinebozor/presentation/support/extensions/color_extension.dart';
import 'package:onlinebozor/presentation/support/extensions/controller_exts.dart';
import 'package:onlinebozor/presentation/support/extensions/mask_formatters.dart';
import 'package:onlinebozor/presentation/widgets/app_bar/action_app_bar.dart';
import 'package:onlinebozor/presentation/widgets/button/custom_elevated_button.dart';
import 'package:onlinebozor/presentation/widgets/button/custom_text_button.dart';
import 'package:onlinebozor/presentation/widgets/form_field/custom_dropdown_form_field.dart';
import 'package:onlinebozor/presentation/widgets/form_field/custom_text_form_field.dart';
import 'package:onlinebozor/presentation/widgets/form_field/label_text_field.dart';

import 'identity_verification_cubit.dart';

@RoutePage()
class IdentityVerificationPage extends BasePage<IdentityVerificationCubit,
    IdentityVerificationState, IdentityVerificationEvent> {
  final String phoneNumber;

  IdentityVerificationPage(this.phoneNumber, {super.key});

  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _docNumberController = TextEditingController();
  final TextEditingController _docSeriesController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void onWidgetCreated(BuildContext context) {
    cubit(context).setPhoneNumber(phoneNumber);
  }

  @override
  void onEventEmitted(BuildContext context, IdentityVerificationEvent event) {
    switch (event.type) {
      case IdentityVerificationEventType.success:
      case IdentityVerificationEventType.rejected:
        showErrorBottomSheet(
          context,
          Strings.identityVerificationErrorDataAlreadyLinked,
        );
      case IdentityVerificationEventType.notFound:
        showErrorBottomSheet(
          context,
          Strings.identityVerificationErrorUserNotFound,
        );
    }
  }

  @override
  Widget onWidgetBuild(BuildContext context, IdentityVerificationState state) {
    _birthDateController
        .updateOnRestore(birthDateMaskFormatter.formatString(state.brithDate));
    _docNumberController
        .updateOnRestore(docNumberMaskFormatter.formatString(state.docNumber));
    _docSeriesController.updateOnRestore(state.docSeries.toUpperCase());
    _fullNameController.updateOnRestore(state.fullName);
    _emailController.updateOnRestore(state.email);
    _phoneController
        .updateOnRestore(phoneMaskFormatter.formatString(state.phoneNumber));

    return Scaffold(
      backgroundColor: context.backgroundGreyColor,
      appBar: ActionAppBar(
        titleText: Strings.identityVerificationTitle,
        titleTextColor: context.textPrimary,
        backgroundColor: context.appBarColor,
        onBackPressed: () => context.router.pop(),
        actions: [
          CustomTextButton(
            text: Strings.commonSave,
            isEnabled: state.isIdentityVerified,
            onPressed: () {
              cubit(context).updateUserProfile();
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            _buildValidateBlock(context, state),
            SizedBox(height: 16),
            _userUserInfoBlock(context, state),
            SizedBox(height: 16),
            _userAddressBlock(context, state),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildValidateBlock(
    BuildContext context,
    IdentityVerificationState state,
  ) {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16),
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Strings.identityVerificationPersonalData
              .w(700)
              .s(16)
              .c(context.textPrimary),
          SizedBox(height: 12),
          Strings.identityVerificationPersonalDataDesc
              .w(500)
              .s(14)
              .c(context.textPrimary),
          SizedBox(height: 24),
          Strings.commonDocInfo.w(500).s(14).c(context.textPrimary),
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
                  onChanged: (value) {
                    cubit(context).setDocSeries(value);
                  },
                ),
              ),
              SizedBox(width: 12),
              Flexible(
                child: CustomTextFormField(
                  hint: "0123456",
                  maxLength: 9,
                  textInputAction: TextInputAction.next,
                  inputType: TextInputType.number,
                  controller: _docNumberController,
                  inputFormatters: docNumberMaskFormatter,
                  onChanged: (value) {
                    cubit(context).setDocNumber(value);
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Strings.profileEditBrithDate.w(500).s(14).c(context.textPrimary),
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
                        selectedDate: DateTime.tryParse(state.brithDate),
                        onDateSelected: (date) {
                          cubit(context).setBrithDate(date);
                          _birthDateController.text = date;
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
          Strings.commonPhoneNumber.w(500).s(12).c(context.textPrimary),
          SizedBox(height: 8),
          CustomTextFormField(
            autofillHints: const [AutofillHints.telephoneNumber],
            inputType: TextInputType.phone,
            keyboardType: TextInputType.phone,
            maxLines: 1,
            hint: Strings.commonPhoneNumber,
            prefixText: "+998 ",
            enabled: false,
            textInputAction: TextInputAction.next,
            controller: _phoneController,
            inputFormatters: phoneMaskFormatter,
            onChanged: (value) {
              cubit(context).setPhoneNumber(value);
            },
          ),
          SizedBox(height: 10),
          Visibility(
            // visible: !state.isIdentityVerified,
            child: CustomElevatedButton(
              text: Strings.commonContinue,
              isLoading: state.isLoading,
              onPressed: () {
                // cubit(context).validateWithBioDocs();
                cubit(context).validationAndRequest();
              },
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _userUserInfoBlock(
    BuildContext context,
    IdentityVerificationState state,
  ) {
    return Visibility(
      visible: state.isIdentityVerified,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: context.cardColor,
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            LabelTextField(Strings.profileUserName, isRequired: false),
            SizedBox(height: 6),
            CustomTextFormField(
              controller: _fullNameController,
              enabled: false,
              hint: Strings.profileUserName,
              textInputAction: TextInputAction.next,
              onChanged: (value) {
                cubit(context).setFullName(value);
              },
            ),
            SizedBox(height: 12),
            LabelTextField(Strings.commonEmail, isRequired: false),
            SizedBox(height: 6),
            CustomTextFormField(
              hint: Strings.commonEmail,
              textInputAction: TextInputAction.next,
              inputType: TextInputType.emailAddress,
              controller: _emailController,
              onChanged: (value) {
                cubit(context).setEmailAddress(value);
              },
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _userAddressBlock(
    BuildContext context,
    IdentityVerificationState state,
  ) {
    return Visibility(
      visible: state.isIdentityVerified,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: context.cardColor,
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            LabelTextField(Strings.commonRegion),
            SizedBox(height: 6),
            CustomDropdownFormField(
              value: state.regionName,
              hint: Strings.commonRegion,
              onTap: () {},
            ),
            SizedBox(height: 12),
            LabelTextField(Strings.commonDistrict),
            SizedBox(height: 6),
            CustomDropdownFormField(
              value: state.districtName,
              hint: Strings.commonDistrict,
              onTap: () {},
            ),
            SizedBox(height: 12),
            LabelTextField(Strings.commonNeighborhood),
            SizedBox(height: 6),
            CustomDropdownFormField(
              value: state.neighborhoodName,
              hint: Strings.commonNeighborhood,
              onTap: () {
                _showNeighborhoodBottomSheet(context, state);
              },
            ),
            SizedBox(height: 12),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Flexible(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LabelTextField(Strings.commonHomeNumber),
                      SizedBox(height: 6),
                      CustomTextFormField(
                        textInputAction: TextInputAction.next,
                        inputType: TextInputType.number,
                        maxLength: 5,
                        onChanged: (value) {
                          cubit(context).setApartmentNumber(value);
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 16),
                Flexible(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LabelTextField(Strings.commonApartment),
                      SizedBox(height: 6),
                      CustomTextFormField(
                        textInputAction: TextInputAction.done,
                        inputType: TextInputType.number,
                        maxLength: 5,
                        onChanged: (value) {
                          cubit(context).setApartmentNumber(value);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Visibility(
              visible: state.isIdentityVerified,
              child: Container(
                height: 48,
                margin: EdgeInsets.all(16),
                width: double.infinity,
                child: CustomElevatedButton(
                  text: Strings.commonSave,
                  isLoading: state.isLoading,
                  onPressed: () {
                    var result = cubit(context).saveEnableButton();
                    if (!result) {
                      showErrorBottomSheet(
                        context,
                        "Manzilingizni to'liq kiriting",
                      );
                    } else {
                      cubit(context).validateUser();
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showNeighborhoodBottomSheet(
    BuildContext context,
    IdentityVerificationState state,
  ) {
    final districtId = state.districtId;
    if (districtId == null) {
      showErrorBottomSheet(
        context,
        Strings.commonErrorDistrictNotSelected,
      );
      return;
    }

    showCupertinoModalBottomSheet(
      context: context,
      builder: (BuildContext buildContext) {
        return Material(
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: state.neighborhoods.length,
            itemBuilder: (BuildContext buildContext, int index) {
              return InkWell(
                onTap: () {
                  cubit(context).setNeighborhood(state.neighborhoods[index]);
                  Navigator.pop(buildContext);
                },
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: state.neighborhoods[index].name.w(500),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
