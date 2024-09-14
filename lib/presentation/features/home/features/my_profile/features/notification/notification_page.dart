import 'package:El_xizmati/presentation/support/extensions/color_extension.dart';
import 'package:El_xizmati/presentation/widgets/app_bar/default_app_bar.dart';
import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
@RoutePage()
class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        titleText: "Bildirishnomalar",
        titleTextColor: context.colors.primary,
        backgroundColor: Colors.white,
        onBackPressed: () {
          context.router.pop();
        },
      ),
      body: Column(
        children: [
          Container(
            height: 57,
            padding: EdgeInsets.symmetric(horizontal: 32),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 230,
                  child: Text("Barcha bildirishnomalarni yoqish"),
                ),
                Switch(value: true, onChanged: (value) {},activeTrackColor: context.colors.buttonPrimary,inactiveTrackColor: Colors.grey,)
              ],
            ),
          ),
          Container(
            height: 57,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: Text("Barcha bildirishnomalarni yoqish orqali siz har qanday bildirishnomalarni qabul qilasiz.", style: TextStyle(fontSize: 12),),
          ),
          Container(
            height: 57,
            padding: EdgeInsets.symmetric(horizontal: 32),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 230,
                  child: Text("Faqat xabarlarni yoqish", style: TextStyle(color: Colors.grey),),
                ),
                Switch(value: false, onChanged: (value) {},activeTrackColor: context.colors.buttonPrimary,inactiveTrackColor: Colors.grey,)
              ],
            ),
          ),
          Container(
            height: 57,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: Text("Faqat xabarlarni yoqish orqali siz faqat mening xabarlarim bo’limidan kelgan xabarlarni qabul qilasiz.", style: TextStyle(fontSize: 12, color: Colors.grey),),
          ),
          Container(
            height: 57,
            padding: EdgeInsets.symmetric(horizontal: 32),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 230,
                  child: Text("Ekranga qalqib chiqish",),
                ),
                Switch(value: true, onChanged: (value) {},activeTrackColor: context.colors.buttonPrimary,inactiveTrackColor: Colors.grey,)
              ],
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 10),
            child: Text("Ekranga qalqib chiqishni yoqish orqali siz ekraningiz yuqori bildirishnomalar qismida kelgan xabarlardan xabardor bo’lasiz.", style: TextStyle(fontSize: 12),),
          ),
        ],
      ),
    );
  }
}
