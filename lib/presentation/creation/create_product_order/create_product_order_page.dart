import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/assets/assets.gen.dart';
import 'package:onlinebozor/common/gen/localization/strings.dart';
import 'package:onlinebozor/common/router/app_router.dart';
import 'package:onlinebozor/common/widgets/common/common_button.dart';
import 'package:onlinebozor/common/widgets/common/common_text_field.dart';
import 'package:onlinebozor/common/widgets/common/custom_dropdown_field.dart';
import 'package:onlinebozor/common/widgets/common/label_text_field.dart';

import '../../../../../common/core/base_page.dart';
import '../../../common/widgets/image/image_ad_list_widget.dart';
import '../../mask_formatters.dart';
import 'cubit/create_product_order_cubit.dart';

@RoutePage()
class CreateProductOrderPage extends BasePage<CreateProductOrderCubit,
    CreateProductOrderBuildable, CreateProductOrderListenable> {
  CreateProductOrderPage({super.key});

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController fromPriceController = TextEditingController();
  final TextEditingController toPriceController = TextEditingController();
  final TextEditingController phoneController = TextEditingController(text: '');
  final TextEditingController emailController = TextEditingController();

  @override
  void listener(BuildContext context, CreateProductOrderListenable event) {
    switch (event.effect) {
      case CreateProductOrderEffect.onOverMaxCount:
        {
          _showMaxCountError(context, event.maxImageCount);
        }
      case CreateProductOrderEffect.selectCategory:
        {}
    }
  }

  @override
  Widget builder(BuildContext context, CreateProductOrderBuildable state) {
    titleController.text != state.name
        ? titleController.text = state.name ?? ""
        : titleController.text = titleController.text;

    descController.text != state.description
        ? descController.text = state.description ?? ""
        : descController.text = descController.text;

    fromPriceController.text != state.fromPrice
        ? fromPriceController.text = state.fromPrice ?? ""
        : fromPriceController.text = fromPriceController.text;

    toPriceController.text != state.toPrice
        ? toPriceController.text = state.toPrice ?? ""
        : toPriceController.text = toPriceController.text;

    return Scaffold(
      appBar: _buildAppBar(context),
      backgroundColor: Color(0xFFF2F4FB),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            _buildTitleAndCategoryBlock(context, state),
            SizedBox(height: 12),
            _buildImageListBlock(context, state),
            SizedBox(height: 12),
            _buildDescAndPriceBlock(context, state),
            SizedBox(height: 12),
            _buildContactsBlock(context),
            SizedBox(height: 12),
            _buildAddressBlock(context, state),
            SizedBox(height: 12),
            _buildAutoContinueBlock(),
            SizedBox(height: 12),
            _buildFooterBlock(context),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Assets.images.icArrowLeft.svg(),
        onPressed: () => context.router.pop(),
      ),
      elevation: 0.5,
      backgroundColor: Colors.white,
      centerTitle: true,
      bottomOpacity: 1,
      title:
          Strings.createRequestTitle.w(500).s(16).c(context.colors.textPrimary),
    );
  }

  Widget _buildTitleAndCategoryBlock(
    BuildContext context,
    CreateProductOrderBuildable state,
  ) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        children: [
          LabelTextField(text: "Название товара", isRequired: true),
          SizedBox(height: 8),
          CommonTextField(
            hint: "Название товара",
            onChanged: (value) {
              context.read<CreateProductOrderCubit>().setName(value);
            },
            controller: titleController,
          ),
          SizedBox(height: 12),
          LabelTextField(text: "Категория", isRequired: true),
          SizedBox(height: 8),
          CustomDropdownField(
            text: state.categoryResponse?.name ?? "",
            hint: "Категория",
            onTap: () {
              context.router.push(
                SelectionCategoryRoute(onResult: (categoryResponse) {
                  context
                      .read<CreateProductOrderCubit>()
                      .setCategory(categoryResponse);
                }),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildImageListBlock(
    BuildContext context,
    CreateProductOrderBuildable state,
  ) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          ImageAdListWidget(
            imagePaths: state.pickedImages ?? [],
            maxCount: state.maxImageCount,
            onTakePhotoClicked: () {
              cubit(context).takeImage();
            },
            onPickImageClicked: () {
              cubit(context).pickImage();
            },
            onImageClicked: (index) {},
            onRemoveClicked: (imagePath) {
              cubit(context).removeImage(imagePath);
            },
            onReorder: (oldIndex, newIndex) {
              cubit(context).onReorder(oldIndex, newIndex);
            },
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildDescAndPriceBlock(
    BuildContext context,
    CreateProductOrderBuildable state,
  ) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LabelTextField(text: 'Описание товара'),
          SizedBox(height: 8),
          CommonTextField(
            height: null,
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
          SizedBox(height: 12),
          LabelTextField(text: "Цена", isRequired: true),
          SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: CommonTextField(
                  hint: "От",
                  controller: fromPriceController,
                  inputType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  onChanged: (value) {
                    context.read<CreateProductOrderCubit>().setFromPrice(value);
                  },
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: CommonTextField(
                  hint: "До",
                  controller: toPriceController,
                  inputType: TextInputType.number,
                  onChanged: (value) {
                    context.read<CreateProductOrderCubit>().setToPrice(value);
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          LabelTextField(text: "Валюта"),
          SizedBox(height: 8),
          SizedBox(
              width: 120,
              child: CustomDropdownField(
                  text: "Uzb", hint: "Валюта", onTap: () {})),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CupertinoSwitch(
                value: state.isNegotiate,
                onChanged: (value) {
                  context.read<CreateProductOrderCubit>().setNegative(value);
                },
              ),
              SizedBox(width: 16),
              Expanded(
                child: "Договорная".w(400).s(14).c(Color(0xFF41455E)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContactsBlock(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8),
          "Контактная информация".w(700).s(16).c(Color(0xFF41455E)),
          SizedBox(height: 20),
          "Контактное лицо".w(500).s(14).c(Color(0xFF41455E)),
          SizedBox(height: 8),
          CommonTextField(
            autofillHints: const [AutofillHints.telephoneNumber],
            keyboardType: TextInputType.phone,
            maxLines: 1,
            hint: 'Контактное лицо',
            inputType: TextInputType.phone,
            textInputAction: TextInputAction.next,
            controller: phoneController,
            inputFormatters: phoneMaskFormatter,
            onChanged: (value) {},
          ),
          SizedBox(height: 12),
          "Номер телефона".w(500).s(14).c(Color(0xFF41455E)),
          SizedBox(height: 8),
          CommonTextField(
            autofillHints: const [AutofillHints.telephoneNumber],
            keyboardType: TextInputType.phone,
            maxLines: 1,
            hint: '998 12 345 67 89',
            inputType: TextInputType.phone,
            textInputAction: TextInputAction.next,
            controller: phoneController,
            inputFormatters: phoneMaskFormatter,
            onChanged: (value) {},
          ),
          SizedBox(height: 12),
          "Эл. почта".w(500).s(14).c(Color(0xFF41455E)),
          SizedBox(height: 8),
          CommonTextField(
            autofillHints: const [AutofillHints.telephoneNumber],
            keyboardType: TextInputType.phone,
            inputType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            hint: "Эл. почта",
            maxLines: 1,
            controller: emailController,
            onChanged: (value) {},
          ),
        ],
      ),
    );
  }

  Widget _buildAddressBlock(
    BuildContext context,
    CreateProductOrderBuildable state,
  ) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          "По какому адресу?".w(700).s(15).c(Color(0xFF41455E)),
          SizedBox(height: 16),
          LabelTextField(text: "Моё местоположения", isRequired: true),
          SizedBox(height: 8),
          "Город, улица, дом".w(500).s(14).c(Color(0xFF9EABBE)),
          SizedBox(height: 8),
          CustomDropdownField(
            text: state.userAddressResponse?.name ?? "",
            hint: "Моё местоположения",
            onTap: () {
              context.router.push(
                SelectionUserAddressRoute(
                  onResult: (userAddressResponse) {
                    context
                        .read<CreateProductOrderCubit>()
                        .setUserAddress(userAddressResponse);
                  },
                ),
              );
            },
          ),
          SizedBox(height: 16),
          LabelTextField(text: "Где искать?", isRequired: true),
          SizedBox(height: 16),
          "Город, улица, дом".w(500).s(14).c(Color(0xFF9EABBE)),
          SizedBox(height: 12),
          CustomDropdownField(
            text: state.userAddressResponse?.name ?? "",
            hint: "Где искать?",
            onTap: () {
              context.router.push(
                SelectionUserAddressRoute(
                  onResult: (userAddressResponse) {
                    context
                        .read<CreateProductOrderCubit>()
                        .setUserAddress(userAddressResponse);
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAutoContinueBlock() {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            "Автопродление".w(600).s(14).c(Color(0xFF41455E)),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CupertinoSwitch(value: true, onChanged: (value) {}),
                SizedBox(width: 16),
                Expanded(
                  child: "Объявление будет деактивировано через 15 дней"
                      .w(400)
                      .s(14)
                      .c(Color(0xFF41455E)),
                ),
              ],
            ),
            SizedBox(height: 6),
          ],
        ),
      ),
    );
  }

  Widget _buildFooterBlock(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(width: 16),
              Assets.images.icRequiredField.svg(),
              SizedBox(width: 8),
              Expanded(
                child: "Необходимо заполнить все поля отмеченный звездочкой "
                    .w(300)
                    .s(13)
                    .c(context.colors.textSecondary),
              ),
            ],
          ),
          SizedBox(height: 16),
          CommonButton(
              color: context.colors.buttonPrimary,
              onPressed: () {},
              // enabled: false,
              // loading: state.loading,
              child: Container(
                height: 52,
                alignment: Alignment.center,
                width: double.infinity,
                child: Strings.commonContinueTitle
                    .w(500)
                    .s(14)
                    .c(context.colors.textPrimaryInverse),
              )),
        ],
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
