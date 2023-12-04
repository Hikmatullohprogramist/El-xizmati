import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/data/model/address/user_address_response.dart';

import '../../../../../common/gen/assets/assets.gen.dart';
import '../../../../../common/widgets/common_button.dart';
import '../../../../../common/widgets/common_text_field.dart';
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
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              "Название адреса *".w(500).s(12).c(Color(0xFF41455E)),
              SizedBox(height: 12),
              CommonTextField(
                  hint: "Qora qo’chqor", textInputAction: TextInputAction.next),
              SizedBox(height: 24),
              "Регион *".w(500).s(12).c(Color(0xFF41455E)),
              SizedBox(height: 12),
              CommonTextField(
                hint: "Животноводство",
                textInputAction: TextInputAction.next,
                inputType: TextInputType.emailAddress,
                controller: TextEditingController(text:""),
              ),
              SizedBox(height: 24),
              "Район *".w(500).s(12).c(Color(0xFF41455E)),
              SizedBox(height: 12),
              CommonTextField(
                  hint: "Выбрать", textInputAction: TextInputAction.next),
              SizedBox(height: 24),
              "Улица *".w(500).s(12).c(Color(0xFF41455E)),
              SizedBox(height: 12),
              CommonTextField(hint: "-", inputType: TextInputType.text),
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
