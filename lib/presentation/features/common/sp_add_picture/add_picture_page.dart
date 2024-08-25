import 'dart:io';

import 'package:El_xizmati/core/extensions/text_extensions.dart';
import 'package:El_xizmati/presentation/features/common/sp_add_picture/add_picture_cubit.dart';
import 'package:El_xizmati/presentation/support/cubit/base_page.dart';
import 'package:El_xizmati/presentation/support/extensions/color_extension.dart';
import 'package:El_xizmati/presentation/widgets/button/custom_elevated_button.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/gen/assets/assets.gen.dart';
import '../../../../core/gen/localization/strings.dart';
import '../../../widgets/app_bar/default_app_bar.dart';
import '../../../widgets/button/custom_outlined_button.dart';

@RoutePage()
class AddPicturePage
    extends BasePage<AddPictureCubit, AddPictureState, AddPictureEvent> {
  const AddPicturePage({super.key});

  @override
  Widget onWidgetBuild(BuildContext context, AddPictureState state) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 60),
          Text('Profilingizga rasm\no’rnatishni xohlaysizmi ?')
              .s(20)
              .w(700)
              .c(context.textPrimary)
              .a(TextAlign.center),
          Spacer(),
          Builder(
            builder: (BuildContext context) {
              return _buildImagePicker(context, state);
            },
          ),
          Spacer(),
          _buildFeatures(context),
          Spacer(),
          _buildBottomButtons(context),
          SizedBox(height: 20),
          Container(
            height: 104,
            decoration: BoxDecoration(
                color: context.colors.buttonPrimary,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32))),
          )
        ],
      ),
    );
  }

  Widget _buildImagePicker(BuildContext context, AddPictureState state) {
    return InkWell(
        onTap: () {
          showImagePickerDialog(context, cubit(context));
        },
        child: Container(
          width: 168,
          height: 168,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: context.colors.borderColor, width: 2),
              color: context.colors.buttonPrimary.withOpacity(0.15)),
          clipBehavior: Clip.hardEdge,
          alignment: Alignment.center,
          child: state.image == null
              ? Icon(
                  Icons.camera_alt_rounded,
                  color: context.colors.buttonPrimary,
                )
              : ClipOval(
                  child: Image.file(
                    File(state.image!.xFile!.path),
                    fit: BoxFit
                        .cover, // Change to BoxFit.cover for better filling
                    width: 168,
                    height: 168,
                  ),
                ),
        ));
  }

  Widget _buildFeatures(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 36),
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 70),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildFeature(
              context,
              "Profil rasmingizni barcha ko’ra oladi",
              Icon(
                Icons.remove_red_eye,
                color: context.colors.buttonPrimary,
              ),
              MediaQuery.sizeOf(context).width * 0.4),
          SizedBox(height: 24),
          _buildFeature(
              context,
              "Profilga maxsus rasmlar qo’yish mumkin",
              Icon(
                Icons.electric_bolt_outlined,
                color: context.colors.buttonPrimary,
              ),
              MediaQuery.sizeOf(context).width * 0.4),
          SizedBox(height: 24),
          _buildFeature(
              context,
              "Profil rasmni xohlagan vaqti o‘zgartira olasiz",
              Icon(
                Icons.edit,
                color: context.colors.buttonPrimary,
              ),
              MediaQuery.sizeOf(context).width * 0.4),
        ],
      ),
    );
  }

  Widget _buildBottomButtons(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CustomElevatedButton(text: "Tasdiqlash", onPressed: () {}),
          SizedBox(height: 16),
          CustomOutlinedButton(text: "O'tkazib yuborish", onPressed: () {})
        ],
      ),
    );
  }

  Widget _buildFeature(
      BuildContext context, String text, Icon icon, double width) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        icon,
        SizedBox(
            width: width, child: Text(text).c(context.textPrimary).w(600).s(13))
      ],
    );
  }

  void showImagePickerDialog(BuildContext context, AddPictureCubit cubit) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(24),
            ),
          ),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 32),
            margin: EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    cubit.takeImage();
                  },
                  child: Row(children: [
                    Icon(
                      Icons.camera_alt_rounded,
                      color: context.colors.buttonPrimary,
                    ),
                    SizedBox(width: 10),
                    Text("Rasmga olish").w(600).c(context.textPrimary)
                  ]),
                ),
                SizedBox(height: 32),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    cubit.pickImage();
                  },
                  child: Row(children: [
                    Icon(
                      Icons.image_outlined,
                      color: context.colors.buttonPrimary,
                    ),
                    SizedBox(width: 10),
                    Text("Galereyadan tanlash").w(600).c(context.textPrimary)
                  ]),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
