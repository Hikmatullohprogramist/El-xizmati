import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:onlinebozor/core/enum/social_enum.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';

import '../divider/custom_diverder.dart';

extension ShowSocialDirectionButtomSheet on BuildContext {
  void showSocialDirectionButtomSheet(
      BuildContext context, SocialType type) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: 350,
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0),
            // Adjust the radius as needed
            topRight: Radius.circular(10.0), // Adjust the radius as needed
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(color: Colors.white),
                        child: Center(
                            child: Stack(
                          children: [
                            if (type == SocialType.instagram)
                              Image(
                                image: AssetImage(
                                    'assets/images/png_images/instagram.png'),
                              ),
                            if (type == SocialType.telegram)
                              Image(
                                image: AssetImage(
                                    'assets/images/png_images/telegramm.png'),
                              ),
                            if (type == SocialType.facebook)
                              Image(
                                image: AssetImage(
                                    'assets/images/png_images/facebook.png'),
                              ),
                            if (type == SocialType.youtube)
                              Image(
                                image: AssetImage(
                                    'assets/images/png_images/youtube.png'),
                              ),
                          ],
                        )),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (type == SocialType.instagram)
                      "Instagram link qanday olinadi"
                          .w(700)
                          .s(16)
                          .c(Color(0xFF41455E)),
                    if (type == SocialType.telegram)
                      "Telegram link qanday olinadi"
                          .w(700)
                          .s(16)
                          .c(Color(0xFF41455E)),
                    if (type == SocialType.facebook)
                      "Facebook link qanday olinadi"
                          .w(700)
                          .s(16)
                          .c(Color(0xFF41455E)),
                    if (type == SocialType.youtube)
                      "Youtube link qanday olinadi"
                          .w(700)
                          .s(16)
                          .c(Color(0xFF41455E)),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        if (type == SocialType.instagram)
                          "Instagramni ochish".w(700).s(14).c(Colors.grey),
                        if (type == SocialType.telegram)
                          "Telegramni ochish".w(700).s(14).c(Colors.grey),
                        if (type == SocialType.facebook)
                          "Facebookni ochish".w(700).s(14).c(Colors.grey),
                        if (type == SocialType.youtube)
                          "Youtubeni ochish".w(700).s(14).c(Colors.grey),
                        SizedBox(
                          width: 1,
                        ),
                        Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white),
                          child: Center(
                              child: Image(
                            image: AssetImage(
                                'assets/images/png_images/open_link.png'),
                          )),
                        )
                      ],
                    ),
                  ],
                ),
                Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: SvgPicture.asset(
                        'assets/images/ic_close.svg',
                      ),
                    )
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 7,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: CustomDivider(height: 1),
            ),
            SizedBox(
              height: 7,
            ),
            "1-qadam:".w(500).s(13).c(Colors.green),
            SizedBox(
              height: 5,
            ),
            if (type == SocialType.instagram)
              "Instagram profil bo'limiga o'ting."
                  .w(500)
                  .s(16)
                  .c(Color(0xFF41455E)),
            if (type == SocialType.telegram)
              "Telegram sozlamalar bo'limiga o'ting."
                  .w(500)
                  .s(16)
                  .c(Color(0xFF41455E)),
            if (type == SocialType.facebook)
              "Facebook sozlamalar bo'limiga o'ting.."
                  .w(500)
                  .s(16)
                  .c(Color(0xFF41455E)),
            if (type == SocialType.youtube)
              "Youtube sozlamalar bo'limiga o'ting."
                  .w(500)
                  .s(16)
                  .c(Color(0xFF41455E)),
            SizedBox(
              height: 10,
            ),

            ///
            "2-qadam:".w(500).s(13).c(Colors.green),
            SizedBox(
              height: 2,
            ),
            if (type == SocialType.instagram)
              "Profilingizni ochish uchun o'ng pastdagi profil belgisiga bosing yoki profil nomingizga bosing."
                  .w(500)
                  .s(16)
                  .c(Color(0xFF41455E)),
            if (type == SocialType.telegram)
              "Telegram profilining username'ini olishingiz kerak. Bu nom foydalanuvchining profilida @ belgisi bilan boshlanadigan nomdir. Masalan: @username. "
                  .w(500)
                  .s(15)
                  .c(Color(0xFF41455E)),
            if (type == SocialType.facebook)
              "O'ng yuqori burchagida joylashgan profil rasmingizga yoki ismingizga bosing. Paydo bo'lgan menyudan 'Profilni ko'rish'ni tanlang."
                  .w(500)
                  .s(16)
                  .c(Color(0xFF41455E)),
            if (type == SocialType.youtube)
              "Profil rasmingizni bosing va paydo bo'lgan menyudan 'Mening kanalim' ni tanlang. "
                  .w(500)
                  .s(15)
                  .c(Color(0xFF41455E)),
            SizedBox(
              height: 12,
            ),

            ///
            "3-qadam:".w(500).s(13).c(Colors.green),
            if (type == SocialType.instagram)
              "Profil sahifangizga yo'naltirilganingizdan so'ng, brauzerning manzil panelida profil havolasini ko'rasiz. Umumiy ravishda, 'https://www.instagram.com/FOYDALANUVCHINOMI' ko'rinishida bo'ladi."
                  .w(500)
                  .s(16)
                  .c(Color(0xFF41455E)),
            if (type == SocialType.telegram)
              "Havolasini yaratishda https://t.me/ so'zidan keyin foydalanuvchining username'ini qo'shish kerak. Masalan: https://t.me/username."
                  .w(500)
                  .s(16)
                  .c(Color(0xFF41455E)),
            if (type == SocialType.facebook)
              "Manzil panelida profil havolani ko'rasiz. Masalan: 'https://www.facebook.com/FOYDALANUVCHINOMI' ko'rinishida bo'ladi."
                  .w(500)
                  .s(16)
                  .c(Color(0xFF41455E)),
            if (type == SocialType.youtube)
              "Manzil panelida profil havolani ko'rasiz. Masalan: 'https://www.youtube.com/c/FOYDALANUVCHINOMI' ko'rinishida bo'ladi."
                  .w(500)
                  .s(16)
                  .c(Color(0xFF41455E)),
          ],
        ),
      ),
    );
  }
}
