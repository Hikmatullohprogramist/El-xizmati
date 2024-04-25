import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/controller/controller_exts.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/assets/assets.gen.dart';
import 'package:onlinebozor/common/widgets/ad/image_list/ad_image_list_widget.dart';
import 'package:onlinebozor/common/widgets/app_bar/default_app_bar.dart';
import 'package:onlinebozor/common/widgets/chips/chip_item.dart';
import 'package:onlinebozor/common/widgets/chips/chip_list.dart';
import 'package:onlinebozor/common/widgets/form_field/validator/default_validator.dart';
import 'package:onlinebozor/common/widgets/switch/custom_switch.dart';
import 'package:onlinebozor/common/widgets/switch/custom_toggle.dart';
import 'package:onlinebozor/domain/models/ad/ad_transaction_type.dart';
import 'package:onlinebozor/domain/models/image/uploadable_file.dart';
import 'package:onlinebozor/presentation/common/selection_currency/selection_currency_page.dart';
import 'package:onlinebozor/presentation/common/selection_region_and_district/selection_region_and_district_page.dart';
import 'package:onlinebozor/presentation/common/selection_unit/selection_unit_page.dart';
import 'package:onlinebozor/presentation/common/selection_user_address/selection_user_address_page.dart';
import 'package:onlinebozor/presentation/common/selection_user_warehouse/selection_user_warehouse_page.dart';
import 'package:onlinebozor/presentation/utils/resource_exts.dart';

import '../../../../../common/core/base_page.dart';
import '../../../../../common/gen/localization/strings.dart';
import '../../../common/router/app_router.dart';
import '../../../common/vibrator/vibrator_extension.dart';
import '../../../common/widgets/action/selection_list_item.dart';
import '../../../common/widgets/bottom_sheet/bottom_sheet_title.dart';
import '../../../common/widgets/button/custom_elevated_button.dart';
import '../../../common/widgets/divider/custom_diverder.dart';
import '../../../common/widgets/form_field/custom_dropdown_form_field.dart';
import '../../../common/widgets/form_field/custom_text_form_field.dart';
import '../../../common/widgets/form_field/label_text_field.dart';
import '../../../common/widgets/form_field/validator/count_validator.dart';
import '../../../common/widgets/loading/default_error_widget.dart';
import '../../../common/widgets/loading/default_loading_widget.dart';
import '../../../domain/models/ad/ad_type.dart';
import '../../common/selection_payment_type/selection_payment_type_page.dart';
import '../../utils/mask_formatters.dart';
import 'cubit/page_cubit.dart';

@RoutePage()
class CreateProductAdPage extends BasePage<PageCubit, PageState, PageEvent> {
  CreateProductAdPage({
    super.key,
    this.adId,
    this.adTransactionType = AdTransactionType.SELL,
  });

  int? adId;
  final AdTransactionType adTransactionType;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController warehouseController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController exchangeTitleController = TextEditingController();
  final TextEditingController exchangeDescController = TextEditingController();
  final TextEditingController contactPersonController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController paidDelPriceController = TextEditingController();
  final TextEditingController videoUrlController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void onWidgetCreated(BuildContext context) {
    cubit(context).setInitialParams(adId, adTransactionType);
  }

  @override
  void onEventEmitted(BuildContext context, PageEvent event) {
    switch (event.type) {
      case PageEventType.onOverMaxCount:
        _showMaxCountError(context, event.maxImageCount);
      case PageEventType.onAdCreated:
        context.router.replace(CreateAdResultRoute(
          adId: cubit(context).states.adId!,
          adTransactionType: cubit(context).states.adTransactionType,
        ));
    }
  }

  @override
  Widget onWidgetBuild(BuildContext context, PageState state) {
    titleController.updateOnRestore(state.title);
    descController.updateOnRestore(state.desc);
    warehouseController.updateOnRestore(
      quantityMaskFormatter.formatInt(state.warehouseCount),
    );
    priceController.updateOnRestore(priceMaskFormatter.formatInt(state.price));
    exchangeTitleController.updateOnRestore(state.exchangeTitle);
    exchangeDescController.updateOnRestore(state.exchangeDesc);
    contactPersonController.updateOnRestore(state.contactPerson);
    phoneController.updateOnRestore(
      phoneMaskFormatter.formatString(state.phone),
    );
    emailController.updateOnRestore(state.email);
    paidDelPriceController.updateOnRestore(
      priceMaskFormatter.formatInt(state.paidDeliveryPrice),
    );
    videoUrlController.updateOnRestore(state.videoUrl);

    return Scaffold(
      appBar: DefaultAppBar(
        titleText:
            state.isEditing ? Strings.adEditTitle : Strings.adCreateTitle,
        backgroundColor: context.appBarColor,
        onBackPressed: () => context.router.pop(),
      ),
      backgroundColor: context.backgroundColor,
      body: state.isNotPrepared
          ? Container(
              child: state.isPreparingInProcess
                  ? DefaultLoadingWidget(isFullScreen: true)
                  : DefaultErrorWidget(
                      isFullScreen: true,
                      onRetryClicked: () =>
                          cubit(context).getEditingInitialData(),
                    ),
            )
          : SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 20),
                    _buildTitleAndCategoryBlock(context, state),
                    SizedBox(height: 20),
                    _buildImageListBlock(context, state),
                    SizedBox(height: 20),
                    _buildDescBlock(context, state),
                    _buildPriceBlock(context, state),
                    SizedBox(height: 20),
                    _buildAdditionalInfoBlock(context, state),
                    SizedBox(height: cubit(context).isExchangeMode() ? 16 : 0),
                    _buildExchangeAdBlock(context, state),
                    SizedBox(height: 20),
                    _buildContactsBlock(context, state),
                    SizedBox(height: 20),
                    _buildPickupBlock(context, state),
                    SizedBox(height: 4),
                    _buildFreeDeliveryBlock(context, state),
                    SizedBox(height: 4),
                    _buildPaidDeliveryBlock(context, state),
                    SizedBox(height: 20),
                    _buildAutoContinueBlock(context, state),
                    SizedBox(height: 20),
                    _buildUsefulLinkBlock(context, state),
                    SizedBox(height: 20),
                    _buildFooterBlock(context, state),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
    );
  }

  /// Build block methods

  Widget _buildTitleAndCategoryBlock(BuildContext context, PageState state) {
    return Container(
      color: context.cardColor,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        children: [
          LabelTextField(Strings.createAdTransactionTypeLabel),
          SizedBox(height: 6),
          CustomDropdownFormField(
            value: state.adTransactionType.getLocalizedName(),
            hint: Strings.createAdTransactionTypeLabel,
            validator: (value) => NotEmptyValidator.validate(value),
            onTap: () {
              _showAdTransactionTypeSelectionBottomSheet(context, state);
            },
          ),
          SizedBox(height: 16),
          LabelTextField(Strings.createAdNameLabel),
          SizedBox(height: 6),
          CustomTextFormField(
            autofillHints: const [AutofillHints.name],
            inputType: TextInputType.name,
            keyboardType: TextInputType.name,
            minLines: 1,
            maxLines: 3,
            hint: Strings.createAdNameLabel,
            textInputAction: TextInputAction.next,
            controller: titleController,
            validator: (value) => NotEmptyValidator.validate(value),
            textCapitalization: TextCapitalization.sentences,
            onChanged: (value) {
              cubit(context).setEnteredTitle(value);
            },
          ),
          SizedBox(height: 16),
          LabelTextField(Strings.createAdCategoryLabel),
          SizedBox(height: 6),
          CustomDropdownFormField(
            value: state.category?.name ?? "",
            hint: Strings.createAdCategoryLabel,
            validator: (value) => NotEmptyValidator.validate(value),
            onTap: () {
              context.router.push(
                SelectionNestedCategoryRoute(
                  adType: AdType.PRODUCT,
                  onResult: (category) {
                    cubit(context).setSelectedCategory(category);
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildImageListBlock(BuildContext context, PageState state) {
    return Container(
      color: context.cardColor,
      child: Column(
        children: [
          AdImageListWidget(
            imagePaths: cubit(context).getImages(),
            maxCount: state.maxImageCount,
            validator: (value) => CountValidator.validate(value),
            onTakePhotoClicked: () => cubit(context).takeImage(),
            onPickImageClicked: () => cubit(context).pickImage(),
            onRemoveClicked: (file) => cubit(context).removeImage(file),
            onReorder: (i, j) => cubit(context).onReorder(i, j),
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
          ),
          SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                LabelTextField(Strings.createAdVideoUlrLabel,
                    isRequired: false),
                SizedBox(height: 6),
                CustomTextFormField(
                  autofillHints: const [AutofillHints.url],
                  keyboardType: TextInputType.url,
                  maxLines: 1,
                  hint: Strings.createAdVideoUlrLabel,
                  inputType: TextInputType.url,
                  textInputAction: TextInputAction.done,
                  controller: videoUrlController,
                  onChanged: (value) {
                    cubit(context).setEnteredVideoUrl(value);
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildDescBlock(BuildContext context, PageState state) {
    return Container(
      color: context.cardColor,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 24),
          LabelTextField(Strings.createAdDescLabel, isRequired: false),
          SizedBox(height: 6),
          CustomTextFormField(
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
          SizedBox(height: cubit(context).isFreeAdMode() ? 24 : 0),
        ],
      ),
    );
  }

  Widget _buildPriceBlock(BuildContext context, PageState state) {
    return cubit(context).isFreeAdMode()
        ? SizedBox(height: 0, width: 0)
        : Container(
            color: context.cardColor,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      flex: 5,
                      child: Column(
                        children: [
                          LabelTextField(Strings.createAdWarehouseCountLabel),
                          SizedBox(height: 6),
                          CustomTextFormField(
                            autofillHints: const [
                              AutofillHints.telephoneNumber
                            ],
                            inputType: TextInputType.number,
                            keyboardType: TextInputType.number,
                            maxLines: 1,
                            minLines: 1,
                            hint: "-",
                            textInputAction: TextInputAction.next,
                            controller: warehouseController,
                            inputFormatters: quantityMaskFormatter,
                            validator: (v) => NotEmptyValidator.validate(v),
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
                          LabelTextField(Strings.createAdWarehouseUnitLabel),
                          SizedBox(height: 6),
                          CustomDropdownFormField(
                            value: state.unit?.name ?? "",
                            hint: "-",
                            validator: (v) => NotEmptyValidator.validate(v),
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
                      ),
                    )
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      flex: 5,
                      child: Column(
                        children: [
                          LabelTextField(Strings.createAdPriceLabel),
                          SizedBox(height: 6),
                          CustomTextFormField(
                            autofillHints: const [
                              AutofillHints.transactionAmount
                            ],
                            inputType: TextInputType.number,
                            keyboardType: TextInputType.number,
                            maxLines: 1,
                            minLines: 1,
                            hint: "-",
                            textInputAction: TextInputAction.next,
                            inputFormatters: priceMaskFormatter,
                            controller: priceController,
                            validator: (v) => NotEmptyValidator.validate(v),
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
                          LabelTextField(Strings.createAdCurrencyLabel),
                          SizedBox(height: 6),
                          CustomDropdownFormField(
                            value: state.currency?.name ?? "",
                            hint: "-",
                            validator: (v) => NotEmptyValidator.validate(v),
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
                SizedBox(height: 8),
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
                      child: Strings.createAdNegotiableLabel
                          .w(400)
                          .s(14)
                          .c(Color(0xFF41455E)),
                    ),
                  ],
                ),
                SizedBox(height: 24),
                LabelTextField(
                  Strings.createAdPaymentTypeLabel,
                  isRequired: true,
                ),
                SizedBox(height: 16),
                ChipList(
                  chips: _buildPaymentTypeChips(context, state),
                  isShowAll: true,
                  isShowChildrenCount: false,
                  validator: (value) => CountValidator.validate(value),
                  onClickedAdd: () async {
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
                  onClickedShowLess: () {},
                  onClickedShowMore: () {},
                ),
                SizedBox(height: 24),
              ],
            ),
          );
  }

  Widget _buildAdditionalInfoBlock(BuildContext context, PageState state) {
    return Container(
      color: context.cardColor,
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8),
          Strings.createAdAdditionalInfoLabel.w(700).s(16).c(Color(0xFF41455E)),
          SizedBox(height: 20),
          LabelTextField(
            Strings.createAdPersonalOrBusinessLabel,
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
          LabelTextField(Strings.createAdStateLabel, isRequired: false),
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

  Widget _buildExchangeAdBlock(BuildContext context, PageState state) {
    return !cubit(context).isExchangeMode()
        ? SizedBox(height: 0, width: 0)
        : Container(
            color: context.cardColor,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Strings.createAdExchangeLabel.w(700).s(16).c(Color(0xFF41455E)),
                SizedBox(height: 20),
                LabelTextField(Strings.createAdNameLabel),
                SizedBox(height: 6),
                CustomTextFormField(
                  autofillHints: const [AutofillHints.name],
                  inputType: TextInputType.name,
                  keyboardType: TextInputType.name,
                  minLines: 1,
                  maxLines: 3,
                  hint: Strings.createAdNameLabel,
                  textInputAction: TextInputAction.next,
                  controller: exchangeTitleController,
                  validator: (value) => NotEmptyValidator.validate(value),
                  onChanged: (value) {
                    cubit(context).setEnteredAnotherTitle(value);
                  },
                ),
                SizedBox(height: 16),
                LabelTextField(Strings.createAdCategoryLabel),
                SizedBox(height: 6),
                CustomDropdownFormField(
                  value: state.exchangeCategory?.name ?? "",
                  hint: Strings.createAdCategoryLabel,
                  validator: (value) => NotEmptyValidator.validate(value),
                  onTap: () {
                    context.router.push(
                      SelectionNestedCategoryRoute(
                        adType: AdType.PRODUCT,
                        onResult: (category) {
                          cubit(context).setSelectedAnotherCategory(category);
                        },
                      ),
                    );
                  },
                ),
                SizedBox(height: 16),
                LabelTextField(Strings.createAdDescLabel, isRequired: false),
                SizedBox(height: 6),
                CustomTextFormField(
                  height: null,
                  autofillHints: const [AutofillHints.name],
                  inputType: TextInputType.name,
                  keyboardType: TextInputType.name,
                  maxLines: 5,
                  minLines: 3,
                  hint: Strings.createAdDescLabel,
                  textInputAction: TextInputAction.next,
                  controller: exchangeDescController,
                  textCapitalization: TextCapitalization.sentences,
                  onChanged: (value) {
                    cubit(context).setEnteredAnotherDesc(value);
                  },
                ),
                SizedBox(height: 16),
                LabelTextField(Strings.createAdStateLabel, isRequired: false),
                SizedBox(height: 8),
                CustomToggle(
                  width: 240,
                  isChecked: state.isExchangeNew,
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
      color: context.cardColor,
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8),
          Strings.createAdContactInfoLabel.w(700).s(16).c(Color(0xFF41455E)),
          SizedBox(height: 20),
          LabelTextField(Strings.createAdAddressLabel),
          SizedBox(height: 8),
          CustomDropdownFormField(
            value: state.address?.name ?? "",
            hint: Strings.createAdAddressLabel,
            validator: (value) => NotEmptyValidator.validate(value),
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
          LabelTextField(Strings.createAdContactPersonLabel),
          SizedBox(height: 8),
          CustomTextFormField(
            autofillHints: const [AutofillHints.name],
            keyboardType: TextInputType.name,
            maxLines: 1,
            hint: Strings.createAdContactPersonLabel,
            inputType: TextInputType.name,
            textInputAction: TextInputAction.next,
            controller: contactPersonController,
            validator: (value) => NotEmptyValidator.validate(value),
            textCapitalization: TextCapitalization.words,
            onChanged: (value) {
              cubit(context).setEnteredContactPerson(value);
            },
          ),
          SizedBox(height: 12),
          LabelTextField(Strings.createAdContactPhoneLabel),
          SizedBox(height: 8),
          CustomTextFormField(
            autofillHints: const [AutofillHints.telephoneNumber],
            keyboardType: TextInputType.phone,
            maxLines: 1,
            hint: "",
            prefixText: "+998",
            inputType: TextInputType.phone,
            textInputAction: TextInputAction.next,
            controller: phoneController,
            inputFormatters: phoneMaskFormatter,
            validator: (value) => NotEmptyValidator.validate(value),
            onChanged: (value) {
              cubit(context).setEnteredPhone(value);
            },
          ),
          SizedBox(height: 12),
          LabelTextField(Strings.commonEmail, isRequired: false),
          SizedBox(height: 8),
          CustomTextFormField(
            autofillHints: const [AutofillHints.email],
            keyboardType: TextInputType.emailAddress,
            inputType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            hint: Strings.commonEmail,
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
      color: context.cardColor,
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
          if (state.isPickupEnabled) SizedBox(height: 24),
          if (state.isPickupEnabled)
            ChipList(
              chips: _buildPickupAddressChips(context, state),
              isShowAll: state.isShowAllPickupAddresses,
              validator: (value) => CountValidator.validate(value),
              onClickedAdd: () {
                _showSelectionPickup(context, state);
              },
              onClickedShowLess: () => cubit(context).showHideAddresses(),
              onClickedShowMore: () => cubit(context).showHideAddresses(),
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
      color: context.cardColor,
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
          if (state.isFreeDeliveryEnabled) SizedBox(height: 24),
          if (state.isFreeDeliveryEnabled)
            ChipList(
              chips: _buildFreeDeliveryChips(context, state),
              isShowAll: state.isShowAllFreeDeliveryDistricts,
              validator: (value) => CountValidator.validate(value),
              onClickedAdd: () {
                _showSelectionFreeDistrict(context, state);
              },
              onClickedShowLess: () => cubit(context).showHideFreeDistricts(),
              onClickedShowMore: () => cubit(context).showHideFreeDistricts(),
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
      color: context.cardColor,
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
          if (state.isPaidDeliveryEnabled) SizedBox(height: 24),
          if (state.isPaidDeliveryEnabled)
            LabelTextField(Strings.createAdPaidDeliveryPriceLabel),
          if (state.isPaidDeliveryEnabled) SizedBox(height: 6),
          if (state.isPaidDeliveryEnabled)
            CustomTextFormField(
              autofillHints: const [AutofillHints.transactionAmount],
              inputType: TextInputType.number,
              keyboardType: TextInputType.number,
              maxLines: 1,
              minLines: 1,
              hint: "-",
              textInputAction: TextInputAction.done,
              controller: paidDelPriceController,
              inputFormatters: priceMaskFormatter,
              validator: (value) => NotEmptyValidator.validate(value),
              onChanged: (value) {
                cubit(context).setEnteredPaidDeliveryPrice(value);
              },
            ),
          if (state.isPaidDeliveryEnabled) SizedBox(height: 12),
          if (state.isPaidDeliveryEnabled)
            ChipList(
              chips: _buildPaidDeliveryChips(context, state),
              isShowAll: state.isShowAllPaidDeliveryDistricts,
              validator: (value) => CountValidator.validate(value),
              onClickedAdd: () {
                _showSelectionPaidDistrict(context, state);
              },
              onClickedShowLess: () => cubit(context).showHidePaidDistricts(),
              onClickedShowMore: () => cubit(context).showHidePaidDistricts(),
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
      color: context.cardColor,
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

  Widget _buildUsefulLinkBlock(BuildContext context, PageState state) {
    return Column(
      children: [
        Container(
          color: context.cardColor,
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
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
              SizedBox(height: 20),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildFooterBlock(BuildContext context, PageState state) {
    return Container(
      color: context.cardColor,
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
          CustomElevatedButton(
            text: Strings.commonSave,
            onPressed: () {
              vibrateAsHapticFeedback();
              if (_formKey.currentState!.validate()) {
                cubit(context).createOrUpdateProductAd();
              }
            },
            isLoading: state.isRequestSending,
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
            color: context.backgroundColor,
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

  List<Widget> _buildPaymentTypeChips(BuildContext context, PageState state) {
    return state.paymentTypes
        .map(
          (element) => ChipItem(
            item: element,
            title: element.name ?? "",
            onActionClicked: (item) {
              cubit(context).removeSelectedPaymentType(element);
            },
          ),
        )
        .toList();
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
