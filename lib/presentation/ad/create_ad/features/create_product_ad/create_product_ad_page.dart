import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/widgets/image/add_ad_pick_image_widget.dart';
import 'package:onlinebozor/common/widgets/image/add_ad_picked_image_widget.dart';
import 'package:onlinebozor/presentation/ad/create_ad/features/create_product_ad/cubit/create_product_ad_cubit.dart';

import '../../../../../common/core/base_page.dart';
import '../../../../../common/gen/localization/strings.dart';
import '../../../../../common/widgets/common/common_button.dart';

@RoutePage()
class CreateProductAdPage extends BasePage<CreateProductAdCubit,
    CreateProductAdBuildable,
    CreateProductAdListenable> {
  const CreateProductAdPage({super.key});

  @override
  Widget builder(BuildContext context, CreateProductAdBuildable state) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F4FB),
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: _getImageListWidget(state),
          ),
        ],
      ),
    );
  }

  Widget _getImageListWidget(CreateProductAdBuildable state) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 12),
      margin: EdgeInsets.only(top: 12),
      child: SizedBox(
        height: 96,
        child: ListView.separated(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(
            horizontal: 16,
          ),
          itemCount: (state.pickedImages?.length ?? 0) + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return AddAdPickImageWidget(onAddClicked: () {
                _showPickerTypeBottomSheet(context);
              });
            } else {
              return AddAdPickedImageWidget(
                imagePath: state.pickedImages![index - 1].path,
                onImageClicked: () {},
                onRemoveClicked: (imagePath) {
                  cubit(context).removeImage(imagePath);
                },
              );
            }
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(width: 12);
          },
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
              Center(child: Strings.imageListAddTitle.s(22).w(600)),
              SizedBox(height: 32),
              InkWell(
                onTap: () => cubit(context).pickImage(),
                child: Container(
                  height: 64,
                  decoration: BoxDecoration(
                    color: Color(0XFFFBFAFF),
                    borderRadius: BorderRadius.circular(10),
                    shape: BoxShape.rectangle,
                    border: Border.all(
                      color: Color(0xFFDFE2E9),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Strings.imageListAddPickImage.s(16).c(Colors.black),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
              Expanded(
                child: CommonButton(
                  color: Colors.blueAccent,
                  child: Container(
                    height: 48,
                    alignment: Alignment.center,
                    child: Strings.imageListAddPickImage.s(16).c(Colors.white),
                  ),
                  onPressed: () {
                    cubit(context).pickImage();

                    Navigator.pop(context);
                  },
                ),
              ),
              SizedBox(height: 16),
              Expanded(
                child: CommonButton(
                  color: Colors.red,
                  child: Container(
                    height: 48,
                    alignment: Alignment.center,
                    child: Strings.imageListAddTakePhoto.s(16).c(Colors.white),
                  ),
                  onPressed: () {
                    cubit(context).takeImage();

                    Navigator.pop(context);
                  },
                ),
              ),
              SizedBox(height: 16),
              SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }
}
