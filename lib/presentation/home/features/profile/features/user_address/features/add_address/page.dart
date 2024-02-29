import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/localization/strings.dart';
import 'package:onlinebozor/common/widgets/app_bar/default_app_bar.dart';
import 'package:onlinebozor/common/widgets/common/label_text_field.dart';

import '../../../../../../../../common/widgets/common/common_button.dart';
import '../../../../../../../../common/widgets/common/common_text_field.dart';
import '../../../../../../../../common/widgets/common/custom_dropdown_field.dart';
import '../../../../../../../../common/widgets/switch/custom_switch.dart';
import '../../../../../../../../data/responses/address/user_address_response.dart';
import 'cubit/page_cubit.dart';

@RoutePage()
class AddAddressPage extends BasePage<AddAddressCubit, PageState, PageEvent> {
  AddAddressPage({super.key, this.address});

  final UserAddressResponse? address;

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
      case PageEventType.onStartLoading:
        _showFullScreenDialog(context);
      case PageEventType.onFinishLoading:
        Navigator.pop(context);
    }
  }

  TextEditingController addressController = TextEditingController();
  TextEditingController apartmentController = TextEditingController();
  TextEditingController houseController = TextEditingController();
  TextEditingController streetController = TextEditingController();

  @override
  Widget onWidgetBuild(BuildContext context, PageState state) {
    addressController.text != state.addressName
        ? addressController.text = state.addressName ?? ""
        : addressController.text = addressController.text;
    houseController.text != state.homeNumber
        ? houseController.text = state.homeNumber ?? ""
        : houseController.text = state.homeNumber ?? "";
    apartmentController.text != state.apartmentNum
        ? apartmentController.text = state.apartmentNum ?? ""
        : apartmentController.text = state.apartmentNum ?? "";
    streetController.text != state.neighborhoodNum
        ? streetController.text = state.neighborhoodNum ?? ""
        : streetController.text = state.neighborhoodNum ?? "";

    return Scaffold(
        appBar: DefaultAppBar(
          state.isEditing
              ? Strings.userAddressEditTitle
              : Strings.userAddressAddTitle,
          () => context.router.pop(false),
        ),
        backgroundColor: Color(0xFFF2F4FB),
        body: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            SizedBox(height: 16),
            _buildAddressNameBlock(context),
            SizedBox(height: 12),
            _buildRegionBlock(context, state),
            SizedBox(height: 12),
            _buildAdditionalInfo(context, state),
            SizedBox(height: 12),
            _buildFooterBlock(context, state),
            SizedBox(height: 16)
          ],
        ));
  }

  /// Build block

  Widget _buildAddressNameBlock(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        children: [
          LabelTextField(text: Strings.userAddressAddress),
          SizedBox(height: 12),
          CommonTextField(
            controller: addressController,
            hint: Strings.userAddressAddress,
            onChanged: (value) {
              cubit(context).setAddressName(value);
            },
            textInputAction: TextInputAction.next,
          ),
        ],
      ),
    );
  }

  Widget _buildRegionBlock(BuildContext context, PageState state) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        children: [
          LabelTextField(text: Strings.commonRegion),
          SizedBox(height: 8),
          CustomDropdownField(
            hint: Strings.commonRegion,
            text: state.regionName ?? "",
            onTap: () {
              _showRegionSelection(context, state);
            },
          ),
          SizedBox(height: 12),
          LabelTextField(text: Strings.commonDistrict),
          SizedBox(height: 8),
          CustomDropdownField(
            hint: Strings.commonDistrict,
            text: state.districtName ?? "",
            onTap: () {
              _showDistrictSelection(context, state);
            },
          ),
          SizedBox(height: 12),
          LabelTextField(text: Strings.commonNeighborhood),
          SizedBox(height: 8),
          CustomDropdownField(
            hint: Strings.commonNeighborhood,
            text: state.streetName ?? "",
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
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    LabelTextField(
                      text: Strings.commonStreet,
                      isRequired: false,
                    ),
                    SizedBox(height: 8),
                    CommonTextField(
                      controller: streetController,
                      hint: Strings.commonStreet,
                      onChanged: (value) {
                        cubit(context).setNeighborhoodNum(value);
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
                    LabelTextField(
                      text: Strings.commonHomeNumber,
                      isRequired: false,
                    ),
                    SizedBox(height: 8),
                    CommonTextField(
                      onChanged: (value) {
                        cubit(context).setHomeNumber(value);
                      },
                      controller: houseController,
                      textInputAction: TextInputAction.next,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  children: [
                    LabelTextField(
                      text: Strings.commonApartment,
                      isRequired: false,
                    ),
                    SizedBox(height: 8),
                    CommonTextField(
                      onChanged: (value) {
                        cubit(context).setApartmentNumber(value);
                      },
                      controller: apartmentController,
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

  _buildFooterBlock(BuildContext context, PageState state) {
    return Container(
      color: Colors.white,
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
          SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 42,
            child: CommonButton(
              type: ButtonType.outlined,
              onPressed: () {
                cubit(context).getCurrentLocation();
              },
              child: Strings.userAddressSelectionLocation
                  .w(600)
                  .s(14)
                  .c(Colors.black),
            ),
          ),
          SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 42,
            child: CommonButton(
              onPressed: () {
                cubit(context).validationDate();
              },
              child: (state.isEditing ? Strings.commonSave : Strings.commonAdd)
                  .w(600)
                  .s(14)
                  .c(Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  /// show bottom sheets

  _showRegionSelection(BuildContext context, PageState state) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: Colors.white,
      context: context,
      builder: (BuildContext buildContext) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          height: double.infinity,
          child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: state.regions.length,
              itemBuilder: (BuildContext buildContext, int index) {
                return InkWell(
                    onTap: () {
                      cubit(context).setRegion(state.regions[index]);
                      Navigator.pop(buildContext);
                    },
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: state.regions[index].name.w(500),
                    ));
              }),
        );
      },
    );
  }

  _showDistrictSelection(BuildContext context, PageState state) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: Colors.white,
      context: context,
      builder: (BuildContext buildContext) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          height: double.infinity,
          child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: state.districts.length,
              itemBuilder: (BuildContext buildContext, int index) {
                return InkWell(
                    onTap: () {
                      cubit(context).setDistrict(state.districts[index]);
                      Navigator.pop(buildContext);
                    },
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: state.districts[index].name.w(500),
                    ));
              }),
        );
      },
    );
  }

  _showNeighborhoodSelection(BuildContext context, PageState state) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: Colors.white,
      context: context,
      builder: (BuildContext buildContext) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          height: double.infinity,
          child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: state.streets.length,
              itemBuilder: (BuildContext buildContext, int index) {
                return InkWell(
                    onTap: () {
                      cubit(context).setStreet(state.streets[index]);
                      Navigator.pop(buildContext);
                    },
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: state.streets[index].name.w(500),
                    ));
              }),
        );
      },
    );
  }

  void _showFullScreenDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      // Prevents closing the dialog by tapping outside
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Center(
            child: CircularProgressIndicator(), // Progress bar
          ),
        );
      },
    );
  }
}
