import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/data/model/address/user_address_response.dart';

import '../../../../../../../common/gen/assets/assets.gen.dart';
import '../../../../../../../common/widgets/common/common_button.dart';
import '../../../../../../../common/widgets/common/common_text_field.dart';
import 'cubit/add_address_cubit.dart';

@RoutePage()
class AddAddressPage extends BasePage<AddAddressCubit, AddAddressBuildable,
    AddAddressListenable> {
  AddAddressPage({super.key, required this.address});

  UserAddressResponse? address;

  @override
  void init(BuildContext context) {
    context.read<AddAddressCubit>();
  }

  @override
  Widget builder(BuildContext context, AddAddressBuildable state) {
    TextEditingController addressController = TextEditingController();
    if (addressController.text != state.addressName) {
      addressController.text = state.addressName ?? "";
    }

    TextEditingController  houseController =TextEditingController();
    // if(houseController.text =state.)
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title:
              'Добавить новый адрес'.w(500).s(14).c(context.colors.textPrimary),
          centerTitle: true,
          elevation: 0.5,
          actions: [
            CommonButton(
                type: ButtonType.text,
                onPressed: () {},
                child: "Сохранить".w(500).s(12).c(Color(0xFF5C6AC3)))
          ],
          leading: IconButton(
            icon: Assets.images.icArrowLeft.svg(),
            onPressed: () => context.router.pop(),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                "Название адреса".w(500).s(12).c(Color(0xFF41455E)),
                SizedBox(width: 5),
                Assets.images.icRedStart.svg(height: 8, width: 8),
              ]),
              SizedBox(height: 12),
              CommonTextField(
                  controller: addressController,
                  hint: "Название адреса*",
                  textInputAction: TextInputAction.next),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  "Регион".w(500).s(12).c(Color(0xFF41455E)),
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
                  hint: "Регион*",
                  readOnly: true,
                  enabled: false,
                  textInputAction: TextInputAction.next,
                  inputType: TextInputType.emailAddress,
                  controller: TextEditingController(text: ""),
                ),
              ),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  "Район".w(500).s(12).c(Color(0xFF41455E)),
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
                                            .setRegion(state.districts[index]);
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
                      readOnly: true,
                      enabled: false,
                      hint: "Район*",
                      textInputAction: TextInputAction.next)),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  "Улица".w(500).s(12).c(Color(0xFF41455E)),
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
                                            .setRegion(state.districts[index]);
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
                      readOnly: true,
                      enabled: false,
                      hint: "Улица*",
                      inputType: TextInputType.text)),
              SizedBox(height: 24),
              "Номер дома".w(500).s(12).c(Color(0xFF41455E)),
              SizedBox(height: 12),
              CommonTextField(
                onChanged: (value) {},
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: 24),
              "Квартира".w(500).s(12).c(Color(0xFF41455E)),
              SizedBox(height: 12),
              CommonTextField(
                onChanged: (value) {},
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: 24),
              "Подъезд".w(500).s(12).c(Color(0xFF41455E)),
              SizedBox(height: 12),
              CommonTextField(
                onChanged: (value) {},
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: 24),
              "Этаж".w(500).s(12).c(Color(0xFF41455E)),
              SizedBox(height: 12),
              CommonTextField(
                onChanged: (value) {},
                textInputAction: TextInputAction.next,
              ),
              SizedBox(width: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(
                      value: false,
                      onChanged: (bool? value) {
                        // context
                        //     .read<AddCardCubit>()
                        //     .setMainCard(value ?? false);
                      }),
                  SizedBox(width: 12),
                  "Сделать основным".s(14).w(500).c(Color(0xFF41455E))
                ],
              ),
              SizedBox(height: 45),
              SizedBox(
                  width: double.infinity,
                  height: 42,
                  child: CommonButton(
                    onPressed: () {},
                    child: "Добавить".w(600).s(14).c(Colors.white),
                  )),
            ],
          ),
        ));
  }
}
