import 'package:flutter/material.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/localization/strings.dart';

import '../../gen/assets/assets.gen.dart';

class CommonActiveSearchBar extends AppBar implements PreferredSizeWidget {
  final VoidCallback? onPressedMic;
  final VoidCallback? onPressedSearch;
  final VoidCallback? onPressedNotification;

  CommonActiveSearchBar(
      {super.key,
      this.onPressedMic,
      this.onPressedSearch,
      this.onPressedNotification})
      : super(
          actions: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16, 12, 0, 12),
                child: Container(
                  width: double.maxFinite,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                          width: 0.50, color: Color(0xFFE5E9F3)),
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: Row(children: [
                    InkWell(
                        onTap: onPressedSearch,
                        child: IconButton(
                            alignment: Alignment.center,
                            onPressed: null,
                            icon: Assets.images.iconSearch
                                .svg(width: 24, height: 24))),
                    Expanded(
                        child: InkWell(
                            onTap: onPressedSearch,
                            child: Strings.auth.w(400))),
                    InkWell(
                        onTap: onPressedMic,
                        child: IconButton(
                            alignment: Alignment.centerRight,
                            onPressed: null,
                            icon: Assets.images.icMic
                                .svg(width: 24, height: 24))),
                  ]),
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(12, 20, 16, 20),
                child: InkWell(
                    onTap: onPressedNotification,
                    child: Assets.images.icNotification
                        .svg(height: 24, width: 24)))
          ],
          backgroundColor: Colors.white,
          elevation: 0.5,
          toolbarHeight: 64,
        );
}
