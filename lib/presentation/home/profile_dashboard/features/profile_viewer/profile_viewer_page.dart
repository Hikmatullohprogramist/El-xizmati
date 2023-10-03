import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/router/app_router.dart';
import 'package:onlinebozor/common/widgets/app_diverder.dart';

import '../../../../../common/gen/assets/assets.gen.dart';
import '../../../../../common/widgets/common_button.dart';
import 'cubit/profile_viewer_cubit.dart';

@RoutePage()
class ProfileViewerPage extends BasePage<ProfileViewerCubit,
    ProfileViewerBuildable, ProfileViewerListenable> {
  const ProfileViewerPage({super.key});

  @override
  Widget builder(BuildContext context, ProfileViewerBuildable state) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: 'Профиль'.w(500).s(14).c(context.colors.textPrimary),
        centerTitle: true,
        elevation: 0.5,
        actions: [
          CommonButton(
              type: ButtonType.text,
              onPressed: () => context.router.push(ProfileEditRoute()),
              child: "Изменить".w(500).s(12).c(Color(0xFF5C6AC3)))
        ],
        leading: IconButton(
          icon: Assets.images.icArrowLeft.svg(),
          onPressed: () => context.router.pop(),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 16, right: 16, bottom: 16, top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  "Личные данные".w(700).c(Color(0xFF41455E)).s(16),
                  SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 62,
                        height: 62,
                        child: Stack(
                          children: [
                            Container(
                              width: 56,
                              height: 56,
                              child: CachedNetworkImage(
                                imageUrl:
                                    "https://api.online-bozor.uz/uploads/images/8a8180064ac6dcf709646050",
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                      colorFilter: ColorFilter.mode(
                                          Color(0xFFF6F7FC),
                                          BlendMode.colorBurn),
                                    ),
                                  ),
                                ),
                                placeholder: (context, url) =>
                                    Center(child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) => Center(
                                  child: Icon(Icons.perm_identity),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                height: 28,
                                width: 28,
                                decoration: ShapeDecoration(
                                  color: Color(0xFF5C6AC3),
                                  shape: OvalBorder(),
                                ),
                                child: IconButton(
                                  onPressed: () {},
                                  icon: Assets.images.profileViewer.icCamera
                                      .svg(height: 14, width: 14),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              "Shonazarov Mardon".w(600).s(20).c(Colors.black),
                              SizedBox(width: 8),
                              Assets.images.profileViewer.icNotIdentified.svg()
                            ],
                          ),
                          Row(
                            children: [
                              CommonButton(
                                onPressed: () {},
                                enabled: false,
                                child: "Частное лицо"
                                    .w(500)
                                    .s(12)
                                    .c(Color(0xFF999CB2)),
                              ),
                              SizedBox(width: 12),
                              CommonButton(
                                  type: ButtonType.text,
                                  onPressed: () {},
                                  child: "Поменять на бизнес"
                                      .w(400)
                                      .c(Color(0xFF5C6AC3))
                                      .s(12))
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 15),
                  AppDivider(indent: 16),
                  SizedBox(height: 16),
                  Container(
                    height: 28,
                    decoration: ShapeDecoration(
                      color: Color(0x1E32B88B),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: CommonButton(
                      type: ButtonType.text,
                      enabled: true,
                      color: Color(0x1232B88B),
                      onPressed: () {},
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Assets.images.profileViewer.icIdentified.svg(),
                            "Идентифицирован ".w(400).s(12).c(Color(0xFF32B88B))
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  AppDivider(height: 2),
                  Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 16),
                          "User name".w(400).s(14).c(Color(0xFF9EABBE)),
                          SizedBox(height: 6),
                          "Mardon".w(500).s(16).c(Color(0xFF41455E)),
                          SizedBox(height: 16),
                          AppDivider(),
                          SizedBox(height: 16),
                          "Дата рождения".w(400).s(14).c(Color(0xFF9EABBE)),
                          SizedBox(height: 6),
                          "20.02.2002".w(500).s(16).c(Color(0xFF41455E)),
                          SizedBox(height: 16),
                          AppDivider(),
                          SizedBox(height: 16),
                          "Паспортные данные".w(400).s(14).c(Color(0xFF9EABBE)),
                          SizedBox(height: 6),
                          "AA 1234567890".w(500).s(16).c(Color(0xFF41455E)),
                          SizedBox(height: 16),
                          AppDivider(),
                          SizedBox(height: 16),
                          "Пол".w(400).s(14).c(Color(0xFF9EABBE)),
                          SizedBox(height: 6),
                          Row(
                            children: [
                              Assets.images.profileViewer.icRadioButtonSelected
                                  .svg(),
                              SizedBox(width: 8),
                              "Муж.".w(400).s(14).c(Color(0xFF9EABBE)),
                              SizedBox(width: 24),
                              Assets
                                  .images.profileViewer.icRadioButtonUsSelected
                                  .svg(),
                              SizedBox(width: 8),
                              "Муж.".w(400).s(14).c(Color(0xFF9EABBE)),
                              SizedBox(width: 24)
                            ],
                          ),
                          SizedBox(height: 16),
                          AppDivider(),
                          SizedBox(height: 16),
                          "Email".w(400).s(14).c(Color(0xFF9EABBE)),
                          SizedBox(height: 6),
                          "mardon.shonazarov@gmail.com"
                              .w(500)
                              .s(16)
                              .c(Color(0xFF41455E)),
                          SizedBox(height: 16),
                          AppDivider(),
                          SizedBox(height: 16),
                          "Телефон".w(400).s(14).c(Color(0xFF9EABBE)),
                          SizedBox(height: 6),
                          "+99890 945-72-12".w(500).s(16).c(Color(0xFF41455E)),
                          SizedBox(height: 16),
                          AppDivider(),
                          SizedBox(height: 16),
                          "Регион".w(400).s(14).c(Color(0xFF9EABBE)),
                          SizedBox(height: 6),
                          "город Ташкент".w(500).s(16).c(Color(0xFF41455E)),
                          SizedBox(height: 16),
                          AppDivider(),
                          SizedBox(height: 16),
                          "Район".w(400).s(14).c(Color(0xFF9EABBE)),
                          SizedBox(height: 6),
                          "Алмазарский район".w(500).s(16).c(Color(0xFF41455E)),
                          SizedBox(height: 16),
                          AppDivider(),
                          SizedBox(height: 16),
                          "Махалля".w(400).s(14).c(Color(0xFF9EABBE)),
                          SizedBox(height: 6),
                          "Хувайдо МФЙ, 15-дом, 34-кв"
                              .w(500)
                              .s(16)
                              .c(Color(0xFF41455E)),
                          SizedBox(height: 16),
                        ]),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
