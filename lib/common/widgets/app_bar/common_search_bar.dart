import 'package:flutter/material.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/localization/strings.dart';

import '../../gen/assets/assets.gen.dart';
import '../../vibrator/vibrator_extension.dart';

class CommonSearchBar extends AppBar implements PreferredSizeWidget {
  final VoidCallback onSearchClicked;
  final VoidCallback onMicrophoneClicked;
  final VoidCallback onFavoriteClicked;
  final VoidCallback onNotificationClicked;

  CommonSearchBar({
    super.key,
    required this.onSearchClicked,
    required this.onMicrophoneClicked,
    required this.onFavoriteClicked,
    required this.onNotificationClicked,
  }) : super(
          backgroundColor: Colors.white,
          elevation: 0.5,
          toolbarHeight: 72,
          actions: [
            _getSearchBar(onSearchClicked),
            _getFavoriteAction(onFavoriteClicked),
            _getNotificationAction(onNotificationClicked),
          ],
        );

  static Expanded _getSearchBar(VoidCallback? onSearchClicked) {
    return Expanded(
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
    );
  }

  static IconButton _getFavoriteAction(VoidCallback onFavoriteClicked) {
    return IconButton(
      onPressed: () {
        onFavoriteClicked();
        vibrateByTactile();
      },
      icon: Assets.images.bottomBar.favorite.svg(),
    );
  }

  static IconButton _getNotificationAction(VoidCallback onNotificationClicked) {
    return IconButton(
      onPressed: () {
        onNotificationClicked();
        vibrateByTactile();
      },
      icon: Assets.images.icNotification.svg(color: Color(0xFF5C6AC4)),
    );
  }
}
