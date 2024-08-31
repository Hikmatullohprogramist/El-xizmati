import 'package:El_xizmati/core/extensions/text_extensions.dart';
import 'package:El_xizmati/presentation/features/home/features/sp_main/features/ad_create/ad_create_cubit.dart';
import 'package:El_xizmati/presentation/support/cubit/base_page.dart';
import 'package:El_xizmati/presentation/support/extensions/color_extension.dart';
import 'package:El_xizmati/presentation/widgets/app_bar/default_app_bar.dart';
import 'package:El_xizmati/presentation/widgets/form_field/custom_dropdown_form_field.dart';
import 'package:El_xizmati/presentation/widgets/form_field/custom_text_form_field.dart';
import 'package:El_xizmati/presentation/widgets/form_field/label_text_field.dart';
import 'package:auto_route/annotations.dart';
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

  Point? _point;
  TextEditingController _districtController = TextEditingController();

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
              _buildMediaLoader(context),
              SizedBox(height: 16),
              _buildWorkInfo(context),
              SizedBox(height: 16),
              _buildMap(context),
              SizedBox(height: 16),
              _buildRegionBlock(context, state),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMediaLoader(BuildContext context) {
    return Container(
      height: 125,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: context.cardColor.withOpacity(0.3)),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.image_outlined),
            Text("Rasm yoki video qo'shing").c(context.textPrimary)
          ],
        ),
      ),
    );
  }

  Widget _buildWorkInfo(BuildContext context) {
    return Column(
      children: [
        LabelTextField(
          "Ish kategoriyasi:",
          isRequired: false,
        ),
        SizedBox(height: 6),
        CustomDropdownFormField(
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
          hint: "Ish haqida barchasini yozing",
        ),
        SizedBox(height: 16),
        LabelTextField(
          "Narx:",
          isRequired: false,
        ),
        SizedBox(height: 6),
        CustomTextFormField(
          endIcon: Icon(Icons.monetization_on_outlined),
          hint: "Narxini yozing",
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildMap(BuildContext context) {
    return Listener(
      onPointerDown: (_){
          cubit(context).setScrolling(true);
      },
      onPointerUp: (_){
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
                  _point = point.target;
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
          LabelTextField("Viloyat", isRequired: false,),
          SizedBox(height: 6),
          CustomDropdownFormField(
            value: state.country,
            hint: Strings.commonDistrict,
            validator: (value) => NotEmptyValidator.validate(value),
            onTap: () => _showRegionBottomSheet(context, state),
          ),
          SizedBox(height: 16),
          LabelTextField("Shahar:", isRequired: false,),
          SizedBox(height: 6),
          CustomDropdownFormField(
            value: state.region,
            hint: Strings.commonDistrict,
            validator: (value) => NotEmptyValidator.validate(value),
            onTap: () => _showDistrictBottomSheet(context, state),
          ),
          SizedBox(height: 16),
          LabelTextField("Manzil", isRequired: false,),
          SizedBox(height: 6),
          CustomTextFormField(
            controller: _districtController,
            hint: Strings.commonDistrict,
            validator: (value) => NotEmptyValidator.validate(value),
          ),
          SizedBox(height: 16),
          LabelTextField("Ish turi:", isRequired: false,),
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
}
