import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/widgets/image/add_image_widget.dart';
import 'package:onlinebozor/common/widgets/image/added_image_widget.dart';
import 'package:onlinebozor/common/widgets/image/image_ad_list_widget.dart';
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
      backgroundColor: Color(0xFFF2F4FB),
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: ImageAdListWidget(
              imagePaths: state.pickedImages?.map((e) => e.path).toList() ?? [],
              maxCount: 5,
              onTakePhotoClicked: () {
                cubit(context).takeImage();
              },
              onPickImageClicked: () {
                cubit(context).pickImage();
              },
              onRemoveClicked: (imagePath) {
                cubit(context).removeImage(imagePath);
              },
              onImageClicked: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _getImageListWidget(
      BuildContext context, CreateProductAdBuildable state) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 12),
      margin: EdgeInsets.only(top: 12),
      child: SizedBox(
        height: 96,
        child: ReorderableListView.builder(
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return AddImageWidget(
                  index: index,
                  onAddClicked: () {

                  });
            } else {
              return AddedImageWidget(
                index: index,
                imagePath: state.pickedImages![index - 1].path,
                onImageClicked: () {},
                onRemoveClicked: (imagePath) {
                  cubit(context).removeImage(imagePath);
                },
              );
            }
          },
          itemCount: (state.pickedImages?.length ?? 0) + 1,
          // separatorBuilder: (context, index) => SizedBox(width: 12),
          onReorder: (int oldIndex, int newIndex) {
            cubit(context).onReorder(oldIndex, newIndex);
          },
        ),
      ),
      // child: ReorderableListView(
      //   physics: BouncingScrollPhysics(),
      //   scrollDirection: Axis.horizontal,
      //   shrinkWrap: true,
      //   padding: EdgeInsets.symmetric(
      //     horizontal: 16,
      //   ),
      //   itemCount: (state.pickedImages?.length ?? 0) + 1,
      //   itemBuilder: (context, index) {
      //     if (index == 0) {
      //       return AddAdPickImageWidget(onAddClicked: () {
      //         _showPickerTypeBottomSheet(context);
      //       });
      //     } else {
      //       return AddAdPickedImageWidget(
      //         imagePath: state.pickedImages![index - 1].path,
      //         onImageClicked: () {},
      //         onRemoveClicked: (imagePath) {
      //           cubit(context).removeImage(imagePath);
      //         },
      //       );
      //     }
      //   },
      //   separatorBuilder: (BuildContext context, int index) {
      //     return SizedBox(width: 12);
      //   },
      //   onReorder: (int oldIndex, int newIndex) {
      //     setState(() {
      //       if (newIndex > oldIndex) {
      //         newIndex -= 1;
      //       }
      //       final item = _items.removeAt(oldIndex);
      //       _items.insert(newIndex, item);
      //     });
      //   },
      // ),
    );
  }
}