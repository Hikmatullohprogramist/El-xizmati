import 'dart:io';

import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/presentation/ad/create_ad/features/create_product_ad/cubit/create_product_ad_cubit.dart';

import '../../../../../common/core/base_page.dart';
import '../../../../../common/gen/localization/strings.dart';
import '../../../../../common/widgets/common/common_button.dart';

@RoutePage()
class CreateProductAdPage extends BasePage<CreateProductAdCubit,
    CreateProductAdBuildable, CreateProductAdListenable> {
  const CreateProductAdPage({super.key});

  @override
  Widget builder(BuildContext context, CreateProductAdBuildable state) {
    return Scaffold(
      body: Container(
        color: Colors.grey,
        child: SizedBox(
          height: 96,
          child: ListView.separated(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: (state.pickedImages?.length ?? 0) + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return InkWell(
                  onTap: () {
                    _showPickerTypeBottomSheet(context);
                  },
                  child: SizedBox(
                    height: 64,
                    width: 75,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0XFFFBFAFF),
                        borderRadius: BorderRadius.circular(10),
                        shape: BoxShape.rectangle,
                        border: Border.all(
                          color: Color(0xFFDFE2E9),
                          width: 0.5,
                        ),
                      ),
                      child: "Rasm qo'shish".s(14),
                    ),
                  ),
                );
              } else {
                return SizedBox(
                  height: 64,
                  width: 75,
                  child: Container(
                      decoration: BoxDecoration(
                        color: Color(0XFFFBFAFF),
                        borderRadius: BorderRadius.circular(10),
                        shape: BoxShape.rectangle,
                        border: Border.all(
                          color: Color(0xFFDFE2E9),
                          width: 0.5,
                        ),
                      ),
                      child:
                          Image.file(File(state.pickedImages![index - 1].path))),
                );
              }
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(width: 8);
            },
          ),
        ),
      ),
    );
  }

  void _showPickerTypeBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext bc) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 32),
              Center(child: Strings.profileLogoutTitle.s(22).w(600)),
              SizedBox(height: 24),
              Center(child: Strings.profileLogoutDescription.s(16)),
              SizedBox(height: 32),
              Row(
                children: <Widget>[
                  SizedBox(width: 16),
                  Expanded(
                    child: CommonButton(
                      color: Colors.blueAccent,
                      child: Container(
                        height: 48,
                        alignment: Alignment.center,
                        child: "Gallery".s(16).c(Colors.white),
                      ),
                      onPressed: () {
                        cubit(context).pickImage();

                        Navigator.pop(context);
                      },
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: CommonButton(
                      color: Colors.red,
                      child: Container(
                        height: 48,
                        alignment: Alignment.center,
                        child: "Camera".s(16).c(Colors.white),
                      ),
                      onPressed: () {
                        cubit(context).takeImage();

                        Navigator.pop(context);
                      },
                    ),
                  ),
                  SizedBox(width: 16),
                ],
              ),
              SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }
}
