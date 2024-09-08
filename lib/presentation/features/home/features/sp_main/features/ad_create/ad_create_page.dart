import 'dart:io';

import 'package:El_xizmati/core/extensions/text_extensions.dart';
import 'package:El_xizmati/presentation/features/home/features/sp_main/features/ad_create/ad_create_cubit.dart';
import 'package:El_xizmati/presentation/support/cubit/base_page.dart';
import 'package:El_xizmati/presentation/support/extensions/color_extension.dart';
import 'package:El_xizmati/presentation/widgets/app_bar/default_app_bar.dart';
import 'package:El_xizmati/presentation/widgets/button/custom_elevated_button.dart';
import 'package:El_xizmati/presentation/widgets/form_field/custom_dropdown_form_field.dart';
import 'package:El_xizmati/presentation/widgets/form_field/custom_text_form_field.dart';
import 'package:El_xizmati/presentation/widgets/form_field/label_text_field.dart';
import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:logger/logger.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../../../../../../../core/gen/localization/strings.dart';
import '../../../../../../widgets/form_field/validator/default_validator.dart';

@RoutePage()
class AdCreatePage
    extends BasePage<AdCreateCubit, AdCreateState, AdCreateEvent> {
  AdCreatePage({super.key});

  @override
  void onEventEmitted(BuildContext context, AdCreateEvent event) {
    switch (event.type) {
      case AdCreateEventType.onSuccess:
        context.router.pop();
    }
  }

  Point? _point;
  final _districtController = TextEditingController();
  final _workNameController = TextEditingController();
  final _workInfoController = TextEditingController();
  final _priceController = TextEditingController();

  @override
  Widget onWidgetBuild(BuildContext context, AdCreateState state) {
    return Scaffold(
      appBar: DefaultAppBar(
          titleText: "E'lon yaratish",
          titleTextColor: context.colors.primary,
          backgroundColor: context.backgroundWhiteColor,
          onBackPressed: () {}),
      body: SingleChildScrollView(
        physics: cubit(context).states.isScrolling
            ? NeverScrollableScrollPhysics()
            : ScrollPhysics(),
        child: Container(
          padding: EdgeInsets.all(22),
          margin: EdgeInsets.all(24),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(16)),
          child: Column(
            children: [
              _buildMediaLoader(context, state),
              SizedBox(height: 16),
              _buildWorkInfo(context, state),
              SizedBox(height: 16),
              _buildMap(context),
              SizedBox(height: 16),
              _buildRegionBlock(context, state),
              SizedBox(height: 16),
              _buildPaymentType(context),
              SizedBox(height: 40),
              _buildButton(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context) {
    return CustomElevatedButton(text: "E'lon berish", onPressed: () {
      cubit(context).createAd();
    });
  }

  Widget _buildPaymentType(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.grey),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: [
              Icon(
                Icons.radio_button_off,
                color: context.iconPrimary,
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildMediaLoader(BuildContext context, AdCreateState state) {
    return Container(
      width: double.infinity,
      clipBehavior: Clip.hardEdge,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: context.cardColor.withOpacity(0.3)),
      child: InkWell(
        onTap: () {
          showImagePickerDialog(context, cubit(context));
        },
        borderRadius: BorderRadius.circular(12),
        child: state.image != null
            ? Image.file(
                File(state.image!.xFile!.path),
                fit: BoxFit.cover, // Change to BoxFit.cover for better filling
              )
            : SizedBox(
                height: 125,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.image_outlined),
                      Text("Rasm yoki video qo'shing").c(context.textPrimary)
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget _buildWorkInfo(BuildContext context, AdCreateState state) {
    return Column(
      children: [
        LabelTextField(
          "Ish kategoriyasi:",
          isRequired: false,
        ),
        SizedBox(height: 6),
        CustomDropdownFormField(
          value: state.category,
          hint: "Remont",
          onTap: () {},
        ),
        SizedBox(height: 16),
        LabelTextField(
          "Nomi:",
          isRequired: false,
        ),
        SizedBox(height: 6),
        CustomTextFormField(
          controller: _workNameController,
          hint: "Ish nomini yozing",
        ),
        SizedBox(height: 16),
        LabelTextField(
          "Izoh:",
          isRequired: false,
        ),
        SizedBox(height: 6),
        CustomTextFormField(
          maxLines: 7,
          controller: _workInfoController,
          hint: "Ish haqida barchasini yozing",
        ),
        SizedBox(height: 16),
        LabelTextField(
          "Narx:",
          isRequired: false,
        ),
        SizedBox(height: 6),
        CustomTextFormField(
          controller: _priceController,
          endIcon: Icon(Icons.monetization_on_outlined),
          hint: "Narxini yozing",
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildMap(BuildContext context) {
    return Listener(
      onPointerDown: (_) {
        cubit(context).setScrolling(true);
      },
      onPointerUp: (_) {
        cubit(context).setScrolling(false);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          height: 150,
          child: Stack(children: [
            YandexMap(
              onMapCreated: (controller) {},
              onCameraPositionChanged: (point, reason, isStopped) {
                if (isStopped) {
                  cubit(context).updateLoc(point.target);
                }
              },
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Icon(
                  Icons.location_on,
                  color: context.colors.buttonPrimary,
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }

  Widget _buildRegionBlock(BuildContext context, AdCreateState state) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Column(
        children: [
          SizedBox(height: 16),
          LabelTextField(
            "Viloyat",
            isRequired: false,
          ),
          SizedBox(height: 6),
          CustomDropdownFormField(
            value: state.country,
            hint: Strings.commonDistrict,
            validator: (value) => NotEmptyValidator.validate(value),
            onTap: () => _showRegionBottomSheet(context, state),
          ),
          SizedBox(height: 16),
          LabelTextField(
            "Shahar:",
            isRequired: false,
          ),
          SizedBox(height: 6),
          CustomDropdownFormField(
            value: state.region,
            hint: Strings.commonDistrict,
            validator: (value) => NotEmptyValidator.validate(value),
            onTap: () => _showDistrictBottomSheet(context, state),
          ),
          SizedBox(height: 16),
          LabelTextField(
            "Manzil",
            isRequired: false,
          ),
          SizedBox(height: 6),
          CustomTextFormField(
            controller: _districtController,
            hint: Strings.commonDistrict,
            validator: (value) => NotEmptyValidator.validate(value),
          ),
          SizedBox(height: 16),
          LabelTextField(
            "Ish turi:",
            isRequired: false,
          ),
          SizedBox(height: 6),
          CustomDropdownFormField(
            value: state.type,
            hint: "Bir martalik",
            validator: (value) => NotEmptyValidator.validate(value),
            onTap: () => _showWorkTypeBottomSheet(context, state),
          ),
        ],
      ),
    );
  }

  void _showRegionBottomSheet(BuildContext context, AdCreateState state) {
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
                  child: "Toshkent".w(500),
                ),
              );
            },
          ),
        );
      },
    );
  }

  void _showDistrictBottomSheet(BuildContext context, AdCreateState state) {
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

  void _showWorkTypeBottomSheet(BuildContext context, AdCreateState state) {
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
                  child: "Bir martalik".w(500),
                ),
              );
            },
          ),
        );
      },
    );
  }

  void showImagePickerDialog(BuildContext context, AdCreateCubit cubit) {
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
