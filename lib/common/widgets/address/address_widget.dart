import 'package:flutter/material.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/assets/assets.gen.dart';
import 'package:onlinebozor/data/model/address/user_address_response.dart';

class AppAddressWidgets extends StatelessWidget {
  const AppAddressWidgets(
      {super.key, required this.callback, required this.address});

  final VoidCallback callback;
  final UserAddressResponse address;

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              (address.name ?? "").w(600).s(16).c(Color(0xFF41455E)),
              Row(
                children: [
                  Visibility(
                    visible: address.isMain ?? false,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Color(0xFFF6B712)),
                      child: "Основной".w(600).s(12).c(Colors.white),
                    ),
                  ),
                  SizedBox(width: 12),
                  IconButton(
                      onPressed: callback, icon: Assets.images.icMoreVert.svg())
                ],
              )
            ],
          ),
          SizedBox(height: 13),
          "Адрес:".w(400).s(14).c(Color(0xFF9EABBE)),
          SizedBox(
            height: 5,
          ),
          (address.name ?? "").w(500).s(12).c(Color(0xFF41455E)),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text.rich(TextSpan(children: [
                TextSpan(
                    text: "Этаж:",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: Color(0xFF9EABBE))),
                WidgetSpan(
                    child: SizedBox(
                  width: 5,
                )),
                TextSpan(
                    text: address.apartmentNum,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: Color(0xFF41455E)))
              ])),
              Text.rich(TextSpan(children: [
                TextSpan(
                    text: "Подъезд:",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: Color(0xFF9EABBE))),
                WidgetSpan(
                    child: SizedBox(
                  width: 5,
                )),
                TextSpan(
                    text: address.streetNum,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: Color(0xFF41455E)))
              ])),
              Text.rich(TextSpan(children: [
                TextSpan(
                    text: "Квартира:",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: Color(0xFF9EABBE))),
                WidgetSpan(
                    child: SizedBox(
                  width: 5,
                )),
                TextSpan(
                    text: address.homeNum,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: Color(0xFF41455E)))
              ])),
            ],
          )
        ]);
  }
}
