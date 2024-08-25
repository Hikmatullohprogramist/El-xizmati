import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:El_xizmati/core/extensions/text_extensions.dart';
import 'package:El_xizmati/core/gen/assets/assets.gen.dart';
import 'package:El_xizmati/core/gen/localization/strings.dart';
import 'package:El_xizmati/presentation/support/cubit/base_page.dart';
import 'package:El_xizmati/presentation/support/extensions/color_extension.dart';
import 'package:El_xizmati/presentation/support/extensions/controller_exts.dart';
import 'package:El_xizmati/presentation/support/extensions/mask_formatters.dart';
import 'package:El_xizmati/presentation/widgets/app_bar/default_app_bar.dart';
import 'package:El_xizmati/presentation/widgets/button/custom_elevated_button.dart';
import 'package:El_xizmati/presentation/widgets/form_field/custom_dropdown_form_field.dart';
import 'package:El_xizmati/presentation/widgets/form_field/custom_text_form_field.dart';
import 'package:El_xizmati/presentation/widgets/form_field/label_text_field.dart';
import 'package:El_xizmati/presentation/widgets/form_field/validator/default_validator.dart';
import 'package:El_xizmati/presentation/widgets/form_field/validator/email_validator.dart';

import 'profile_edit_cubit.dart';

@RoutePage()
class ProfileEditPage
    extends BasePage<ProfileEditCubit, ProfileEditState, ProfileEditEvent> {
  ProfileEditPage({super.key});

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _docSeriesController = TextEditingController();
  final TextEditingController _docNumberController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _homeNumberController = TextEditingController();

  @override
  Widget onWidgetBuild(BuildContext context, ProfileEditState state) {
    _fullNameController.updateOnRestore(state.fullName);
    _usernameController.updateOnRestore(state.userName);
    _emailController.updateOnRestore(state.email);
    _phoneController.updateOnRestore(
      phoneMaskFormatter.formatString(state.phoneNumber),
    );
    _docSeriesController.updateOnRestore(state.docSeries);
    _docNumberController.updateOnRestore(
      docNumberMaskFormatter.formatString(state.docNumber),
    );
    _birthDateController.updateOnRestore(
      birthDateMaskFormatter.formatString(state.birthDate),
    );
    _homeNumberController.updateOnRestore(state.homeNumber);

    String email = "";
    return Scaffold(
      appBar: DefaultAppBar(
        titleText: Strings.profileEditTitle,
        titleTextColor: context.textPrimary,
        backgroundColor: context.backgroundGreyColor,
        onBackPressed: () => context.router.pop(),
      ),
      backgroundColor: context.backgroundGreyColor,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            _buildNameBlock(context, state),
            SizedBox(height: 16),
            _buildContactsBlock(context, state),
            SizedBox(height: 16),
            _buildDocInfoBlock(context, state),
            SizedBox(height: 16),
            _buildRegionBlock(context, state),
            SizedBox(height: 16),
            _buildFooterBlock(context, state, email),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildNameBlock(BuildContext context, ProfileEditState state) {
    return Container(
      padding: EdgeInsets.only(left: 16, right: 16),
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 16),
          LabelTextField(Strings.profileUserName),
          SizedBox(height: 6),
          CustomTextFormField(
            hint: Strings.profileUserName,
            enabled: false,
            readOnly: true,
            textInputAction: TextInputAction.next,
            controller: _fullNameController,
            validator: (value) => NotEmptyValidator.validate(value),
          ),
          SizedBox(height: 8),
          LabelTextField(Strings.profileEditUserUsername),
          SizedBox(height: 6),
          CustomTextFormField(
            hint: Strings.profileEditUserUsername,
            enabled: false,
            readOnly: true,
            textInputAction: TextInputAction.next,
            inputType: TextInputType.text,
            controller: _usernameController,
            validator: (value) => NotEmptyValidator.validate(value),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildContactsBlock(BuildContext context, ProfileEditState state) {
    return Container(
      padding: EdgeInsets.only(left: 16, top: 20, right: 16, bottom: 16),
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Column(
        children: [
          LabelTextField(Strings.commonEmail, isRequired: false),
          SizedBox(height: 6),
          CustomTextFormField(
            hint: "example@gmail.com",
            textInputAction: TextInputAction.next,
            inputType: TextInputType.emailAddress,
            controller: _emailController,
            validator: (value) => EmailValidator.validate(value),
            onChanged: (value) => cubit(context).setEmail(value),
          ),
          SizedBox(height: 8),
          LabelTextField(Strings.commonPhoneNumber),
          SizedBox(height: 6),
          CustomTextFormField(
            readOnly: true,
            enabled: false,
            inputType: TextInputType.phone,
            textInputAction: TextInputAction.next,
            hint: Strings.commonPhoneNumber,
            prefixText: "+998",
            inputFormatters: phoneMaskFormatter,
            controller: _phoneController,
            validator: (value) => NotEmptyValidator.validate(value),
          ),
        ],
      ),
    );
  }

  Widget _buildDocInfoBlock(BuildContext context, ProfileEditState state) {
    return Container(
      padding: EdgeInsets.only(left: 16, top: 20, right: 16, bottom: 16),
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Column(
        children: [
          LabelTextField(Strings.profileEditBrithDate),
          SizedBox(height: 6),
          Stack(
            alignment: Alignment.centerRight,
            children: [
              CustomTextFormField(
                readOnly: true,
                enabled: false,
                hint: "2004-11-28",
                maxLength: 12,
                inputType: TextInputType.number,
                textInputAction: TextInputAction.next,
                inputFormatters: birthDateMaskFormatter,
                controller: _birthDateController,
                validator: (value) => NotEmptyValidator.validate(value),
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
                        selectedDate: DateTime.tryParse(state.birthDate),
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
          SizedBox(height: 8),
          LabelTextField(Strings.commonDocInfo),
          SizedBox(height: 6),
          Row(
            children: [
              SizedBox(
                width: 60,
                child: CustomTextFormField(
                  readOnly: true,
                  enabled: false,
                  inputType: TextInputType.text,
                  maxLength: 2,
                  textInputAction: TextInputAction.next,
                  controller: _docSeriesController,
                  textCapitalization: TextCapitalization.characters,
                  validator: (value) => NotEmptyValidator.validate(value),
                  onChanged: (value) => cubit(context).setDocSeries(value),
                ),
              ),
              SizedBox(width: 12),
              Flexible(
                child: CustomTextFormField(
                  maxLength: 9,
                  readOnly: true,
                  enabled: false,
                  hint: Strings.commonDocSeries,
                  controller: _docNumberController,
                  inputFormatters: docNumberMaskFormatter,
                  textInputAction: TextInputAction.done,
                  inputType: TextInputType.number,
                  validator: (value) => NotEmptyValidator.validate(value),
                  onChanged: (value) => cubit(context).setDocNumber(value),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRegionBlock(BuildContext context, ProfileEditState state) {
    return Container(
      padding: EdgeInsets.only(left: 16, top: 20, right: 16, bottom: 16),
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Column(
        children: [
          LabelTextField(Strings.commonRegion),
          SizedBox(height: 6),
          CustomDropdownFormField(
            value: state.regionName,
            hint: Strings.commonRegion,
            validator: (value) => NotEmptyValidator.validate(value),
            onTap: () => _showRegionBottomSheet(context, state),
          ),
          SizedBox(height: 8),
          LabelTextField(Strings.commonDistrict),
          SizedBox(height: 6),
          CustomDropdownFormField(
            value: state.districtName,
            hint: Strings.commonDistrict,
            validator: (value) => NotEmptyValidator.validate(value),
            onTap: () => _showDistrictBottomSheet(context, state),
          ),
          SizedBox(height: 8),
          LabelTextField(Strings.commonNeighborhood),
          SizedBox(height: 6),
          CustomDropdownFormField(
            value: state.neighborhoodName,
            hint: Strings.commonNeighborhood,
            validator: (value) => NotEmptyValidator.validate(value),
            onTap: () => _showNeighborhoodBottomSheet(context, state),
          ),
          SizedBox(height: 8),
          LabelTextField(Strings.commonHouse),
          SizedBox(height: 6),
          CustomTextFormField(
            hint: Strings.commonHouse,
            textInputAction: TextInputAction.done,
            inputType: TextInputType.number,
            controller: _homeNumberController,
            validator: (value) => NotEmptyValidator.validate(value),
          ),
        ],
      ),
    );
  }

  Widget _buildFooterBlock(
    BuildContext context,
    ProfileEditState state,
    String email,
  ) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(width: 16),
              Assets.images.icRequiredField.svg(),
              SizedBox(width: 8),
              Expanded(
                child: Strings.adCreationRequiredFieldsLabel
                    .w(300)
                    .s(13)
                    .c(context.textSecondary),
              ),
            ],
          ),
          SizedBox(height: 16),
          CustomElevatedButton(
            text: Strings.commonSave,
            isLoading: state.isLoading,
            onPressed: () {
              HapticFeedback.lightImpact();
              // if (_formKey.currentState!.validate()) {
              //   cubit(context).createOrUpdateProductAd();
              // }
              if (email.isNotEmpty) cubit(context).setEmail(email);
              cubit(context).updateUserProfile();
            },
          ),
        ],
      ),
    );
  }

  void _showRegionBottomSheet(BuildContext context, ProfileEditState state) {
    showCupertinoModalBottomSheet(
      context: context,
      builder: (BuildContext buildContext) {
        return Material(
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: state.regions.length,
            itemBuilder: (BuildContext buildContext, int index) {
              return InkWell(
                onTap: () {
                  cubit(context).setRegion(state.regions[index]);
                  Navigator.pop(buildContext);
                },
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: state.regions[index].name.w(500),
                ),
              );
            },
          ),
        );
      },
    );
  }

  void _showDistrictBottomSheet(BuildContext context, ProfileEditState state) {
    if (!state.isRegionSelected) {
      showErrorBottomSheet(
        context,
        Strings.commonErrorRegionNotSelected,
      );
      return;
    }

    showCupertinoModalBottomSheet(
      context: context,
      builder: (BuildContext buildContext) {
        return Material(
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: state.districts.length,
            itemBuilder: (BuildContext buildContext, int index) {
              return InkWell(
                onTap: () {
                  cubit(context).setDistrict(state.districts[index]);
                  Navigator.pop(buildContext);
                },
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: state.districts[index].name.w(500),
                ),
              );
            },
          ),
        );
      },
    );
  }

  void _showNeighborhoodBottomSheet(
    BuildContext context,
    ProfileEditState state,
  ) {
    if (!state.isDistrictSelected) {
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
