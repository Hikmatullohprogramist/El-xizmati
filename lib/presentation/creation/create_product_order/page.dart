import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/assets/assets.gen.dart';
import 'package:onlinebozor/common/gen/localization/strings.dart';
import 'package:onlinebozor/common/router/app_router.dart';
import 'package:onlinebozor/common/widgets/button/common_button.dart';
import 'package:onlinebozor/common/widgets/text_field/common_text_field.dart';
import 'package:onlinebozor/common/widgets/text_field/custom_dropdown_field.dart';
import 'package:onlinebozor/common/widgets/text_field/label_text_field.dart';

import '../../../../../common/core/base_page.dart';
import '../../../common/widgets/chips/chips_add_item.dart';
import '../../../common/widgets/chips/chips_item.dart';
import '../../../common/widgets/image/image_ad_list_widget.dart';
import '../../../common/widgets/switch/custom_switch.dart';
import '../../common/selection_currency/page.dart';
import '../../common/selection_payment_type/page.dart';
import '../../common/selection_user_address/page.dart';
import '../../utils/mask_formatters.dart';
import 'cubit/page_cubit.dart';

@RoutePage()
class CreateProductOrderPage
    extends BasePage<PageCubit, PageState, PageEvent> {
  CreateProductOrderPage({super.key});

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController fromPriceController = TextEditingController();
  final TextEditingController toPriceController = TextEditingController();
  final TextEditingController phoneController = TextEditingController(text: '');
  final TextEditingController emailController = TextEditingController();

  @override
  void onEventEmitted(BuildContext context, PageEvent event) {
    switch (event.type) {
      case PageEventType.onOverMaxCount:
        _showMaxCountError(context, event.maxImageCount);
    }
  }

  @override
  Widget onWidgetBuild(BuildContext context, PageState state) {
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
            _buildAutoContinueBlock(state,context),
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
    PageState state,
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
              context.read<PageCubit>().setName(value);
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
                SelectionNestedCategoryRoute(onResult: (categoryResponse) {
                  cubit(context).setCategory(categoryResponse);
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
    PageState state,
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
    PageState state,
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
                  inputFormatters: quantityMaskFormatter,
                  onChanged: (value) {
                    context.read<PageCubit>().setFromPrice(value);
                  },
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: CommonTextField(
                  hint: "До",
                  controller: toPriceController,
                  inputType: TextInputType.number,
                  inputFormatters: quantityMaskFormatter,
                  onChanged: (value) {
                    context.read<PageCubit>().setToPrice(value);
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          LabelTextField(text: "Валюта"),
          SizedBox(height: 8),
          SizedBox(
              width: 150,
              child:   CustomDropdownField(
                text: state.currenc?.name?? "",
                hint: "-",
                onTap: () async {
                  // _showCurrencyBottomSheet(context);
                  final currency = await showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    useSafeArea: true,
                    backgroundColor: Colors.transparent,
                    builder: (context) => SelectionCurrencyPage(
                      key: Key(""),
                      initialSelectedItem: state.currenc,
                    ),
                  );
                  cubit(context).setSelectedCurrency(currency);
                },
              ),
          ),
          SizedBox(height: 20),
          LabelTextField(text: 'Способ оплаты', isRequired: true),
          SizedBox(height: 16),
          Wrap(
            direction: Axis.horizontal,
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.start,
            runAlignment: WrapAlignment.start,
            children: _buildPaymentTypeChips(context, state),
          ),
          SizedBox(height: 25,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomSwitch(
                isChecked: state.isNegotiate,
                onChanged: (value) {
                  context.read<PageCubit>().setNegative(value);
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
       //  "Контактное лицо".w(500).s(14).c(Color(0xFF41455E)),
       //  SizedBox(height: 8),
       //  CommonTextField(
       //    autofillHints: const [AutofillHints.telephoneNumber],
       //    keyboardType: TextInputType.phone,
       //    maxLines: 1,
       //    hint: 'Контактное лицо',
       //    inputType: TextInputType.phone,
       //    textInputAction: TextInputAction.next,
       //    controller: phoneController,
       //    inputFormatters: phoneMaskFormatter,
       //    onChanged: (value) {
       //
       //    },
       //  ),
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
          SizedBox(height: 12),
          "Номер телефона".w(500).s(14).c(Color(0xFF41455E)),
          SizedBox(height: 8),
          CommonTextField(
            autofillHints: const [AutofillHints.telephoneNumber],
            keyboardType: TextInputType.phone,
            maxLines: 1,
            prefixText: "+998 ",
            inputType: TextInputType.phone,
            textInputAction: TextInputAction.next,
            controller: phoneController,
            // inputFormatters: phoneMaskFormatter,
            onChanged: (value) {
              cubit(context).setPhoneNumber(value);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAddressBlock(
    BuildContext context,
    PageState state,
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
            hint:state.address?.name??"Моё местоположения",
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
                SelectionUserAddressRoute(),
              );
            },
          ),
        ],
      ),

    );
  }

  Widget _buildAutoContinueBlock(PageState state,BuildContext context) {
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
                child: Strings.commonContinue
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
  List<Widget> _buildPaymentTypeChips(
      BuildContext context,
      PageState state,
      ) {
    List<Widget> chips = [];
    chips.add(
      ChipsAddItem(
        onAddClicked: () async {
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
      ),
    );
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
}
