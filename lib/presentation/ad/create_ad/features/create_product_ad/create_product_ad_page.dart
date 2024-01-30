import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/widgets/image/image_ad_list_widget.dart';
import 'package:onlinebozor/presentation/ad/create_ad/features/create_product_ad/cubit/create_product_ad_cubit.dart';

import '../../../../../common/core/base_page.dart';
import '../../../../../common/gen/localization/strings.dart';

@RoutePage()
class CreateProductAdPage extends BasePage<CreateProductAdCubit,
    CreateProductAdBuildable, CreateProductAdListenable> {
  const CreateProductAdPage({super.key});

  @override
  void listener(BuildContext context, CreateProductAdListenable state) {
    switch (state.effect) {
      case CreateProductAdEffect.onMaxCount:
        _showMaxCountError(context);
    }
  }

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
              onImageClicked: () {},
              onRemoveClicked: (imagePath) {
                cubit(context).removeImage(imagePath);
              },
              onReorder: (oldIndex, newIndex) {
                cubit(context).onReorder(oldIndex, newIndex);
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showMaxCountError(
    BuildContext context,
  ) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button to close the dialog
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          // title: Text('Alert!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Strings.imageListMaxCountError(
                  max_count: 5, // todo use actual max count
                ).s(14),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Strings.closeTitle.s(14),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
