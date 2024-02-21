import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/assets/assets.gen.dart';
import 'package:onlinebozor/common/widgets/common/bottom_sheet_title.dart';
import 'package:onlinebozor/common/widgets/common/chips_item.dart';
import 'package:onlinebozor/common/widgets/common/custom_dropdown_field.dart';
import 'package:onlinebozor/common/widgets/common/label_text_field.dart';
import 'package:onlinebozor/common/widgets/common/selection_list_item.dart';
import 'package:onlinebozor/common/widgets/image/image_ad_list_widget.dart';
import 'package:onlinebozor/common/widgets/switch/custom_switch.dart';
import 'package:onlinebozor/common/widgets/switch/custom_toggle.dart';
import 'package:onlinebozor/presentation/common/selection_unit/selection_unit_page.dart';
import 'package:onlinebozor/presentation/common/selection_user_address/selection_user_address.dart';

import '../../../../../common/core/base_page.dart';
import '../../../../../common/gen/localization/strings.dart';
import '../../../../../common/widgets/common/common_text_field.dart';
import '../../../common/router/app_router.dart';
import '../../../common/vibrator/vibrator_extension.dart';
import '../../../common/widgets/common/common_button.dart';
import '../../../common/widgets/dashboard/app_diverder.dart';
import '../../common/selection_payment_type/selection_payment_type_page.dart';
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
            _buildAdditionalInfoBlock(context, state),
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
            onChanged: (value) {
              cubit(context).setEnteredTitle(value);
            },
          ),
          SizedBox(height: 16),
          LabelTextField(text: 'Категория'),
          SizedBox(height: 6),
          CustomDropdownField(
            text: state.category?.name ?? "",
            hint: "Категория",
            onTap: () {
              context.router.push(
                SelectionNestedCategoryRoute(onResult: (categoryResponse) {
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
            onChanged: (value) {
              cubit(context).setEnteredDesc(value);
            },
          ),
          SizedBox(height: 16),
          Row(
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
                      onChanged: (value) {
                        cubit(context).setEnteredWarehouseCount(value);
                      },
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
                        text: state.unit?.name ?? "",
                        hint: "-",
                        onTap: () async {
                          final unit = await showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            useSafeArea: true,
                            backgroundColor: Colors.transparent,
                            builder: (context) => SelectionUnitPage(
                              key: Key(""),
                              selectedUnit: state.unit,
                            ),
                          );

                          cubit(context).setSelectedUnit(unit);
                        },
                      ),
                    ],
                  ))
            ],
          ),
          SizedBox(height: 16),
          Row(
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
                      onChanged: (value) {
                        cubit(context).setEnteredPrice(value);
                      },
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
                      onTap: () async {
                        _showCurrencyBottomSheet(context);
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: 16),
          LabelTextField(text: 'Способ оплаты', isRequired: true),
          SizedBox(height: 16),
          Wrap(
            direction: Axis.horizontal,
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.start,
            runAlignment: WrapAlignment.start,
            children: _buildChips(context, state),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomSwitch(
                isChecked: state.isAgreedPrice,
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
        ],
      ),
    );
  }

  List<Widget> _buildChips(
    BuildContext context,
    CreateProductAdBuildable state,
  ) {
    List<Widget> chips = [];
    chips.add(InkWell(
      onTap: () async {
        final paymentTypes = await showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          useSafeArea: true,
          backgroundColor: Colors.transparent,
          builder: (context) => SelectionPaymentTypePage(
            key: Key(""),
            selectedPaymentTypes: state.paymentTypes,
          ),
        );

        cubit(context).setSelectedPaymentTypes(paymentTypes);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          border: Border.all(width: 1, color: Color(0xFF5C6AC4)),
        ),
        child: Icon(Icons.add),
      ),
    ));
    chips.addAll(state.paymentTypes
        .map(
          (element) => ChipsItem(
            item: element,
            title: element.name ?? "",
            onRemoveClicked: (item) {
              cubit(context).removeSelectedPaymentType(element);
            },
          ),
        )
        .toList());
    return chips;
  }

  Widget _buildAdditionalInfoBlock(
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
          "Дополнительная информация".w(700).s(16).c(Color(0xFF41455E)),
          SizedBox(height: 20),
          LabelTextField(text: "Бизнес или личное", isRequired: false),
          SizedBox(height: 8),
          CustomToggle(
            width: 240,
            isChecked: state.isBusiness,
            onChanged: (isChecked) {
              cubit(context).setIsBusiness(isChecked);
            },
            negativeTitle: "Личное",
            positiveTitle: "Бизнес",
          ),
          SizedBox(height: 16),
          LabelTextField(text: "Состояние", isRequired: false),
          SizedBox(height: 8),
          CustomToggle(
            width: 240,
            isChecked: state.isNew,
            onChanged: (isChecked) {
              cubit(context).setIsNew(isChecked);
            },
            negativeTitle: "Б / У",
            positiveTitle: "Новый",
          ),
        ],
      ),
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
            onTap: () async {
              final address = await showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                useSafeArea: true,
                backgroundColor: Colors.transparent,
                builder: (context) => SelectionUserAddressPage(
                  key: Key(""),
                  selectedAddress: state.address,
                ),
              );

              cubit(context).setSelectedAddress(address);
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
                  isChecked: state.isAutoRenewal,
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
                isChecked: state.isShowMySocialAccount,
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
            ),
          ),
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(height: 32),
              BottomSheetTitle(
                title: "Выберите валюту",
                onCloseClicked: () {
                  context.router.pop();
                },
              ),
              SizedBox(height: 12),
              SelectionListItem(
                item: "",
                title: Strings.currencyUzb,
                isSelected: true,
                onClicked: (item) {
                  context.router.pop();
                  vibrateAsHapticFeedback();
                },
              ),
              AppDivider(height: 2, indent: 20, endIndent: 20),
              SizedBox(height: 32)
            ],
          ),
        );
      },
    );
  }
}
