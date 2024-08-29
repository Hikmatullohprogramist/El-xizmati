import 'package:El_xizmati/presentation/support/extensions/color_extension.dart';
import 'package:El_xizmati/presentation/widgets/button/custom_elevated_button.dart';
import 'package:El_xizmati/presentation/widgets/form_field/custom_text_form_field.dart';
import 'package:El_xizmati/presentation/widgets/form_field/label_text_field.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../../../../../core/gen/localization/strings.dart';
import '../../../../../../support/cubit/base_page.dart';
import '../../../../../../widgets/app_bar/default_app_bar.dart';
import '../../../../../../widgets/app_bar/empty_app_bar.dart';
import 'change_password_cubit.dart';

@RoutePage()
class ChangePasswordPage extends BasePage<ChangePasswordCubit,
    ChangePasswordState, ChangePasswordEvent> {
  final _currentController = TextEditingController();
  final _newController = TextEditingController();
  final _repeatController = TextEditingController();

  @override
  Widget onWidgetBuild(BuildContext context, ChangePasswordState state) {
    return Scaffold(
      appBar: DefaultAppBar(
        titleText: 'Parolni o`zgartirish',
        backgroundColor: context.appBarColor,
        titleTextColor: context.colors.primary,
        onBackPressed: () {
          Navigator.pop(context);
        },
      ),
      backgroundColor: context.backgroundGreyColor,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(33),
          child: Column(
            children: [
              _buildPassFields(),
              SizedBox(height: 36),
              _buildButton()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPassFields() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        LabelTextField(
          'Eski parol:',
          isRequired: false,
        ),
        SizedBox(height: 5),
        CustomTextFormField(
          obscureText: true,
          controller: _currentController,
        ),
        SizedBox(height: 16),
        LabelTextField(
          'Yangi parol:',
          isRequired: false,
        ),
        SizedBox(height: 5),
        CustomTextFormField(
          obscureText: true,
          controller: _newController,
        ),
        SizedBox(height: 16),
        LabelTextField(
          'Takrorlash:',
          isRequired: false,
        ),
        SizedBox(height: 5),
        CustomTextFormField(
          obscureText: true,
          controller: _repeatController,
        )
      ],
    );
  }

  Widget _buildButton() {
    return CustomElevatedButton(
        text: "O’zgartirishni saqlash", onPressed: () {});
  }
}
