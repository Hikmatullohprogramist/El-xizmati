import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/localization/strings.dart';
import 'package:onlinebozor/common/router/app_router.dart';

import '../../../../../../../../common/gen/assets/assets.gen.dart';
import '../../../../../../../../common/widgets/common/common_button.dart';
import '../../../../../../../../common/widgets/common/common_text_field.dart';
import '../../../../../../../../data/responses/address/user_address_response.dart';
import 'cubit/add_address_cubit.dart';

@RoutePage()
class AddAddressPage extends BasePage<AddAddressCubit, AddAddressBuildable,
    AddAddressListenable> {
  AddAddressPage({super.key, this.address});

  UserAddressResponse? address;

  @override
  void init(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AddAddressCubit>().setAddress(address);
    });
  }

  @override
  void listener(BuildContext context, AddAddressListenable event) {
    switch (event.effect) {
      case AddAddressEffect.navigationToHome:
        context.router.push(UserAddressesRoute());
    }
  }

  TextEditingController addressController = TextEditingController();
  TextEditingController houseController = TextEditingController();
  TextEditingController apartmentController = TextEditingController();
  TextEditingController neighborhoodController = TextEditingController();

  @override
  Widget builder(BuildContext context, AddAddressBuildable state) {
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
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Strings.userAddressAddNewAddress
              .w(500)
              .s(14)
              .c(context.colors.textPrimary),
          centerTitle: true,
          elevation: 0.5,
          actions: [
            CommonButton(
                type: ButtonType.text,
                onPressed: () {},
                child:
                    Strings.userAddressSave.w(500).s(12).c(Color(0xFF5C6AC3)))
          ],
          leading: IconButton(
            icon: Assets.images.icArrowLeft.svg(),
            onPressed: () => context.router.pop(),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16,vertical: 16
          ),
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Strings.userAddressAddNewAddress.w(500).s(12).c(Color(0xFF41455E)),
                SizedBox(width: 5),
                Assets.images.icRedStart.svg(height: 8, width: 8),
              ]),
              SizedBox(height: 12),
              CommonTextField(
                  controller: addressController,
                  hint: Strings.userAddressAddNewAddress,
                  onChanged: (value) {
                    context.read<AddAddressCubit>().setAddressName(value);
                  },
                  textInputAction: TextInputAction.next),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Strings.userAddressRegion.w(500).s(12).c(Color(0xFF41455E)),
                  SizedBox(width: 5),
                  Assets.images.icRedStart.svg(height: 8, width: 8),
                ],
              ),
              SizedBox(height: 12),
              InkWell(
                onTap: () {
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
                              itemBuilder:
                                  (BuildContext buildContext, int index) {
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
                      });
                },
                child: CommonTextField(
                  hint: Strings.userAddressRegion,
                  readOnly: true,
                  enabled: false,
                  textInputAction: TextInputAction.next,
                  inputType: TextInputType.emailAddress,
                  controller: TextEditingController(text: state.regionName),
                ),
              ),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Strings.userAddressDistrict.w(500).s(12).c(Color(0xFF41455E)),
                  SizedBox(width: 5),
                  Assets.images.icRedStart.svg(height: 8, width: 8),
                ],
              ),
              SizedBox(height: 12),
              InkWell(
                  onTap: () {
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
                                itemBuilder:
                                    (BuildContext buildContext, int index) {
                                  return InkWell(
                                      onTap: () {
                                        context
                                            .read<AddAddressCubit>()
                                            .setDistrict(
                                                state.districts[index]);
                                        Navigator.pop(buildContext);
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.all(16),
                                        child:
                                            state.districts[index].name.w(500),
                                      ));
                                }),
                          );
                        });
                  },
                  child: CommonTextField(
                      readOnly: true,
                      enabled: false,
                      hint: Strings.userAddressDistrict,
                      controller:
                          TextEditingController(text: state.districtName),
                      textInputAction: TextInputAction.next)),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Strings.userAddressStreet.w(500).s(12).c(Color(0xFF41455E)),
                  SizedBox(width: 5),
                  Assets.images.icRedStart.svg(height: 8, width: 8),
                ],
              ),
              SizedBox(height: 12),
              InkWell(
                  onTap: () {
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
                                itemBuilder:
                                    (BuildContext buildContext, int index) {
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
                        });
                  },
                  child: CommonTextField(
                      readOnly: true,
                      enabled: false,
                      hint: Strings.userAddressStreet,
                      controller: TextEditingController(text: state.streetName),
                      inputType: TextInputType.text)),
              SizedBox(height: 24),
              Strings.userAddressHomeNumber.w(500).s(12).c(Color(0xFF41455E)),
              SizedBox(height: 12),
              CommonTextField(
                onChanged: (value) {},
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: 24),
              Strings.userAddressApartment.w(500).s(12).c(Color(0xFF41455E)),
              SizedBox(height: 12),
              CommonTextField(
                onChanged: (value) {
                  context.read<AddAddressCubit>().setHomeNum(value);
                },
                controller: houseController,
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: 24),
              Strings.userAddressEntrance.w(500).s(12).c(Color(0xFF41455E)),
              SizedBox(height: 12),
              CommonTextField(
                onChanged: (value) {
                  context.read<AddAddressCubit>().setApartmentNum(value);
                },
                controller: apartmentController,
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: 24),
              Strings.userAddressFloor.w(500).s(12).c(Color(0xFF41455E)),
              SizedBox(height: 12),
              CommonTextField(
                controller: neighborhoodController,
                onChanged: (value) {
                  context.read<AddAddressCubit>().setNeighborhoodNum(value);
                },
                textInputAction: TextInputAction.next,
              ),
              SizedBox(width: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(
                      value: state.isMain ?? false,
                      onChanged: (bool? value) {
                        context.read<AddAddressCubit>().setMainCard(value);
                      }),
                  SizedBox(width: 12),
                  Strings.userAddressSetAsMain.s(14).w(500).c(Color(0xFF41455E))
                ],
              ),
              SizedBox(height: 45),
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
        ));
  }
}
