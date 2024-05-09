import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/presentation/support/colors/color_extension.dart';
import 'package:onlinebozor/presentation/support/extensions/controller_exts.dart';
import 'package:onlinebozor/presentation/support/cubit/base_page.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';
import 'package:onlinebozor/core/gen/assets/assets.gen.dart';
import 'package:onlinebozor/core/gen/localization/strings.dart';
import 'package:onlinebozor/presentation/support/vibrator/vibrator_extension.dart';
import 'package:onlinebozor/domain/models/ad/ad_transaction_type.dart';
import 'package:onlinebozor/domain/models/ad/ad_type.dart';
import 'package:onlinebozor/domain/models/image/uploadable_file.dart';
import 'package:onlinebozor/presentation/features/common/selection_currency/selection_currency_page.dart';
import 'package:onlinebozor/presentation/features/common/selection_payment_type/selection_payment_type_page.dart';
import 'package:onlinebozor/presentation/features/common/selection_region_and_district/selection_region_and_district_page.dart';
import 'package:onlinebozor/presentation/features/common/selection_user_address/selection_user_address_page.dart';
import 'package:onlinebozor/presentation/router/app_router.dart';
import 'package:onlinebozor/presentation/support/extensions/mask_formatters.dart';
import 'package:onlinebozor/presentation/widgets/ad/image_list/ad_image_list_widget.dart';
import 'package:onlinebozor/presentation/widgets/app_bar/default_app_bar.dart';
import 'package:onlinebozor/presentation/widgets/button/custom_elevated_button.dart';
import 'package:onlinebozor/presentation/widgets/chips/chip_item.dart';
import 'package:onlinebozor/presentation/widgets/chips/chip_list.dart';
import 'package:onlinebozor/presentation/widgets/form_field/custom_dropdown_form_field.dart';
import 'package:onlinebozor/presentation/widgets/form_field/custom_text_form_field.dart';
import 'package:onlinebozor/presentation/widgets/form_field/label_text_field.dart';
import 'package:onlinebozor/presentation/widgets/form_field/validator/count_validator.dart';
import 'package:onlinebozor/presentation/widgets/form_field/validator/default_validator.dart';
import 'package:onlinebozor/presentation/widgets/form_field/validator/phone_number_validator.dart';
import 'package:onlinebozor/presentation/widgets/form_field/validator/price_validator.dart';
import 'package:onlinebozor/presentation/widgets/loading/default_error_widget.dart';
import 'package:onlinebozor/presentation/widgets/loading/default_loading_widget.dart';
import 'package:onlinebozor/presentation/widgets/switch/custom_switch.dart';
import 'package:onlinebozor/presentation/widgets/switch/custom_toggle.dart';

import 'cubit/page_cubit.dart';

@RoutePage()
class CreateServiceAdPage extends BasePage<PageCubit, PageState, PageEvent> {
  CreateServiceAdPage({super.key, this.adId});

  final int? adId;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController fromPriceController = TextEditingController();
  final TextEditingController toPriceController = TextEditingController();
  final TextEditingController contactPersonController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController videoUrlController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void onWidgetCreated(BuildContext context) {
    cubit(context).setInitialParams(adId);
  }

  @override
  void onEventEmitted(BuildContext context, PageEvent event) {
    switch (event.type) {
      case PageEventType.onOverMaxCount:
        _showMaxCountError(context, event.maxImageCount);
      case PageEventType.onAdCreated:
        context.router.replace(CreateAdResultRoute(
          adId: cubit(context).states.adId!,
          adTransactionType: AdTransactionType.SERVICE,
        ));
    }
  }

  @override
  Widget onWidgetBuild(BuildContext context, PageState state) {
    titleController.updateOnRestore(state.title);
    descController.updateOnRestore(state.desc);
    fromPriceController.updateOnRestore(
      priceMaskFormatter.formatInt(state.fromPrice),
    );
    toPriceController.updateOnRestore(
      priceMaskFormatter.formatInt(state.toPrice),
    );
    contactPersonController.updateOnRestore(state.contactPerson);
    phoneController.updateOnRestore(
      phoneMaskFormatter.formatString(state.phone),
    );
    emailController.updateOnRestore(state.email);
    videoUrlController.updateOnRestore(state.videoUrl);

    return Scaffold(
      appBar: DefaultAppBar(
        titleText:
            state.isEditing ? Strings.adEditTitle : Strings.adCreateTitle,
        backgroundColor: context.backgroundColor,
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
                    _buildDescAndPriceBlock(context, state),
                    SizedBox(height: 20),
                    _buildAdditionalInfoBlock(context, state),
                    SizedBox(height: 20),
                    _buildContactsBlock(context, state),
                    SizedBox(height: 20),
                    _buildAutoRenewBlock(context, state),
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
      color: context.primaryContainer,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        children: [
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
          SizedBox(height: 6),
          CustomDropdownFormField(
            value: state.category?.name ?? "",
            hint: Strings.createAdCategoryLabel,
            validator: (value) => NotEmptyValidator.validate(value),
            onTap: () {
              context.router.push(
                SelectionNestedCategoryRoute(
                  adType: AdType.SERVICE,
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
      color: context.primaryContainer,
      child: Column(
        children: [
          AdImageListWidget(
            imagePaths: cubit(context).getImages(),
            maxCount: state.maxImageCount,
            validator: (value) => CountValidator.validate(value),
            onTakePhotoClicked: () => cubit(context).takeImage(),
            onPickImageClicked: () => cubit(context).pickImage(),
            onRemoveClicked: (path) => cubit(context).removeImage(path),
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
                LabelTextField(
                  Strings.createAdVideoUlrLabel,
                  isRequired: false,
                ),
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

  Widget _buildDescAndPriceBlock(BuildContext context, PageState state) {
    return Column(
      children: [
        Container(
          color: context.backgroundColor,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 24),
              LabelTextField(Strings.createAdDescLabel, isRequired: false),
              SizedBox(height: 8),
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
                textCapitalization: TextCapitalization.sentences,
                onChanged: (value) {
                  cubit(context).setEnteredDesc(value);
                },
              ),
              SizedBox(height: 8),
            ],
          ),
        ),
        SizedBox(height: 4),
        Container(
          color: context.backgroundColor,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Strings.createAdPriceLabel.w(700).s(16).c(Color(0xFF41455E)),
              SizedBox(height: 12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 5,
                    child: Column(
                      children: [
                        LabelTextField(Strings.createAdFromPriceLabel),
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
                          controller: fromPriceController,
                          inputFormatters: priceMaskFormatter,
                          validator: (value) => PriceValidator.validate(value),
                          onChanged: (value) {
                            cubit(context).setEnteredFromPrice(value);
                          },
                        )
                      ],
                    ),
                  ),
                  SizedBox(width: 16),
                  Flexible(
                    flex: 5,
                    child: Column(
                      children: [
                        LabelTextField(Strings.createAdToPriceLabel),
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
                          controller: toPriceController,
                          inputFormatters: priceMaskFormatter,
                          validator: (value) => PriceValidator.validate(value),
                          onChanged: (value) {
                            cubit(context).setEnteredToPrice(value);
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 5,
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
                  ),
                  SizedBox(width: 16),
                  Flexible(
                    flex: 5,
                    child: Container(),
                  ),
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
              SizedBox(height: 20),
            ],
          ),
        ),
        SizedBox(height: 4),
        Container(
          color: context.backgroundColor,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
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
        ),
      ],
    );
  }

  Widget _buildAdditionalInfoBlock(BuildContext context, PageState state) {
    return Container(
      color: context.primaryContainer,
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
          LabelTextField(Strings.createAdServiceAddresses),
          SizedBox(height: 8),
          ChipList(
            chips: _buildServiceAddressChips(context, state),
            isShowAll: state.isShowAllServiceDistricts,
            validator: (value) => CountValidator.validate(value),
            onClickedAdd: () {
              _showSelectionServiceAddress(context, state);
            },
            onClickedShowLess: () => cubit(context).showHideServiceDistricts(),
            onClickedShowMore: () => cubit(context).showHideServiceDistricts(),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildContactsBlock(BuildContext context, PageState state) {
    return Container(
      color: context.primaryContainer,
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
            textCapitalization: TextCapitalization.words,
            validator: (value) => NotEmptyValidator.validate(value),
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
            validator: (value) => PhoneNumberValidator.validate(value),
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

  Widget _buildAutoRenewBlock(BuildContext context, PageState state) {
    return Container(
      color: context.primaryContainer,
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
          color: context.primaryContainer,
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
      color: context.primaryContainer,
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
                cubit(context).createOrUpdateServiceAd();
              }
            },
            isLoading: state.isRequestSending,
          ),
        ],
      ),
    );
  }

  List<Widget> _buildPaymentTypeChips(BuildContext context, PageState state) {
    return state.paymentTypes
        .map((element) => ChipItem(
              item: element,
              title: element.name ?? "",
              onActionClicked: (item) {
                cubit(context).removeSelectedPaymentType(element);
              },
            ))
        .toList();
  }

  List<Widget> _buildServiceAddressChips(
    BuildContext context,
    PageState state,
  ) {
    return state.serviceDistricts
        .map((element) => ChipItem(
              item: element,
              title: element.name,
              onChipClicked: (item) =>
                  _showSelectionServiceAddress(context, state),
              onActionClicked: (item) =>
                  cubit(context).removeRequestAddress(item),
            ))
        .toList();
  }

  Future<void> _showSelectionServiceAddress(
    BuildContext context,
    PageState state,
  ) async {
    final districts = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (context) => SelectionRegionAndDistrictPage(
        initialSelectedDistricts: state.serviceDistricts,
      ),
    );
    cubit(context).setServiceDistricts(districts);
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
