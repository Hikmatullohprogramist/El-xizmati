import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/widgets/app_diverder.dart';
import 'package:onlinebozor/common/widgets/common_text_field.dart';
import 'package:onlinebozor/presentation/home/profile_dashboard/features/profile_viewer/features/profile_edit/cubit/profile_edit_cubit.dart';

import '../../../../../../../common/base/base_page.dart';
import '../../../../../../../common/gen/assets/assets.gen.dart';
import '../../../../../../../common/widgets/common_button.dart';
import '../../../../../../util.dart';

@RoutePage()
class ProfileEditPage extends BasePage<ProfileEditCubit, ProfileEditBuildable,
    ProfileEditListenable> {
  const ProfileEditPage({super.key});

  @override
  Widget builder(BuildContext context, ProfileEditBuildable state) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: 'Изменить'.w(500).s(14).c(context.colors.textPrimary),
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
      body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 16, top: 20, right: 16, bottom: 12),
                child:
                    "Изменить личные данные".w(700).s(16).c(Color(0xFF41455E)),
              ),
              Padding(
                  padding:
                      EdgeInsets.only(left: 16, top: 12, right: 16, bottom: 6),
                  child: "Паспортные данные".w(500).s(12).c(Color(0xFF41455E))),
              Padding(
                padding: const EdgeInsets.only(
                    right: 16, left: 16, bottom: 12, top: 6),
                child: Row(children: [
                  SizedBox(
                    width: 60,
                    child: CommonTextField(
                        onChanged: (value) {
                          context
                              .read<ProfileEditCubit>()
                              .setBiometricSerial(value);
                        },
                        inputType: TextInputType.text,
                        maxLength: 2,
                        textInputAction: TextInputAction.next),
                  ),
                  SizedBox(width: 12),
                  Flexible(
                    child: CommonTextField(
                      maxLength: 9,
                      onChanged: (value) {
                        context
                            .read<ProfileEditCubit>()
                            .setBiometricNumber(value);
                      },
                      inputFormatters: biometricNumberMaskFormatter,
                      textInputAction: TextInputAction.next,
                      inputType: TextInputType.number,
                      hint: "Номер паспорта",
                    ),
                  ),
                ]),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: "Дата рождения".w(500).s(12).c(Color(0xFF41455E)),
              ),
              Padding(
                padding: EdgeInsets.only(right: 16, left: 16, bottom: 12),
                child: CommonTextField(
                  onChanged: (value) {
                    context.read<ProfileEditCubit>().setBrithDate(value);
                  },
                  inputType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  inputFormatters: brithMaskFormatter,
                  maxLength: 12,
                  hint: "2004-11-28",
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: "Номер телефона".w(500).s(12).c(Color(0xFF41455E)),
              ),
              Padding(
                padding: EdgeInsets.only(right: 16, left: 16, bottom: 12),
                child: CommonTextField(
                    hint: "+998",
                    controller: TextEditingController(text: "+998"),
                    inputFormatters: phoneMaskFormatter,
                    inputType: TextInputType.phone,
                    textInputAction: TextInputAction.next),
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 24),
                child: "Укажите номер и серия паспорта, дата рождения"
                    .w(400)
                    .s(12)
                    .c(Color(0xFF9EABBE)),
              ),
              AppDivider(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: "Имя".w(500).s(12).c(Color(0xFF41455E)),
              ),
              Padding(
                padding: EdgeInsets.only(right: 16, left: 16, bottom: 12),
                child: CommonTextField(
                    hint: "Имя", textInputAction: TextInputAction.next),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: "User name".w(500).s(12).c(Color(0xFF41455E)),
              ),
              Padding(
                padding: EdgeInsets.only(right: 16, left: 16, bottom: 12),
                child: CommonTextField(
                    hint: "User name",
                    textInputAction: TextInputAction.next,
                    inputType: TextInputType.text),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: "Эл. почта".w(500).s(12).c(Color(0xFF41455E)),
              ),
              Padding(
                padding: EdgeInsets.only(right: 16, left: 16, bottom: 12),
                child: CommonTextField(
                  hint: "example@gmail.com",
                  textInputAction: TextInputAction.next,
                  inputType: TextInputType.emailAddress,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: "Регион".w(500).s(12).c(Color(0xFF41455E)),
              ),
              Padding(
                padding: EdgeInsets.only(right: 16, left: 16, bottom: 12),
                child: CommonTextField(
                  hint: "Регион",
                  inputType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: "Район".w(500).s(12).c(Color(0xFF41455E)),
              ),
              Padding(
                padding: EdgeInsets.only(right: 16, left: 16, bottom: 12),
                child: CommonTextField(
                    hint: "Район",
                    inputType: TextInputType.text,
                    textInputAction: TextInputAction.next),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: "Махалля".w(500).s(12).c(Color(0xFF41455E)),
              ),
              Padding(
                padding: EdgeInsets.only(right: 16, left: 16, bottom: 12),
                child: CommonTextField(
                  hint: "Махалля",
                  textInputAction: TextInputAction.next,
                  inputType: TextInputType.text,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "Квартира".w(500).s(12).c(Color(0xFF41455E)),
                            SizedBox(height: 12),
                            CommonTextField(
                              textInputAction: TextInputAction.done,
                              inputType: TextInputType.number,
                            ),
                          ],
                        ))
                  ],
                ),
              )
            ],
          )),
    );
  }
}
