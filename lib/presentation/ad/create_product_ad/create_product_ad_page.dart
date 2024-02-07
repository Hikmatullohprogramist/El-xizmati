import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/assets/assets.gen.dart';
import 'package:onlinebozor/common/widgets/common/common_dropdown_text_field.dart';
import 'package:onlinebozor/common/widgets/image/image_ad_list_widget.dart';

import '../../../../../common/core/base_page.dart';
import '../../../../../common/gen/localization/strings.dart';
import '../../../../../common/widgets/common/common_text_field.dart';
import 'cubit/create_product_ad_cubit.dart';

@RoutePage()
class CreateProductAdPage extends BasePage<CreateProductAdCubit,
    CreateProductAdBuildable, CreateProductAdListenable> {
  CreateProductAdPage({super.key});

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController warehouseController = TextEditingController();

  @override
  void listener(BuildContext context, CreateProductAdListenable event) {
    switch (event.effect) {
      case CreateProductAdEffect.onOverMaxCount:
        _showMaxCountError(context, event.maxImageCount);
    }
  }

  @override
  Widget builder(BuildContext context, CreateProductAdBuildable state) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Assets.images.icArrowLeft.svg(),
          onPressed: () => context.router.pop(),
        ),
        elevation: 0.5,
        backgroundColor: Colors.white,
        centerTitle: true,
        bottomOpacity: 1,
        title: Strings.adCreateTitle.w(500).s(16).c(context.colors.textPrimary),
      ),
      backgroundColor: Color(0xFFF2F4FB),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 12),
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  SizedBox(height: 24),
                  _getRequiredLabelText('Название товара'),
                  SizedBox(height: 6),
                  _getTitleTextField(),
                  SizedBox(height: 16),
                  _getRequiredLabelText('Категория'),
                  SizedBox(height: 6),
                  _getCategoryDropDownTextField(),
                  SizedBox(height: 16),
                ],
              ),
            ),
            SizedBox(height: 12),
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  _getImageList(context, state),
                  SizedBox(height: 16),
                ],
              ),
            ),
            SizedBox(height: 16),
            Container(
              color: Colors.white,
              child: Column(children: [
                SizedBox(height: 16),
                _getRequiredLabelText('Описание товара'),
                SizedBox(height: 6),
                _getDescTextField(),
                SizedBox(height: 16),
                Row(
                  children: [
                    Flexible(
                        flex: 3,
                        child: Column(
                          children: [
                            _getRequiredLabelText('Кол-во на складе'),
                            SizedBox(height: 6),
                            _getWarehouseTextField(),
                          ],
                        )),
                    Flexible(
                        flex: 2,
                        child: Column(
                          children: [
                            _getLabelText('Тип'),
                            SizedBox(height: 6),
                            _getWarehouseUnitDropDownTextField(),
                          ],
                        ))
                  ],
                ),
                SizedBox(height: 16),
              ]),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _getImageList(BuildContext context, CreateProductAdBuildable state) {
    return ImageAdListWidget(
      imagePaths: state.pickedImages?.map((e) => e.path).toList() ?? [],
      maxCount: state.maxImageCount,
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
    );
  }

  Widget _getRequiredLabelText(String title) {
    return Row(
      children: [
        SizedBox(width: 16),
        title.w(500).s(14).copyWith(textAlign: TextAlign.left),
        SizedBox(width: 8),
        Assets.images.icRequiredField.svg()
      ],
    );
  }

  Widget _getLabelText(String title) {
    return Row(
      children: [
        SizedBox(width: 16),
        title.w(500).s(14).copyWith(textAlign: TextAlign.left),
      ],
    );
  }

  Widget _getTitleTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: CommonTextField(
        autofillHints: const [AutofillHints.name],
        inputType: TextInputType.name,
        keyboardType: TextInputType.name,
        minLines: 1,
        maxLines: 3,
        hint: 'Название товара',
        textInputAction: TextInputAction.next,
        controller: titleController,
        onChanged: (value) {},
      ),
    );
  }

  Widget _getCategoryDropDownTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: CommonDropDownTextField(
        autofillHints: const [AutofillHints.telephoneNumber],
        inputType: TextInputType.number,
        onChanged: (value) {},
      ),
    );
  }

  Widget _getDescTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: CommonTextField(
        autofillHints: const [AutofillHints.name],
        inputType: TextInputType.name,
        keyboardType: TextInputType.name,
        maxLines: 5,
        minLines: 3,
        hint:
            'Подумайте, какие подробности вы хотели бы узнать из объявления. И добавьте их в описание',
        textInputAction: TextInputAction.next,
        controller: descController,
        onChanged: (value) {},
      ),
    );
  }

  Widget _getWarehouseTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: CommonTextField(
        autofillHints: const [AutofillHints.telephoneNumber],
        inputType: TextInputType.number,
        keyboardType: TextInputType.number,
        maxLines: 1,
        minLines: 1,
        hint: '-',
        textInputAction: TextInputAction.next,
        controller: warehouseController,
        onChanged: (value) {},
      ),
    );
  }

  Widget _getWarehouseUnitDropDownTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: CommonDropDownTextField(
        autofillHints: const [AutofillHints.telephoneNumber],
        inputType: TextInputType.number,
        hint: '-',
        onChanged: (value) {},
      ),
    );
  }

  Future<void> _showMaxCountError(BuildContext context, int maxCount) async {
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
                  max_count: maxCount,
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
