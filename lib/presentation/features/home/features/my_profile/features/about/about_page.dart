import 'package:El_xizmati/core/extensions/text_extensions.dart';
import 'package:El_xizmati/presentation/support/extensions/color_extension.dart';
import 'package:El_xizmati/presentation/widgets/button/custom_elevated_button.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../../../../core/gen/assets/assets.gen.dart';
import '../../../../../../widgets/app_bar/default_app_bar.dart';

@RoutePage()
class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        titleText: "Ilova haqida",
        titleTextColor: context.colors.primary,
        backgroundColor: Colors.white,
        onBackPressed: () {
          context.router.pop();
        },
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(left: 32.0, right: 32, bottom: 30, top: 40),
        child: Column(
          children: [
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Assets.images.pngImages.appLogo
                        .image(width: 64, height: 64),
                    Text("el xizmati").w(700).s(32).c(Color(0xFF703EDB)),
                    Text("ishchilar jamiyati")
                        .w(300)
                        .s(18)
                        .c(Color(0xFF2A174E)),
                  ],
                ),
                Text(
                  "version 1.0.0",
                  style: TextStyle(fontSize: 12),
                ),
                Text(
                  "Lorem ipsum dolor sit amet consectetur. Non vel cras eget tortor rhoncus feugiat ac felis. Eu dignissim consequat purus nec et quis. Scelerisque suscipit proin arcu felis aliquet quis eget metus. Fermentum nec feugiat turpis eros viverra ultricies convallis pretium. Aliquam neque sit aliquam laoreet sed sagittis. Massa netus est ultrices phasellus arcu vel scelerisque. Pharetra orci vulputate quis odio. Velit cursus a proin tortor fusce nibh sollicitudin. Vel risus lacus sagittis gravida aenean.",
                  style: TextStyle(
                    height: 1.5,
                    wordSpacing: 2,
                  ),
                ),
                SizedBox(height: 30)
              ],
            )),
            CustomElevatedButton(
              text: "Foydalanish shartlari",
              onPressed: () {},
              backgroundColor: Color(0xFF525252),
            ),
            SizedBox(height: 20),
            CustomElevatedButton(
                text: "Play marketda baholash", onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
