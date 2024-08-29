import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:El_xizmati/core/extensions/text_extensions.dart';
import 'package:El_xizmati/presentation/features/home/features/my_profile/features/personal/personal_cubit.dart';
import 'package:El_xizmati/presentation/support/cubit/base_page.dart';
import 'package:El_xizmati/presentation/support/extensions/color_extension.dart';
import 'package:El_xizmati/presentation/support/extensions/mask_formatters.dart';
import 'package:El_xizmati/presentation/widgets/button/custom_elevated_button.dart';
import 'package:El_xizmati/presentation/widgets/form_field/custom_text_form_field.dart';
import 'package:El_xizmati/presentation/widgets/form_field/label_text_field.dart';

import '../../../../../../../core/gen/localization/strings.dart';
import '../../../../../../widgets/app_bar/default_app_bar.dart';
import '../../../../../../widgets/form_field/custom_dropdown_form_field.dart';
import '../../../../../../widgets/form_field/validator/default_validator.dart';

@RoutePage()
class PersonalPage
    extends BasePage<PersonalCubit, PersonalState, PersonalEvent> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _docSeriesController = TextEditingController();
  final TextEditingController _docNumberController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget onWidgetBuild(BuildContext context, PersonalState state) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: DefaultAppBar(
        titleText: Strings.profileEditTitle,
        titleTextColor: context.colors.primary,
        backgroundColor: context.backgroundGreyColor,
        onBackPressed: () => context.router.pop(),
      ),
      backgroundColor: context.backgroundGreyColor,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildNameBlock(context, state),
                  _buildPassportBlock(context, state),
                  _buildNumberBlock(context, state),
                  _buildRegionBlock(context, state)
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 32.0, right: 32, bottom: 20, top: 10),
            child: CustomElevatedButton(text: "O'zgartirishni saqlash", onPressed: (){}, ),
          )
        ],
      ),
    );
  }

  Widget _buildNameBlock(BuildContext context, PersonalState state) {
    return Container(
      padding: EdgeInsets.only(left: 33, right: 33, top: 20, bottom: 16),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(12))),
      child: Column(
        children: [
          LabelTextField(
            'Ismingiz:',
            isRequired: false,
          ),
          SizedBox(height: 6),
          CustomTextFormField(
            controller: _nameController,
            inputType: TextInputType.text,
            textInputAction: TextInputAction.next,
            maxLength: 20,
          ),
          SizedBox(height: 16),
          LabelTextField(
            'Familyangiz:',
            isRequired: false,
          ),
          SizedBox(height: 6),
          CustomTextFormField(
            controller: _surnameController,
            inputType: TextInputType.text,
            textInputAction: TextInputAction.next,
            maxLength: 20,
          )
        ],
      ),
    );
  }

  Widget _buildPassportBlock(BuildContext context, PersonalState state) {
    return Container(
      padding: EdgeInsets.only(left: 33, right: 33, top: 0, bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                LabelTextField(
                  'Seria:',
                  isRequired: false,
                ),
                SizedBox(height: 6),
                CustomTextFormField(
                  controller: _docSeriesController,
                  textCapitalization: TextCapitalization.characters,
                  textInputAction: TextInputAction.next,
                  maxLength: 2,
                  label: '_ _',
                ),
              ],
            ),
            flex: 1,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              children: [
                LabelTextField(
                  "Pasport raqami:",
                  isRequired: false,
                ),
                SizedBox(height: 6),
                CustomTextFormField(
                  textInputAction: TextInputAction.next,
                  maxLength: 7,
                  controller: _docNumberController,
                  inputType: TextInputType.number,
                  label: "_ _ _ _ _",
                ),
              ],
            ),
            flex: 3,
          ),
        ],
      ),
    );
  }

  Widget _buildNumberBlock(BuildContext context, PersonalState state) {
    return Container(
      padding: EdgeInsets.only(left: 33, right: 33, top: 0, bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      child: Column(
        children: [
          LabelTextField(
            'Telefon raqami:',
            isRequired: false,
          ),
          SizedBox(height: 6),
          CustomTextFormField(
            endIcon: IconButton(onPressed: () {  }, icon:Icon(Icons.edit, color: context.colors.buttonPrimary, size: 20,) ,

            ),
            controller: _phoneController,
            inputType: TextInputType.number,
            textInputAction: TextInputAction.done,
            maxLength: 13,
            prefixText: '+998',
            hint: Strings.commonPhoneNumber,
            inputFormatters: phoneMaskFormatter,

          ),

        ],
      ),
    );
  }
  Widget _buildRegionBlock(BuildContext context, PersonalState state) {
    return Container(
      padding: EdgeInsets.only(left: 33, right: 33, top: 0, bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Column(
        children: [
          LabelTextField("Viloyat", isRequired: false,),
          SizedBox(height: 6),
          CustomDropdownFormField(
            value: state.regionName,
            hint: Strings.commonDistrict,
            validator: (value) => NotEmptyValidator.validate(value),
            onTap: () => _showRegionBottomSheet(context, state),
          ),
          SizedBox(height: 16),
          LabelTextField("Shahar/Tuman:", isRequired: false,),
          SizedBox(height: 6),
          CustomDropdownFormField(
            value: state.districtName,
            hint: Strings.commonDistrict,
            validator: (value) => NotEmptyValidator.validate(value),
            onTap: () => _showDistrictBottomSheet(context, state),
          ),
          SizedBox(height: 16),
          LabelTextField("Manzil", isRequired: false,),
          SizedBox(height: 6),
          CustomTextFormField(
            hint: "Yashash manzilini kiriting",
            textInputAction: TextInputAction.done,
            inputType: TextInputType.number,
            validator: (value) => NotEmptyValidator.validate(value),
          ),
          SizedBox(height: 16),
          LabelTextField("Kim bo'lasiz:", isRequired: false,),
          SizedBox(height: 6),
          CustomDropdownFormField(
            value: 'Ish beruvchi',
            hint: Strings.commonDistrict,
            validator: (value) => NotEmptyValidator.validate(value),
            onTap: () => _showWorkerTypeBottomSheet(context, state),
          ),
        ],
      ),
    );
  }

  void _showRegionBottomSheet(BuildContext context, PersonalState state) {


    showCupertinoModalBottomSheet(context: context,
      builder: (BuildContext buildContext) {
        return Material(
          child: ListView.builder(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            itemCount: 3,
            itemBuilder: (BuildContext buildContext, int index) {
              return InkWell(
                onTap: () {
                  Navigator.pop(buildContext);
                },
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: "Toshkent".w(500),
                ),
              );
            },
          ),
        );
      },
    );
  }
  void _showDistrictBottomSheet(BuildContext context, PersonalState state) {


    showCupertinoModalBottomSheet(
      context: context,
      builder: (BuildContext buildContext) {
        return Material(
          child: ListView.builder(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            itemCount: 3,
            itemBuilder: (BuildContext buildContext, int index) {
              return InkWell(
                onTap: () {
                  Navigator.pop(buildContext);
                },
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: "Urganch".w(500),
                ),
              );
            },
          ),
        );
      },
    );
  }
  void _showWorkerTypeBottomSheet(BuildContext context, PersonalState state) {


    showCupertinoModalBottomSheet(
      context: context,
      builder: (BuildContext buildContext) {
        return Material(
          child: ListView.builder(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            itemCount: 3,
            itemBuilder: (BuildContext buildContext, int index) {
              return InkWell(
                onTap: () {
                  Navigator.pop(buildContext);
                },
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: "Ish beruvchi".w(500),
                ),
              );
            },
          ),
        );
      },
    );
  }

}
