import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/presentation/support/colors/color_extension.dart';
import 'package:onlinebozor/data/datasource/network/constants/constants.dart';
import 'package:onlinebozor/presentation/support/cubit/base_page.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';
import 'package:onlinebozor/core/gen/assets/assets.gen.dart';
import 'package:onlinebozor/core/gen/localization/strings.dart';
import 'package:onlinebozor/presentation/support/extensions/mask_formatters.dart';
import 'package:onlinebozor/presentation/widgets/button/custom_elevated_button.dart';
import 'package:onlinebozor/presentation/widgets/button/custom_text_button.dart';
import 'package:onlinebozor/presentation/widgets/form_field/custom_text_form_field.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'cubit/add_card_cubit.dart';

@RoutePage()
class AddCardPage extends BasePage<PageCubit, PageState, PageEvent> {
  const AddCardPage({super.key});

  @override
  Widget onWidgetBuild(BuildContext context, PageState state) {
    final List<String> images = [
      "8a818006f6ddda2c7af7dbf4",
      '8a818006cc72d42b7c204717',
      '8a81800635cbdd937ad5fe18'
    ];

    final controller = PageController(viewportFraction: 1, keepPage: true);
    final format = DateFormat("mm:ss");
    void smsCodeVerification() {
      showModalBottomSheet(
          isScrollControlled: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          backgroundColor: context.backgroundColor,
          context: context,
          builder: (BuildContext buildContext) {
            return Container(
              height: 310,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                              child: Center(
                                  child: "Код подтверждения"
                                      .w(600)
                                      .s(16)
                                      .c(Color(0xFF41455E)))),
                          IconButton(
                              onPressed: () {},
                              icon: Assets.images.icClose
                                  .svg(width: 24, height: 24))
                        ],
                      ),
                      SizedBox(height: 24),
                      "Мы отправили вам СМС с кодом на номер *** ** 72"
                          .w(500)
                          .s(14)
                          .c(Color(0xFF41455E)),
                      SizedBox(height: 16),
                      CustomTextFormField(
                        inputType: TextInputType.number,
                        maxLines: 1,
                        textInputAction: TextInputAction.done,
                        onChanged: (value) {},
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomTextButton(
                            text: Strings.authConfirmAgainSentSmsYourPhone,
                            // enabled: state.againButtonEnable,
                            onPressed: () {},
                          ),
                          format
                              .format(DateTime.fromMillisecondsSinceEpoch(
                                  10 * 1000))
                              .w(500)
                              .s(14)
                              .c(Colors.black)
                        ],
                      ),
                      SizedBox(height: 24),
                      SizedBox(
                        height: 42,
                        width: double.infinity,
                        child: CustomElevatedButton(
                          text: Strings.commonClose,
                          onPressed: () {},
                        ),
                      )
                    ]),
              ),
            );
          });
    }

    return Scaffold(
      backgroundColor: context.backgroundColor,
      appBar: AppBar(
        backgroundColor: context.backgroundColor,
        title:
            Strings.cardAddCardTitle.w(500).s(14).c(context.colors.textPrimary),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: Assets.images.icArrowLeft.svg(),
          onPressed: () => context.router.pop(),
        ),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          SizedBox(
            height: 180,
            width: double.infinity,
            child: PageView.builder(
              controller: controller,
              physics: BouncingScrollPhysics(),
              itemCount: images.length,
              itemBuilder: (context, index) {
                return InkWell(
                    onTap: () {},
                    child: Stack(
                      children: [
                        Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          child: CachedNetworkImage(
                            imageUrl:
                                "${Constants.baseUrlForImage}${images[index]}",
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.fill,
                                    colorFilter: ColorFilter.mode(
                                        Colors.grey, BlendMode.colorBurn)),
                              ),
                            ),
                            placeholder: (context, url) => Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            errorWidget: (context, url, error) => Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6)),
                              child: Center(child: Icon(Icons.error)),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SmoothPageIndicator(
                              controller: controller,
                              count: images.length,
                              effect: const WormEffect(
                                dotHeight: 8,
                                dotWidth: 8,
                                type: WormType.thin,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ));
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Strings.cardNameTitle.w(500).s(14).c(Color(0xFF41455E)),
                SizedBox(height: 10),
                CustomTextFormField(
                  inputType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  maxLength: 25,
                  hint: Strings.cardNameHint,
                  onChanged: (value) {
                    cubit(context).setCardName(value);
                  },
                ),
                SizedBox(height: 20),
                Strings.cardNumberTitle.w(500).s(14).c(Color(0xFF41455E)),
                SizedBox(height: 10),
                CustomTextFormField(
                  maxLength: 19,
                  textInputAction: TextInputAction.next,
                  inputType: TextInputType.number,
                  inputFormatters: cardNumberMaskFormatter,
                  hint: "____ ____ ____ ____",
                  onChanged: (value) {
                    cubit(context).setCardNumber(value);
                  },
                ),
                SizedBox(height: 20),
                Strings.cardExpiryDateTitle.w(500).s(14).c(Color(0xFF41455E)),
                SizedBox(height: 10),
                CustomTextFormField(
                  textInputAction: TextInputAction.done,
                  inputType: TextInputType.number,
                  inputFormatters: cardExpiredMaskFormatter,
                  maxLength: 5,
                  hint: "__/__",
                  onChanged: (value) {
                    cubit(context).setCardNumber(value);
                  },
                ),
                SizedBox(height: 36),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                        value: state.isMain,
                        onChanged: (bool? value) {
                          cubit(context).setMainCard(value ?? false);
                        }),
                    SizedBox(width: 12),
                    Strings.actionMakeMain.s(14).w(500).c(Color(0xFF41455E))
                  ],
                ),
                SizedBox(height: 64),
                SizedBox(
                  height: 42,
                  width: double.infinity,
                  child: CustomElevatedButton(
                    text: Strings.cardAddCardTitle,
                    onPressed: () {
                      cubit(context)
                          .setCardPosition(controller.page?.toInt() ?? 0);
                      smsCodeVerification();
                    },
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
