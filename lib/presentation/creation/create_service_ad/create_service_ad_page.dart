import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/controller/controller_exts.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/assets/assets.gen.dart';
import 'package:onlinebozor/common/widgets/app_bar/default_app_bar.dart';
import 'package:onlinebozor/common/widgets/chips/chip_add_item.dart';
import 'package:onlinebozor/common/widgets/chips/chip_item.dart';
import 'package:onlinebozor/common/widgets/chips/chip_list.dart';
import 'package:onlinebozor/common/widgets/image/image_ad_list_widget.dart';
import 'package:onlinebozor/common/widgets/switch/custom_switch.dart';
import 'package:onlinebozor/common/widgets/switch/custom_toggle.dart';
import 'package:onlinebozor/common/widgets/text_field/custom_dropdown_field.dart';
import 'package:onlinebozor/common/widgets/text_field/label_text_field.dart';
import 'package:onlinebozor/domain/models/image/uploadable_file.dart';
import 'package:onlinebozor/presentation/common/selection_currency/selection_currency_page.dart';
import 'package:onlinebozor/presentation/common/selection_region_and_district/selection_region_and_district_page.dart';
import 'package:onlinebozor/presentation/common/selection_user_address/selection_user_address_page.dart';

import '../../../../../common/core/base_page.dart';
import '../../../../../common/gen/localization/strings.dart';
import '../../../common/colors/static_colors.dart';
import '../../../common/router/app_router.dart';
import '../../../common/vibrator/vibrator_extension.dart';
import '../../../common/widgets/button/custom_elevated_button.dart';
import '../../../common/widgets/text_field/custom_text_field.dart';
import '../../common/selection_payment_type/selection_payment_type_page.dart';
import '../../utils/mask_formatters.dart';
import 'cubit/page_cubit.dart';

@RoutePage()
class CreateServiceAdPage extends BasePage<PageCubit, PageState, PageEvent> {
  CreateServiceAdPage({super.key});

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController fromPriceController = TextEditingController();
  final TextEditingController toPriceController = TextEditingController();
  final TextEditingController contactPersonController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController videoUrlController = TextEditingController();

  @override
  void onEventEmitted(BuildContext context, PageEvent event) {
    switch (event.type) {
      case PageEventType.onOverMaxCount:
        _showMaxCountError(context, event.maxImageCount);
      case PageEventType.onAdCreated:
        context.router.replace(CreateAdResultRoute());
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
    fromPriceController.updateOnRestore(state.fromPrice?.toString());
    toPriceController.updateOnRestore(state.toPrice?.toString());
    contactPersonController.updateOnRestore(state.contactPerson);
    phoneController.updateOnRestore(state.phone);
    emailController.updateOnRestore(state.email);
    videoUrlController.updateOnRestore(state.videoUrl);

    return Scaffold(
      appBar: DefaultAppBar(Strings.adCreateTitle, () => context.router.pop()),
      backgroundColor: StaticColors.backgroundColor,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
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
            _buildAutoContinueBlock(context, state),
            SizedBox(height: 20),
            _buildUsefulLinkBlock(context, state),
            SizedBox(height: 20),
            _buildFooterBlock(context, state),
            SizedBox(height: 20),
          ],
        ),
      ),
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
          LabelTextField(Strings.createAdNameLabel),
          SizedBox(height: 6),
          CustomTextField(
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
          LabelTextField(Strings.createAdCategoryLabel),
          SizedBox(height: 6),
          CustomDropdownField(
            text: state.category?.name ?? "",
            hint: Strings.createAdCategoryLabel,
            onTap: () {
              context.router.push(
                SelectionNestedCategoryRoute(onResult: (category) {
                  cubit(context).setSelectedCategory(category);
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

  Widget _buildDescAndPriceBlock(BuildContext context, PageState state) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 24),
              LabelTextField(Strings.createAdDescLabel),
              SizedBox(height: 8),
              CustomTextField(
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
              SizedBox(height: 8),
            ],
          ),
        ),
        SizedBox(height: 4),
        Container(
          color: Colors.white,
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
                        CustomTextField(
                          autofillHints: const [AutofillHints.transactionAmount],
                          inputType: TextInputType.number,
                          keyboardType: TextInputType.number,
                          maxLines: 1,
                          minLines: 1,
                          hint: "-",
                          textInputAction: TextInputAction.next,
                          controller: fromPriceController,
                          inputFormatters: amountMaskFormatter,
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
                    child:  Column(
                      children: [
                        LabelTextField(Strings.createAdToPriceLabel),
                        SizedBox(height: 6),
                        CustomTextField(
                          autofillHints: const [AutofillHints.transactionAmount],
                          inputType: TextInputType.number,
                          keyboardType: TextInputType.number,
                          maxLines: 1,
                          minLines: 1,
                          hint: "-",
                          textInputAction: TextInputAction.next,
                          controller: toPriceController,
                          inputFormatters: amountMaskFormatter,
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
          color: Colors.white,
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
              Wrap(
                direction: Axis.horizontal,
                spacing: 8,
                runSpacing: 8,
                alignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.start,
                runAlignment: WrapAlignment.start,
                children: _buildPaymentTypeChips(context, state),
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
      color: Colors.white,
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
          LabelTextField(Strings.createAdAddressLabel),
          SizedBox(height: 8),
          ChipList(
            chips: _buildServiceAddressChips(context, state),
            isShowAll: state.isShowAllFreeDeliveryDistricts,
            onClickedAdd: () {
              _showSelectionServiceAddress(context, state);
            },
            onClickedShowLess: () => cubit(context).showHideFreeDistricts(),
            onClickedShowMore: () => cubit(context).showHideFreeDistricts(),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildContactsBlock(BuildContext context, PageState state) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8),
          Strings.createAdContactInfoLabel.w(700).s(16).c(Color(0xFF41455E)),
          SizedBox(height: 20),
          LabelTextField(Strings.createAdAddressLabel),
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
          LabelTextField(Strings.createAdContactPersonLabel),
          SizedBox(height: 8),
          CustomTextField(
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
          LabelTextField(Strings.createAdContactPhoneLabel),
          SizedBox(height: 8),
          CustomTextField(
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
          LabelTextField(Strings.createAdContactEmailLabel),
          SizedBox(height: 8),
          CustomTextField(
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

  Widget _buildUsefulLinkBlock(BuildContext context, PageState state) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              Strings.createAdUsefulLinkLabel.w(600).s(14).c(Color(0xFF41455E)),
              SizedBox(height: 20),
              LabelTextField(Strings.createAdVideoUlrLabel, isRequired: false),
              SizedBox(height: 6),
              CustomTextField(
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
              SizedBox(height: 8),
            ],
          ),
        ),
        SizedBox(height: 4),
        Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            children: [
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
            ],
          ),
        )
      ],
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
          CustomElevatedButton(
            text: Strings.commonContinue,
            onPressed: () {
              vibrateAsHapticFeedback();
              cubit(context).createProductAd();
            },
            isLoading: state.isRequestSending,
          ),
        ],
      ),
    );
  }

  List<Widget> _buildPaymentTypeChips(BuildContext context, PageState state) {
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

  List<Widget> _buildServiceAddressChips(
    BuildContext context,
    PageState state,
  ) {
    return state.serviceDistricts
        .map(
          (element) => ChipItem(
            item: element,
            title: element.name,
            onChipClicked: (item) =>
                _showSelectionServiceAddress(context, state),
            onActionClicked: (item) => cubit(context).removeAddress(item),
          ),
        )
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
    cubit(context).setFreeDeliveryDistricts(districts);
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
