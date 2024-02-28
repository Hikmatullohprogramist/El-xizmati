import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/localization/strings.dart';
import 'package:onlinebozor/common/router/app_router.dart';
import 'package:onlinebozor/common/widgets/common/label_text_field.dart';

import '../../../../../../../../common/gen/assets/assets.gen.dart';
import '../../../../../../../../common/widgets/common/common_button.dart';
import '../../../../../../../../common/widgets/common/common_text_field.dart';
import '../../../../../../../../common/widgets/common/custom_dropdown_field.dart';
import '../../../../../../../../common/widgets/switch/custom_switch.dart';
import '../../../../../../../../data/responses/address/user_address_response.dart';
import 'cubit/page_cubit.dart';

@RoutePage()
class AddAddressPage extends BasePage<AddAddressCubit, PageState,
    PageEvent> {
  AddAddressPage({super.key, this.address});

  UserAddressResponse? address;

  @override
  void onWidgetCreated(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AddAddressCubit>().setAddress(address);
    });
  }

  @override
  void onEventEmitted(BuildContext context, PageEvent event) {
    switch (event.type) {
      case PageEventType.navigationToHome:
        context.router.push(UserAddressesRoute());
    }
  }

  TextEditingController addressController = TextEditingController();
  TextEditingController houseController = TextEditingController();
  TextEditingController apartmentController = TextEditingController();
  TextEditingController neighborhoodController = TextEditingController();

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
    neighborhoodController.text != state.neighborhoodNum
        ? neighborhoodController.text = state.neighborhoodNum ?? ""
        : neighborhoodController.text = state.neighborhoodNum ?? "";

    return Scaffold(
        appBar: _buildAppBar(context),
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

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      title: Strings.userAddressAddNewAddress
          .w(500)
          .s(14)
          .c(context.colors.textPrimary),
      centerTitle: true,
      elevation: 0.5,
      // actions: [
        // CommonButton(
        //     type: ButtonType.text,
        //     onPressed: () {},
        //     child: Strings.userAddressSave.w(500).s(12).c(Color(0xFF5C6AC3)))
      // ],
      leading: IconButton(
        icon: Assets.images.icArrowLeft.svg(),
        onPressed: () => context.router.pop(),
      ),
    );
  }

  Widget _buildAddressNameBlock(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        children: [
          LabelTextField(text: Strings.userAddressAddNewAddress),
          SizedBox(height: 12),
          CommonTextField(
            controller: addressController,
            hint: Strings.userAddressAddNewAddress,
            onChanged: (value) {
              context.read<AddAddressCubit>().setAddressName(value);
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
          LabelTextField(text: Strings.userAddressRegion),
          SizedBox(height: 8),
          CustomDropdownField(
            hint: Strings.userAddressRegion,
            text: state.regionName ?? "",
            onTap: () {
              _showRegionSelection(context, state);
            },
          ),
          SizedBox(height: 12),
          LabelTextField(text: Strings.userAddressDistrict),
          SizedBox(height: 8),
          CustomDropdownField(
            hint: Strings.userAddressDistrict,
            text: state.districtName ?? "",
            onTap: () {
              _showDistrictSelection(context, state);
            },
          ),
          SizedBox(height: 12),
          LabelTextField(text: Strings.userAddressStreet),
          SizedBox(height: 8),
          CustomDropdownField(
            hint: Strings.userAddressStreet,
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
                      text: Strings.userAddressHomeNumber,
                      isRequired: false,
                    ),
                    SizedBox(height: 8),
                    CommonTextField(
                      onChanged: (value) {},
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
                      text: Strings.userAddressApartment,
                      isRequired: false,
                    ),
                    SizedBox(height: 8),
                    CommonTextField(
                      onChanged: (value) {
                        context.read<AddAddressCubit>().setHomeNum(value);
                      },
                      controller: houseController,
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
                      text: Strings.userAddressEntrance,
                      isRequired: false,
                    ),
                    SizedBox(height: 8),
                    CommonTextField(
                      onChanged: (value) {
                        context.read<AddAddressCubit>().setApartmentNum(value);
                      },
                      controller: apartmentController,
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
                      text: Strings.userAddressFloor,
                      isRequired: false,
                    ),
                    SizedBox(height: 8),
                    CommonTextField(
                      controller: neighborhoodController,
                      onChanged: (value) {
                        context
                            .read<AddAddressCubit>()
                            .setNeighborhoodNum(value);
                      },
                      textInputAction: TextInputAction.next,
                    ),
                  ],
                ),
              ),
            ],
          )
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
                isChecked:  state.isMain ?? false,
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
                  context.read<AddAddressCubit>().getCurrentLocation();
                },
                child: Strings.userAddressSelectionLocation
                    .w(600)
                    .s(14)
                    .c(Colors.black),
              )),
          SizedBox(height: 16),
          SizedBox(
              width: double.infinity,
              height: 42,
              child: CommonButton(
                onPressed: () {
                  context.read<AddAddressCubit>().validationDate();
                },
                child: Strings.userAddressAdd.w(600).s(14).c(Colors.white),
              )),
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
                      context
                          .read<AddAddressCubit>()
                          .setRegion(state.regions[index]);

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
                      context
                          .read<AddAddressCubit>()
                          .setDistrict(state.districts[index]);

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
                      context
                          .read<AddAddressCubit>()
                          .setStreet(state.streets[index]);

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
}
