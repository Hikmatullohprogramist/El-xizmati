import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/assets/assets.gen.dart';
import 'package:onlinebozor/common/widgets/common/custom_dropdown_field.dart';
import 'package:onlinebozor/common/widgets/common/label_text_field.dart';
import 'package:onlinebozor/common/widgets/image/image_ad_list_widget.dart';
import 'package:onlinebozor/common/widgets/switch/custom_switch.dart';

import '../../../../../common/core/base_page.dart';
import '../../../../../common/gen/localization/strings.dart';
import '../../../../../common/widgets/common/common_text_field.dart';
import '../../../common/router/app_router.dart';
import '../../../common/vibrator/vibrator_extension.dart';
import '../../../common/widgets/common/common_button.dart';
import '../../../common/widgets/dashboard/app_diverder.dart';
import '../../mask_formatters.dart';
import 'cubit/create_product_ad_cubit.dart';

@RoutePage()
class CreateProductAdPage extends BasePage<CreateProductAdCubit,
    CreateProductAdBuildable, CreateProductAdListenable> {
  CreateProductAdPage({super.key});

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController warehouseController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  final TextEditingController contactPersonController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

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
      appBar: _buildAppBar(context),
      backgroundColor: Color(0xFFF2F4FB),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 12),
            _buildTitleAndCategoryBlock(context, state),
            SizedBox(height: 12),
            _buildImageListBlock(context, state),
            SizedBox(height: 16),
            _buildDescAndPriceBlock(context, state),
            SizedBox(height: 16),
            _buildContactsBlock(context, state),
            SizedBox(height: 16),
            _buildAutoContinueBlock(context, state),
            SizedBox(height: 16),
            _buildPinMySocialAccountsBlock(context, state),
            SizedBox(height: 16),
            _buildFooterBlock(context),
            SizedBox(height: 24),
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
      title: Strings.adCreateTitle.w(500).s(16).c(context.colors.textPrimary),
    );
  }

  /// Build block methods

  Widget _buildTitleAndCategoryBlock(
    BuildContext context,
    CreateProductAdBuildable state,
  ) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        children: [
          LabelTextField(text: 'Название товара'),
          SizedBox(height: 6),
          CommonTextField(
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
          SizedBox(height: 16),
          LabelTextField(text: 'Категория'),
          SizedBox(height: 6),
          CustomDropdownField(
            text: state.category?.name ?? "",
            hint: "Категория",
            onTap: () {
              context.router.push(
                SelectionCategoryRoute(onResult: (categoryResponse) {
                  cubit(context).setSelectedCategory(categoryResponse);
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
    CreateProductAdBuildable state,
  ) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          ImageAdListWidget(
            imagePaths: cubit(context).getImages(),
            maxCount: state.maxImageCount,
            onTakePhotoClicked: () {
              cubit(context).takeImage();
            },
            onPickImageClicked: () {
              cubit(context).pickImage();
            },
            onImageClicked: (index) async {
              final result = await context.router.push(
                LocaleImageViewerRoute(
                  images: cubit(context).getImages(),
                  initialIndex: index,
                ),
              );

              if (result != null) {
                cubit(context).setChangedImageList(result as List<XFile>);
              }
            },
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
    CreateProductAdBuildable state,
  ) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(children: [
        LabelTextField(text: 'Описание товара'),
        SizedBox(height: 6),
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
        SizedBox(height: 16),
        _buildWarehouseCount(),
        SizedBox(height: 16),
        _buildPriceCount(context),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomSwitch(
              value: state.isAgreedPrice,
              onChanged: (value) {
                cubit(context).setAgreedPrice(value);
              },
            ),
            SizedBox(width: 16),
            Expanded(
              child: "Договорная".w(400).s(14).c(Color(0xFF41455E)),
            ),
          ],
        ),
      ]),
    );
  }

  Widget _buildContactsBlock(
    BuildContext context,
    CreateProductAdBuildable state,
  ) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8),
          "Контактная информация".w(700).s(16).c(Color(0xFF41455E)),
          SizedBox(height: 20),
          LabelTextField(text: "Местоположение"),
          SizedBox(height: 8),
          CustomDropdownField(
            text: state.address?.name ?? "",
            hint: "Местоположение",
            onTap: () {
              context.router.push(
                SelectionUserAddressRoute(onResult: (userAddressResponse) {
                  cubit(context).setSelectedAddress(userAddressResponse);
                }),
              );
            },
          ),
          SizedBox(height: 12),
          "Контактное лицо".w(500).s(14).c(Color(0xFF41455E)),
          SizedBox(height: 8),
          CommonTextField(
            autofillHints: const [AutofillHints.name],
            keyboardType: TextInputType.name,
            maxLines: 1,
            hint: 'Контактное лицо',
            inputType: TextInputType.name,
            textInputAction: TextInputAction.next,
            controller: contactPersonController,
            inputFormatters: phoneMaskFormatter,
            onChanged: (value) {},
          ),
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
            autofillHints: const [AutofillHints.email],
            keyboardType: TextInputType.emailAddress,
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

  Widget _buildAutoContinueBlock(
    BuildContext context,
    CreateProductAdBuildable state,
  ) {
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
                CustomSwitch(
                  value: state.isAutoRenewal,
                  onChanged: (value) {
                    cubit(context).setAutoRenewal(value);
                  },
                ),
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

  Widget _buildPinMySocialAccountsBlock(
    BuildContext context,
    CreateProductAdBuildable state,
  ) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          "Мои соц. сети".w(600).s(14).c(Color(0xFF41455E)),
          SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomSwitch(
                value: state.isShowMySocialAccount,
                onChanged: (value) {
                  cubit(context).setShowMySocialAccounts(value);
                },
              ),
              SizedBox(width: 16),
              Expanded(
                child: "Показать мои соц. сети на описание товара"
                    .w(400)
                    .s(14)
                    .c(Color(0xFF41455E)),
              ),
            ],
          ),
          SizedBox(height: 6),
        ],
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

  /// Build field methods

  Widget _buildWarehouseCount() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          flex: 3,
          child: Column(
            children: [
              LabelTextField(text: 'Кол-во на складе'),
              SizedBox(height: 6),
              CommonTextField(
                autofillHints: const [AutofillHints.telephoneNumber],
                inputType: TextInputType.number,
                keyboardType: TextInputType.number,
                maxLines: 1,
                minLines: 1,
                hint: '-',
                textInputAction: TextInputAction.next,
                controller: warehouseController,
                onChanged: (value) {},
              )
            ],
          ),
        ),
        SizedBox(width: 16),
        Flexible(
            flex: 2,
            child: Column(
              children: [
                LabelTextField(text: 'Тип', isRequired: false),
                SizedBox(height: 6),
                CustomDropdownField(
                  hint: "-",
                  onTap: () {},
                ),
              ],
            ))
      ],
    );
  }

  Widget _buildPriceCount(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          flex: 3,
          child: Column(
            children: [
              LabelTextField(text: 'Цена'),
              SizedBox(height: 6),
              CommonTextField(
                autofillHints: const [AutofillHints.telephoneNumber],
                inputType: TextInputType.number,
                keyboardType: TextInputType.number,
                maxLines: 1,
                minLines: 1,
                hint: '-',
                textInputAction: TextInputAction.next,
                controller: priceController,
                onChanged: (value) {},
              )
            ],
          ),
        ),
        SizedBox(width: 16),
        Flexible(
          flex: 2,
          child: Column(
            children: [
              LabelTextField(text: 'Валюта', isRequired: false),
              SizedBox(height: 6),
              CustomDropdownField(
                text: Strings.currencyUzb,
                hint: "-",
                onTap: () {
                  _showCurrencyBottomSheet(context);
                },
              ),
            ],
          ),
        )
      ],
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

  /// Bottom sheet showing methods

  void _showCurrencyBottomSheet(BuildContext context) {
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(height: 32),
              Center(child: "Выберите валюту".s(20).w(600)),
              SizedBox(height: 24),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  vibrateByTactile();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Strings.currencyUzb.w(500).s(16).c(Color(0xFF41455F)),
                          Assets.images.icRadioButtonSelected
                              .svg(height: 20, width: 20)
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              AppDivider(height: 2),
              SizedBox(height: 32)
            ],
          ),
        );
      },
    );
  }
}
