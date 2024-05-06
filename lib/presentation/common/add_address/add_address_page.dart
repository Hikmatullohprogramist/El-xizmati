import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/controller/controller_exts.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/localization/strings.dart';
import 'package:onlinebozor/common/widgets/action/selection_list_item.dart';
import 'package:onlinebozor/common/widgets/app_bar/default_app_bar.dart';
import 'package:onlinebozor/common/widgets/button/custom_elevated_button.dart';
import 'package:onlinebozor/common/widgets/button/custom_outlined_button.dart';

import '../../../../../../../../common/widgets/switch/custom_switch.dart';
import '../../../../../../../../data/responses/address/user_address_response.dart';
import '../../../common/vibrator/vibrator_extension.dart';
import '../../../common/widgets/form_field/custom_dropdown_form_field.dart';
import '../../../common/widgets/form_field/custom_text_form_field.dart';
import '../../../common/widgets/form_field/label_text_field.dart';
import '../../../common/widgets/form_field/validator/default_validator.dart';
import 'cubit/page_cubit.dart';

@RoutePage()
class AddAddressPage extends BasePage<AddAddressCubit, PageState, PageEvent> {
  AddAddressPage({super.key, this.address});

  final UserAddressResponse? address;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void onWidgetCreated(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      cubit(context).setInitialParams(address);
    });
  }

  @override
  void onEventEmitted(BuildContext context, PageEvent event) {
    switch (event.type) {
      case PageEventType.backOnSuccess:
        context.router.pop(true);
    }
  }

  TextEditingController addressController = TextEditingController();
  TextEditingController apartmentNumberController = TextEditingController();
  TextEditingController homeNumberController = TextEditingController();
  TextEditingController streetController = TextEditingController();

  @override
  Widget onWidgetBuild(BuildContext context, PageState state) {
    addressController.updateOnRestore(state.addressName);
    apartmentNumberController.updateOnRestore(state.apartmentNum);
    homeNumberController.updateOnRestore(state.homeNumber);
    streetController.updateOnRestore(state.streetName);

    return Scaffold(
      appBar: DefaultAppBar(
        titleText: state.isEditing
            ? Strings.userAddressEditTitle
            : Strings.userAddressAddTitle,
        backgroundColor: context.appBarColor,
        onBackPressed: () => context.router.pop(false),
      ),
      backgroundColor: context.backgroundColor,
      body: Form(
        key: _formKey,
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            SizedBox(height: 16),
            _buildAddressNameBlock(context),
            SizedBox(height: 12),
            _buildRegionBlock(context, state),
            SizedBox(height: 12),
            _buildAdditionalInfo(context, state),
            SizedBox(height: 12),
            _buildLocationBlock(context, state),
            SizedBox(height: 12),
            _buildFooterBlock(context, state),
            SizedBox(height: 16)
          ],
        ),
      ),
    );
  }

  /// Build block

  Widget _buildAddressNameBlock(BuildContext context) {
    return Container(
      color: context.primaryContainer,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        children: [
          LabelTextField(Strings.userAddressAddress),
          SizedBox(height: 12),
          CustomTextFormField(
            controller: addressController,
            hint: Strings.userAddressAddress,
            validator: (value) => NotEmptyValidator.validate(value),
            onChanged: (value) {
              cubit(context).setEnteredAddressName(value);
            },
            textInputAction: TextInputAction.next,
          ),
        ],
      ),
    );
  }

  Widget _buildRegionBlock(BuildContext context, PageState state) {
    return Container(
      color: context.primaryContainer,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        children: [
          LabelTextField(Strings.commonRegion),
          SizedBox(height: 8),
          CustomDropdownFormField(
            hint: Strings.commonRegion,
            value: state.regionName ?? "",
            validator: (value) => NotEmptyValidator.validate(value),
            onTap: () {
              _showRegionSelection(context, state);
            },
          ),
          SizedBox(height: 12),
          LabelTextField(Strings.commonDistrict),
          SizedBox(height: 8),
          CustomDropdownFormField(
            hint: Strings.commonDistrict,
            value: state.districtName ?? "",
            validator: (value) => NotEmptyValidator.validate(value),
            onTap: () {
              _showDistrictSelection(context, state);
            },
          ),
          SizedBox(height: 12),
          LabelTextField(Strings.commonNeighborhood),
          SizedBox(height: 8),
          CustomDropdownFormField(
            hint: Strings.commonNeighborhood,
            value: state.neighborhoodName ?? "",
            validator: (value) => NotEmptyValidator.validate(value),
            onTap: () {
              _showNeighborhoodSelection(context, state);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAdditionalInfo(BuildContext context, PageState state) {
    return Container(
      color: context.primaryContainer,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    LabelTextField(Strings.commonStreet, isRequired: false),
                    SizedBox(height: 8),
                    CustomTextFormField(
                      controller: streetController,
                      hint: Strings.commonStreet,
                      onChanged: (value) {
                        cubit(context).setStreetName(value);
                      },
                      textInputAction: TextInputAction.next,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 6),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    LabelTextField(Strings.commonHomeNumber, isRequired: false),
                    SizedBox(height: 8),
                    CustomTextFormField(
                      hint: Strings.commonHomeNumber,
                      onChanged: (value) {
                        cubit(context).setHomeNumber(value);
                      },
                      controller: homeNumberController,
                      textInputAction: TextInputAction.next,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  children: [
                    LabelTextField(Strings.commonApartment, isRequired: false),
                    SizedBox(height: 8),
                    CustomTextFormField(
                      hint: Strings.commonApartment,
                      onChanged: (value) {
                        cubit(context).setApartmentNumber(value);
                      },
                      controller: apartmentNumberController,
                      textInputAction: TextInputAction.done,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLocationBlock(BuildContext context, PageState state) {
    return Container(
      color: context.primaryContainer,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Strings.userAddressLocation.w(600).s(16),
          SizedBox(height: 12),
          LabelTextField(Strings.userAddressTakenLocation, isRequired: true),
          SizedBox(height: 8),
          Text(cubit(context).getFormattedLocation()),
          SizedBox(height: 8),
          CustomOutlinedButton(
            text: Strings.userAddressGetLocation,
            isLoading: state.isLocationLoading,
            onPressed: () {
              cubit(context).getCurrentLocation();
            },
          ),
        ],
      ),
    );
  }

  _buildFooterBlock(BuildContext context, PageState state) {
    return Container(
      color: context.primaryContainer,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomSwitch(
                isChecked: state.isMain ?? false,
                onChanged: (value) {
                  cubit(context).setMainCard(value);
                },
              ),
              SizedBox(width: 16),
              Expanded(
                child: Strings.actionMakeMain.s(14).w(500).c(Color(0xFF41455E)),
              ),
            ],
          ),
          SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 42,
            child: CustomElevatedButton(
              text: (state.isEditing ? Strings.commonSave : Strings.commonAdd),
              onPressed: () {
                vibrateAsHapticFeedback();
                if (_formKey.currentState!.validate()) {
                  cubit(context).addOrUpdateAddress();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  /// show bottom sheets

  _showRegionSelection(BuildContext context, PageState state) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext bc) {
        return Container(
          height: double.infinity,
          decoration: BoxDecoration(
            color: context.bottomNavigationColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          padding: EdgeInsets.only(top: 20),
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: state.regions.length,
            itemBuilder: (BuildContext buildContext, int index) {
              var item = state.regions[index];
              return SelectionListItem(
                item: item,
                title: item.name,
                isSelected: item.id == state.regionId,
                onClicked: (item) {
                  cubit(context).setSelectedRegion(item);
                  Navigator.pop(buildContext);
                },
              );
            },
          ),
        );
      },
    );
  }

  _showDistrictSelection(BuildContext context, PageState state) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext bc) {
        return Container(
          height: double.infinity,
          decoration: BoxDecoration(
            color: context.bottomNavigationColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          padding: EdgeInsets.only(top: 20),
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: state.districts.length,
            itemBuilder: (BuildContext buildContext, int index) {
              var item = state.districts[index];
              return SelectionListItem(
                item: item,
                title: item.name,
                isSelected: item.id == state.districtId,
                onClicked: (item) {
                  cubit(context).setSelectedDistrict(item);
                  Navigator.pop(buildContext);
                },
              );
            },
          ),
        );
      },
    );
  }

  _showNeighborhoodSelection(BuildContext context, PageState state) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext bc) {
        return Container(
          height: double.infinity,
          decoration: BoxDecoration(
            color: context.bottomNavigationColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          padding: EdgeInsets.only(top: 20),
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: state.neighborhoods.length,
            itemBuilder: (BuildContext buildContext, int index) {
              var item = state.neighborhoods[index];
              return SelectionListItem(
                item: item,
                title: item.name,
                isSelected: item.id == state.neighborhoodId,
                onClicked: (item) {
                  cubit(context).setSelectedNeighborhood(item);
                  Navigator.pop(buildContext);
                },
              );
            },
          ),
        );
      },
    );
  }
}
