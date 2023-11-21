import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';

import '../../../../../../../common/gen/assets/assets.gen.dart';
import '../../../../../../../common/widgets/common_button.dart';
import '../../../../../../../common/widgets/common_text_field.dart';

class AddAddressPage extends StatelessWidget {
  const AddAddressPage({super.key});

  @override
  Widget build(BuildContext context) {
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                "Название адреса".w(500).s(12).c(Color(0xFF41455E)),
                SizedBox(height: 12),
                CommonTextField(
                    hint: "Qora qo’chqor",
                    textInputAction: TextInputAction.next),
                SizedBox(height: 24),
                "Регион".w(500).s(12).c(Color(0xFF41455E)),
                SizedBox(height: 12),
                CommonTextField(
                  hint: "Животноводство",
                  textInputAction: TextInputAction.next,
                  inputType: TextInputType.emailAddress,
                ),
                SizedBox(height: 24),
                "Район".w(500).s(12).c(Color(0xFF41455E)),
                SizedBox(height: 12),
                CommonTextField(
                    hint: "Выбрать", textInputAction: TextInputAction.next),
                SizedBox(height: 24),
                "Улица".w(500).s(12).c(Color(0xFF41455E)),
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
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "Дом".w(500).s(12).c(Color(0xFF41455E)),
                              SizedBox(height: 12),
                              CommonTextField(
                                textInputAction: TextInputAction.next,
                                inputType: TextInputType.number,
                              ),
                            ],
                          )),
                      SizedBox(width: 16),
                      Flexible(
                          flex: 1,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Checkbox(
                                  value: false, onChanged: (bool? value) {}),
                              SizedBox(width: 14),
                              "Сделать основным"
                                  .w(600)
                                  .s(12)
                                  .c(Color(0xFF41455E))
                            ],
                          ))
                    ],
                  ),
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
          ),
        ));
  }
}
