import 'package:flutter/material.dart';
import 'package:onlinebozor/presentation/support/colors/color_extension.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';
import 'package:onlinebozor/core/gen/assets/assets.gen.dart';
import 'package:onlinebozor/core/gen/localization/strings.dart';
import 'package:onlinebozor/domain/models/user/user_address.dart';

class UserAddressWidget extends StatelessWidget {
  const UserAddressWidget({
    super.key,
    required this.address,
    required this.onClicked,
    required this.onEditClicked,
    this.isManageEnabled = false,
  });

  final UserAddress address;
  final VoidCallback onClicked;
  final VoidCallback onEditClicked;
  final bool isManageEnabled;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            onEditClicked();
          },
          borderRadius: BorderRadius.circular(6),
          child: Padding(
            padding: EdgeInsets.only(left: 12, top: 12, right: 12),
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
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Visibility(
                          visible: address.isMain,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 4,
                              horizontal: 8,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Color(0xFFF6B712),
                            ),
                            child:
                                Strings.commonMain.w(500).s(12).c(Colors.white),
                          ),
                        ),
                        SizedBox(width: 8),
                        Visibility(
                          visible: isManageEnabled,
                          child: Assets.images.icThreeDotVertical.svg(),
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(height: 8),
                Strings.userAddressAddress.w(400).s(14).c(context.colors.textSecondary),
                SizedBox(height: 5),
                address.fullAddress.w(500).s(12).c(Color(0xFF41455E)),
                SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
