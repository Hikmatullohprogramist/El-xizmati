import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/controller/controller_exts.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/assets/assets.gen.dart';
import 'package:onlinebozor/common/widgets/chips/chip_add_item.dart';
import 'package:onlinebozor/common/widgets/chips/chip_item.dart';
import 'package:onlinebozor/common/widgets/chips/chip_list.dart';
import 'package:onlinebozor/common/widgets/image/image_ad_list_widget.dart';
import 'package:onlinebozor/common/widgets/switch/custom_switch.dart';
import 'package:onlinebozor/common/widgets/switch/custom_toggle.dart';
import 'package:onlinebozor/common/widgets/text_field/custom_dropdown_field.dart';
import 'package:onlinebozor/common/widgets/text_field/label_text_field.dart';
import 'package:onlinebozor/domain/models/ad/ad_transaction_type.dart';
import 'package:onlinebozor/domain/models/image/uploadable_file.dart';
import 'package:onlinebozor/presentation/common/selection_currency/selection_currency_page.dart';
import 'package:onlinebozor/presentation/common/selection_region_and_district/selection_region_and_district_page.dart';
import 'package:onlinebozor/presentation/common/selection_unit/selection_unit_page.dart';
import 'package:onlinebozor/presentation/common/selection_user_address/selection_user_address_page.dart';
import 'package:onlinebozor/presentation/common/selection_user_warehouse/selection_user_warehouse_page.dart';
import 'package:onlinebozor/presentation/utils/enum_resource_exts.dart';

import '../../../../../common/core/base_page.dart';
import '../../../../../common/gen/localization/strings.dart';
import '../../../common/colors/static_colors.dart';
import '../../../common/router/app_router.dart';
import '../../../common/vibrator/vibrator_extension.dart';
import '../../../common/widgets/action/selection_list_item.dart';
import '../../../common/widgets/bottom_sheet/bottom_sheet_title.dart';
import '../../../common/widgets/button/custom_elevated_button.dart';
import '../../../common/widgets/divider/custom_diverder.dart';
import '../../../common/widgets/text_field/common_text_field.dart';
import '../../common/selection_payment_type/selection_payment_type_page.dart';
import '../../utils/mask_formatters.dart';
import 'cubit/page_cubit.dart';

@RoutePage()
class CreateProductAdPage extends BasePage<PageCubit, PageState, PageEvent> {
  CreateProductAdPage({super.key});

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController anotherTitleController = TextEditingController();
  final TextEditingController anotherDescController = TextEditingController();
  final TextEditingController warehouseController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  final TextEditingController contactPersonController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  void onEventEmitted(BuildContext context, PageEvent event) {
    switch (event.type) {
      case PageEventType.onOverMaxCount:
        _showMaxCountError(context, event.maxImageCount);
    }
  }

  @override
  void onWidgetCreated(BuildContext context) {
    cubit(context).getInitialData();
  }

  @override
  Widget onWidgetBuild(BuildContext context, PageState state) {
    titleController.updateOnRestore(state.title);
    descController.updateOnRestore(state.desc);
    anotherTitleController.updateOnRestore(state.anotherTitle);
    anotherDescController.updateOnRestore(state.anotherDesc);
    warehouseController.updateOnRestore(state.warehouseCount?.toString());
    priceController.updateOnRestore(state.price?.toString());
    contactPersonController.updateOnRestore(state.contactPerson);
    phoneController.updateOnRestore(state.phone);
    emailController.updateOnRestore(state.email);

    return Scaffold(
      appBar: _buildAppBar(context),
      backgroundColor: StaticColors.backgroundColor,
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
            _buildAnotherAdBlock(context, state),
            SizedBox(height: 16),
            _buildContactsBlock(context, state),
            SizedBox(height: 16),
            _buildPickupBlock(context, state),
            SizedBox(height: 4),
            _buildFreeDeliveryBlock(context, state),
            SizedBox(height: 4),
            _buildPaidDeliveryBlock(context, state),
            SizedBox(height: 16),
            _buildAutoContinueBlock(context, state),
            SizedBox(height: 16),
            _buildPinMySocialAccountsBlock(context, state),
            SizedBox(height: 16),
            _buildFooterBlock(context, state),
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
    PageState state,
  ) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        children: [
          LabelTextField(text: Strings.createAdNameLabel),
          SizedBox(height: 6),
          CommonTextField(
            autofillHints: const [AutofillHints.name],
            inputType: TextInputType.name,
            keyboardType: TextInputType.name,
            minLines: 1,
            maxLines: 3,
            hint: Strings.createAdNameLabel,
            textInputAction: TextInputAction.next,
            controller: titleController,
            onChanged: (value) {
              cubit(context).setEnteredTitle(value);
            },
          ),
          SizedBox(height: 16),
          LabelTextField(text: Strings.createAdCategoryLabel),
          SizedBox(height: 6),
          CustomDropdownField(
            text: state.category?.name ?? "",
            hint: Strings.createAdCategoryLabel,
            onTap: () {
              context.router.push(
                SelectionNestedCategoryRoute(onResult: (categoryResponse) {
                  cubit(context).setSelectedCategory(categoryResponse);
                }),
              );
            },
          ),
          SizedBox(height: 16),
          LabelTextField(text: Strings.createAdTransactionTypeLabel),
          SizedBox(height: 6),
          CustomDropdownField(
            text: state.adTransactionType.getString(),
            hint: Strings.createAdTransactionTypeLabel,
            onTap: () {
              _showAdTransactionTypeSelectionBottomSheet(context, state);
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
                cubit(context)
                    .setChangedImageList(result as List<UploadableFile>);
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
    PageState state,
  ) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LabelTextField(text: Strings.createAdDescLabel),
          SizedBox(height: 6),
          CommonTextField(
            height: null,
            autofillHints: const [AutofillHints.name],
            inputType: TextInputType.name,
            keyboardType: TextInputType.name,
            maxLines: 5,
            minLines: 3,
            hint: Strings.createAdDescHint,
            textInputAction: TextInputAction.next,
            controller: descController,
            onChanged: (value) {
              cubit(context).setEnteredDesc(value);
            },
          ),
          Visibility(
            visible: state.adTransactionType != AdTransactionType.FREE,
            child: SizedBox(height: 16),
          ),
          Visibility(
            visible: state.adTransactionType != AdTransactionType.FREE,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: 5,
                  child: Column(
                    children: [
                      LabelTextField(text: Strings.createAdWarehouseCountLabel),
                      SizedBox(height: 6),
                      CommonTextField(
                        autofillHints: const [AutofillHints.telephoneNumber],
                        inputType: TextInputType.number,
                        keyboardType: TextInputType.number,
                        maxLines: 1,
                        minLines: 1,
                        hint: "-",
                        textInputAction: TextInputAction.next,
                        controller: warehouseController,
                        inputFormatters: quantityMaskFormatter,
                        onChanged: (value) {
                          cubit(context).setEnteredWarehouseCount(value);
                        },
                      )
                    ],
                  ),
                ),
                SizedBox(width: 16),
                Flexible(
                    flex: 4,
                    child: Column(
                      children: [
                        LabelTextField(
                          text: Strings.createAdWarehouseUnitLabel,
                          isRequired: false,
                        ),
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
          ),
          Visibility(
            visible: state.adTransactionType != AdTransactionType.FREE,
            child: SizedBox(height: 16),
          ),
          Visibility(
            visible: state.adTransactionType != AdTransactionType.FREE,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: 5,
                  child: Column(
                    children: [
                      LabelTextField(text: Strings.createAdPriceLabel),
                      SizedBox(height: 6),
                      CommonTextField(
                        autofillHints: const [AutofillHints.transactionAmount],
                        inputType: TextInputType.number,
                        keyboardType: TextInputType.number,
                        maxLines: 1,
                        minLines: 1,
                        hint: "-",
                        textInputAction: TextInputAction.next,
                        controller: priceController,
                        inputFormatters: amountMaskFormatter,
                        onChanged: (value) {
                          cubit(context).setEnteredPrice(value);
                        },
                      )
                    ],
                  ),
                ),
                SizedBox(width: 16),
                Flexible(
                  flex: 4,
                  child: Column(
                    children: [
                      LabelTextField(
                        text: Strings.createAdCurrencyLabel,
                        isRequired: false,
                      ),
                      SizedBox(height: 6),
                      CustomDropdownField(
                        text: state.currency?.name ?? "",
                        hint: "-",
                        onTap: () async {
                          final currency = await showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            useSafeArea: true,
                            backgroundColor: Colors.transparent,
                            builder: (context) => SelectionCurrencyPage(
                              initialSelectedItem: state.currency,
                            ),
                          );
                          cubit(context).setSelectedCurrency(currency);
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Visibility(
            visible: state.adTransactionType != AdTransactionType.FREE,
            child: SizedBox(height: 8),
          ),
          Visibility(
            visible: state.adTransactionType != AdTransactionType.FREE,
            child: Row(
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
                  child: Strings.createAdNegotiableLabel
                      .w(400)
                      .s(14)
                      .c(Color(0xFF41455E)),
                ),
              ],
            ),
          ),
          Visibility(
            visible: state.adTransactionType != AdTransactionType.FREE,
            child: SizedBox(height: 24),
          ),
          Visibility(
            visible: state.adTransactionType != AdTransactionType.FREE,
            child: LabelTextField(
              text: Strings.createAdPaymentTypeLabel,
              isRequired: true,
            ),
          ),
          Visibility(
            visible: state.adTransactionType != AdTransactionType.FREE,
            child: SizedBox(height: 16),
          ),
          Visibility(
            visible: state.adTransactionType != AdTransactionType.FREE,
            child: Wrap(
              direction: Axis.horizontal,
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.start,
              crossAxisAlignment: WrapCrossAlignment.start,
              runAlignment: WrapAlignment.start,
              children: _buildPaymentTypeChips(context, state),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdditionalInfoBlock(
    BuildContext context,
    PageState state,
  ) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8),
          Strings.createAdAdditionalInfoLabel.w(700).s(16).c(Color(0xFF41455E)),
          SizedBox(height: 20),
          LabelTextField(
            text: Strings.createAdPersonalOrBusinessLabel,
            isRequired: false,
          ),
          SizedBox(height: 8),
          CustomToggle(
            width: 240,
            isChecked: state.isBusiness,
            onChanged: (isChecked) {
              cubit(context).setIsBusiness(isChecked);
            },
            negativeTitle: Strings.createAdPersonalLabel,
            positiveTitle: Strings.createAdBusinessLabel,
          ),
          SizedBox(height: 16),
          LabelTextField(text: Strings.createAdStateLabel, isRequired: false),
          SizedBox(height: 8),
          CustomToggle(
            width: 240,
            isChecked: state.isNew,
            onChanged: (isChecked) {
              cubit(context).setIsNew(isChecked);
            },
            negativeTitle: Strings.createAdStateUsedLabel,
            positiveTitle: Strings.createAdStateNewLabel,
          ),
        ],
      ),
    );
  }

  Widget _buildAnotherAdBlock(
      BuildContext context,
      PageState state,
      ) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Strings.createAdExchangeLabel.w(700).s(16).c(Color(0xFF41455E)),
          SizedBox(height: 20),
          LabelTextField(text: Strings.createAdNameLabel),
          SizedBox(height: 6),
          CommonTextField(
            autofillHints: const [AutofillHints.name],
            inputType: TextInputType.name,
            keyboardType: TextInputType.name,
            minLines: 1,
            maxLines: 3,
            hint: Strings.createAdNameLabel,
            textInputAction: TextInputAction.next,
            controller: anotherTitleController,
            onChanged: (value) {
              cubit(context).setEnteredAnotherTitle(value);
            },
          ),
          SizedBox(height: 16),
          LabelTextField(text: Strings.createAdCategoryLabel),
          SizedBox(height: 6),
          CustomDropdownField(
            text: state.anotherCategory?.name ?? "",
            hint: Strings.createAdCategoryLabel,
            onTap: () {
              context.router.push(
                SelectionNestedCategoryRoute(onResult: (categoryResponse) {
                  cubit(context).setSelectedAnotherCategory(categoryResponse);
                }),
              );
            },
          ),
          SizedBox(height: 16),
          LabelTextField(text: Strings.createAdDescLabel),
          SizedBox(height: 6),
          CommonTextField(
            height: null,
            autofillHints: const [AutofillHints.name],
            inputType: TextInputType.name,
            keyboardType: TextInputType.name,
            maxLines: 5,
            minLines: 3,
            hint: Strings.createAdDescLabel,
            textInputAction: TextInputAction.next,
            controller: anotherDescController,
            onChanged: (value) {
              cubit(context).setEnteredAnotherDesc(value);
            },
          ),
          SizedBox(height: 16),
          LabelTextField(text: Strings.createAdStateLabel, isRequired: false),
          SizedBox(height: 8),
          CustomToggle(
            width: 240,
            isChecked: state.isAnotherNew,
            onChanged: (isChecked) {
              cubit(context).setAnotherIsNew(isChecked);
            },
            negativeTitle: Strings.createAdStateUsedLabel,
            positiveTitle: Strings.createAdStateNewLabel,
          ),
        ],
      ),
    );
  }

  Widget _buildContactsBlock(
    BuildContext context,
    PageState state,
  ) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8),
          Strings.createAdContactInfoLabel.w(700).s(16).c(Color(0xFF41455E)),
          SizedBox(height: 20),
          LabelTextField(text: Strings.createAdAddressLabel),
          SizedBox(height: 8),
          CustomDropdownField(
            text: state.address?.name ?? "",
            hint: Strings.createAdAddressLabel,
            onTap: () async {
              final address = await showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                useSafeArea: true,
                backgroundColor: Colors.transparent,
                builder: (context) => SelectionUserAddressPage(
                  selectedAddress: state.address,
                ),
              );

              cubit(context).setSelectedAddress(address);
            },
          ),
          SizedBox(height: 12),
          LabelTextField(text: Strings.createAdContactPersonLabel),
          SizedBox(height: 8),
          CommonTextField(
            autofillHints: const [AutofillHints.name],
            keyboardType: TextInputType.name,
            maxLines: 1,
            hint: Strings.createAdContactPersonLabel,
            inputType: TextInputType.name,
            textInputAction: TextInputAction.next,
            controller: contactPersonController,
            onChanged: (value) {
              cubit(context).setEnteredContactPerson(value);
            },
          ),
          SizedBox(height: 12),
          LabelTextField(text: Strings.createAdContactPhoneLabel),
          SizedBox(height: 8),
          CommonTextField(
            autofillHints: const [AutofillHints.telephoneNumber],
            keyboardType: TextInputType.phone,
            maxLines: 1,
            hint: "",
            prefixText: "+998",
            validateType: "phone",
            inputType: TextInputType.phone,
            textInputAction: TextInputAction.next,
            controller: phoneController,
            inputFormatters: phoneMaskFormatter,
            onChanged: (value) {
              cubit(context).setEnteredPhone(value);
            },
          ),
          SizedBox(height: 12),
          LabelTextField(text: Strings.createAdContactEmailLabel),
          SizedBox(height: 8),
          CommonTextField(
            autofillHints: const [AutofillHints.email],
            keyboardType: TextInputType.emailAddress,
            inputType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            hint: Strings.createAdContactEmailLabel,
            validateType: "email",
            maxLines: 1,
            controller: emailController,
            onChanged: (value) {
              cubit(context).setEnteredEmail(value);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPickupBlock(
    BuildContext context,
    PageState state,
  ) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8),
          Strings.createAdReceiveTypesLabel.w(600).s(16).c(Color(0xFF41455E)),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomSwitch(
                isChecked: state.isPickupEnabled,
                onChanged: (value) {
                  cubit(context).setPickupEnabling(value);
                },
              ),
              SizedBox(width: 16),
              Expanded(
                child: Strings.createAdPickupLabel
                    .w(600)
                    .s(14)
                    .c(Color(0xFF41455E)),
              ),
            ],
          ),
          Visibility(
            visible: state.isPickupEnabled,
            child: SizedBox(height: 24),
          ),
          Visibility(
            visible: state.isPickupEnabled,
            child: ChipList(
              chips: _buildPickupAddressChips(context, state),
              isShowAll: state.isShowAllPickupAddresses,
              onClickedAdd: () {
                _showSelectionPickup(context, state);
              },
              onClickedShowLess: () => cubit(context).showHideAddresses(),
              onClickedShowMore: () => cubit(context).showHideAddresses(),
            ),
          ),
          SizedBox(height: 6),
        ],
      ),
    );
  }

  Widget _buildFreeDeliveryBlock(
    BuildContext context,
    PageState state,
  ) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomSwitch(
                isChecked: state.isFreeDeliveryEnabled,
                onChanged: (value) {
                  cubit(context).setFreeDeliveryEnabling(value);
                },
              ),
              SizedBox(width: 16),
              Expanded(
                child: Strings.createAdFreeDeliveryLabel
                    .w(600)
                    .s(14)
                    .c(Color(0xFF41455E)),
              ),
            ],
          ),
          Visibility(
            visible: state.isFreeDeliveryEnabled,
            child: SizedBox(height: 24),
          ),
          Visibility(
            visible: state.isFreeDeliveryEnabled,
            child: ChipList(
              chips: _buildFreeDeliveryChips(context, state),
              isShowAll: state.isShowAllFreeDeliveryDistricts,
              onClickedAdd: () {
                _showSelectionFreeDistrict(context, state);
              },
              onClickedShowLess: () => cubit(context).showHideFreeDistricts(),
              onClickedShowMore: () => cubit(context).showHideFreeDistricts(),
            ),
          ),
          SizedBox(height: 6),
        ],
      ),
    );
  }

  Widget _buildPaidDeliveryBlock(
    BuildContext context,
    PageState state,
  ) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomSwitch(
                isChecked: state.isPaidDeliveryEnabled,
                onChanged: (value) {
                  cubit(context).setPaidDeliveryEnabling(value);
                },
              ),
              SizedBox(width: 16),
              Expanded(
                child: Strings.createAdPaidDeliveryLabel
                    .w(600)
                    .s(14)
                    .c(Color(0xFF41455E)),
              ),
            ],
          ),
          Visibility(
            visible: state.isPaidDeliveryEnabled,
            child: SizedBox(height: 24),
          ),
          Visibility(
            visible: state.isPaidDeliveryEnabled,
            child: ChipList(
              chips: _buildPaidDeliveryChips(context, state),
              isShowAll: state.isShowAllPaidDeliveryDistricts,
              onClickedAdd: () {
                _showSelectionPaidDistrict(context, state);
              },
              onClickedShowLess: () => cubit(context).showHidePaidDistricts(),
              onClickedShowMore: () => cubit(context).showHidePaidDistricts(),
            ),
          ),
          SizedBox(height: 6),
        ],
      ),
    );
  }

  Widget _buildAutoContinueBlock(
    BuildContext context,
    PageState state,
  ) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Strings.createAdAutoRenewLabel.w(600).s(14).c(Color(0xFF41455E)),
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
                  child: (state.isAutoRenewal
                          ? Strings.createAdAutoRenewOnDesc
                          : Strings.createAdAutoRenewOffDesc)
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
    PageState state,
  ) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Strings.createAdUsefulLinkLabel.w(600).s(14).c(Color(0xFF41455E)),
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
                child: Strings.createAdShowMySocialAccountsLabel
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

  Widget _buildFooterBlock(
    BuildContext context,
    PageState state,
  ) {
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
                child: Strings.createAdRequiredFieldsLabel
                    .w(300)
                    .s(13)
                    .c(context.colors.textSecondary),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: CustomElevatedButton(
                  text: Strings.commonContinue,
                  onPressed: () {
                    vibrateAsHapticFeedback();
                    cubit(context).createProductAd();
                    // cubit(context).uploadImage();
                  },
                  isLoading: state.isRequestSending,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showAdTransactionTypeSelectionBottomSheet(
    BuildContext context,
    PageState state,
  ) {
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
              SizedBox(height: 12),
              BottomSheetTitle(
                title: Strings.selectionAdTransactionTypeTitle,
                onCloseClicked: () {
                  context.router.pop();
                },
              ),
              SizedBox(height: 16),
              SelectionListItem(
                item: AdTransactionType.SELL,
                title: Strings.adTransactionTypeSell,
                isSelected: state.adTransactionType == AdTransactionType.SELL,
                onClicked: (item) {
                  cubit(context).setSelectedAdTransactionType(item);
                  context.router.pop();
                },
              ),
              CustomDivider(height: 2, startIndent: 20, endIndent: 20),
              SelectionListItem(
                item: AdTransactionType.FREE,
                title: Strings.adTransactionTypeFree,
                isSelected: state.adTransactionType == AdTransactionType.FREE,
                onClicked: (item) {
                  cubit(context).setSelectedAdTransactionType(item);
                  context.router.pop();
                },
              ),
              CustomDivider(height: 2, startIndent: 20, endIndent: 20),
              SelectionListItem(
                item: AdTransactionType.EXCHANGE,
                title: Strings.adTransactionTypeExchange,
                isSelected:
                    state.adTransactionType == AdTransactionType.EXCHANGE,
                onClicked: (item) {
                  cubit(context).setSelectedAdTransactionType(item);
                  context.router.pop();
                },
              ),
              SizedBox(height: 32)
            ],
          ),
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
      ChipAddItem(
        onClicked: () async {
          final paymentTypes = await showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            useSafeArea: true,
            backgroundColor: Colors.transparent,
            builder: (context) => SelectionPaymentTypePage(
              selectedPaymentTypes: state.paymentTypes,
            ),
          );
          cubit(context).setSelectedPaymentTypes(paymentTypes);
        },
      ),
    );
    chips.addAll(state.paymentTypes
        .map(
          (element) => ChipItem(
            item: element,
            title: element.name ?? "",
            onActionClicked: (item) {
              cubit(context).removeSelectedPaymentType(element);
            },
          ),
        )
        .toList());
    return chips;
  }

  List<Widget> _buildPickupAddressChips(BuildContext context, PageState state) {
    return state.pickupWarehouses
        .map(
          (element) => ChipItem(
            item: element,
            title: element.name ?? "",
            onChipClicked: (item) => _showSelectionPickup(context, state),
            onActionClicked: (item) => cubit(context).removePickupAddress(item),
          ),
        )
        .toList();
  }

  void _showSelectionPickup(
    BuildContext context,
    PageState state,
  ) async {
    final pickupAddresses = await showModalBottomSheet(
      context: context,
      isScrollControlled: false,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (context) => SelectionUserWarehousePage(
        selectedItems: state.pickupWarehouses,
      ),
    );

    cubit(context).setSelectedPickupAddresses(pickupAddresses);
  }

  List<Widget> _buildFreeDeliveryChips(BuildContext context, PageState state) {
    return state.freeDeliveryDistricts
        .map(
          (element) => ChipItem(
            item: element,
            title: element.name,
            onChipClicked: (item) => _showSelectionFreeDistrict(context, state),
            onActionClicked: (item) => cubit(context).removeFreeDelivery(item),
          ),
        )
        .toList();
  }

  Future<void> _showSelectionFreeDistrict(
    BuildContext context,
    PageState state,
  ) async {
    final districts = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (context) => SelectionRegionAndDistrictPage(
        initialSelectedDistricts: state.freeDeliveryDistricts,
      ),
    );
    cubit(context).setFreeDeliveryDistricts(districts);
  }

  List<Widget> _buildPaidDeliveryChips(BuildContext context, PageState state) {
    return state.paidDeliveryDistricts
        .map(
          (element) => ChipItem(
            item: element,
            title: element.name,
            onChipClicked: (item) => _showSelectionPaidDistrict(context, state),
            onActionClicked: (item) {
              cubit(context).removePaidDelivery(item);
            },
          ),
        )
        .toList();
  }

  Future<void> _showSelectionPaidDistrict(
    BuildContext context,
    PageState state,
  ) async {
    final districts = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (context) => SelectionRegionAndDistrictPage(
        initialSelectedDistricts: state.paidDeliveryDistricts,
      ),
    );
    cubit(context).setPaidDeliveryDistricts(districts);
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
