import 'package:flutter/material.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/assets/assets.gen.dart';
import 'package:onlinebozor/common/gen/localization/strings.dart';

import '../../../data/responses/address/user_address_response.dart';

class UserAddressWidgets extends StatelessWidget {
  const UserAddressWidgets({
    super.key,
    required this.address,
    required this.onClicked,
    required this.onEditClicked,
    this.isManageEnabled = false,
  });

  final UserAddressResponse address;
  final VoidCallback onClicked;
  final VoidCallback onEditClicked;
  final bool isManageEnabled;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: EdgeInsets.only(left: 12, top: 12, right: 12),
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(width: 1, color: Color(0xFFE5E9F3)),
      ),
      child: InkWell(
        onTap: () {
          onClicked();
        },
        borderRadius: BorderRadius.circular(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: (address.name ?? "")
                      .w(600)
                      .s(16)
                      .c(Color(0xFF41455E))
                      .copyWith(overflow: TextOverflow.ellipsis),
                ),
                Row(
                  children: [
                    Visibility(
                      visible: address.is_main == true,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 8,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Color(0xFFF6B712),
                        ),
                        child: Strings.userAddressMain
                            .w(600)
                            .s(12)
                            .c(Colors.white),
                      ),
                    ),
                    SizedBox(width: 8),
                    Visibility(
                      visible: isManageEnabled,
                      child: IconButton(
                        onPressed: onEditClicked,
                        icon: Assets.images.icMoreVert.svg(),
                      ),
                    )
                  ],
                )
              ],
            ),
            SizedBox(height: 13),
            Strings.userAddressAddress.w(400).s(14).c(Color(0xFF9EABBE)),
            SizedBox(height: 5),
            ("${address.region?.name ?? ""} ${address.district?.name ?? ""} ${address.mahalla?.name ?? ""}")
                .w(500)
                .s(12)
                .c(Color(0xFF41455E)),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(
                  TextSpan(children: [
                    TextSpan(
                        text: Strings.userAddressFloor,
                        style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: Color(0xFF9EABBE))),
                    WidgetSpan(
                        child: SizedBox(
                      width: 5,
                    )),
                    TextSpan(
                      text: address.street_num ?? "-",
                      style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: Color(0xFF41455E)),
                    )
                  ]),
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: Strings.userAddressEntrance,
                        style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: Color(0xFF9EABBE)),
                      ),
                      WidgetSpan(child: SizedBox(width: 5)),
                      TextSpan(
                        text: address.home_num ?? "-",
                        style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: Color(0xFF41455E)),
                      )
                    ],
                  ),
                ),
                Text.rich(TextSpan(children: [
                  TextSpan(
                    text: Strings.userAddressApartment,
                    style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: Color(0xFF9EABBE)),
                  ),
                  WidgetSpan(
                      child: SizedBox(
                    width: 5,
                  )),
                  TextSpan(
                    text: address.apartment_num ?? "-",
                    style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: Color(0xFF41455E)),
                  )
                ])),
              ],
            ),
            SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
