import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/controller/controller_exts.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/localization/strings.dart';
import 'package:onlinebozor/common/widgets/app_bar/default_app_bar.dart';
import 'package:onlinebozor/common/widgets/common/label_text_field.dart';
import 'package:onlinebozor/common/widgets/common/selection_list_item.dart';

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
        showProgressDialog(context);
      case PageEventType.onFinishLoading:
        Navigator.pop(context);
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
            _buildLocationBlock(context, state),
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
            text: state.neighborhoodName ?? "",
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
                    LabelTextField(
                      text: Strings.commonHomeNumber,
                      isRequired: false,
                    ),
                    SizedBox(height: 8),
                    CommonTextField(
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
                    LabelTextField(
                      text: Strings.commonApartment,
                      isRequired: false,
                    ),
                    SizedBox(height: 8),
                    CommonTextField(
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
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Strings.userAddressLocation.w(600).s(16),
          SizedBox(height: 12),
          LabelTextField(text: Strings.userAddressTakenLocation,isRequired: true),
          SizedBox(height: 8),
          Text("${state.latitude}, ${state.longitude},"),
          SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            height: 42,
            child: CommonButton(
              type: ButtonType.outlined,
              onPressed: () {
                cubit(context).getCurrentLocation();
              },
              child:
                  Strings.userAddressGetLocation.w(600).s(14).c(Colors.black),
            ),
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
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext bc) {
        return Container(
          height: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
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
            color: Colors.white,
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
            color: Colors.white,
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
