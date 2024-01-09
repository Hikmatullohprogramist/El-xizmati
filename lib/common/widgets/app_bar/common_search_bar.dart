import 'package:flutter/material.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/localization/strings.dart';

import '../../gen/assets/assets.gen.dart';

class CommonSearchBar extends AppBar implements PreferredSizeWidget {
  final VoidCallback? onMicrophoneClicked;
  final VoidCallback? onSearchClicked;
  final VoidCallback? onNotificationClicked;

  CommonSearchBar({
    super.key,
    this.onMicrophoneClicked,
    this.onSearchClicked,
    this.onNotificationClicked,
  }) : super(
          backgroundColor: Colors.white,
          elevation: 0.5,
          toolbarHeight: 72,
          actions: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16, 12, 0, 12),
                child: InkWell(
                  onTap: onSearchClicked,
                  child: Container(
                    width: double.maxFinite,
                    height: 42,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          width: 0.50,
                          color: Color(0xFFE5E9F3),
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: onSearchClicked,
                          child: Assets.images.iconSearch.svg(),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: InkWell(
                            onTap: onSearchClicked,
                            child: Strings.adSearchHint
                                .w(400)
                                .s(14)
                                .c(Color(0xFF9EABBE))
                                .copyWith(overflow: TextOverflow.ellipsis),
                          ),
                        ),
                        // InkWell(
                        //   onTap: onMicrophoneClicked,
                        //   child: Assets.images.icMic.svg(),
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: onNotificationClicked,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 20, 16, 20),
                child: Assets.images.icNotification.svg(),
              ),
            )
          ],
        );
}
