import 'package:flutter/material.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';

import '../../gen/assets/assets.gen.dart';

class CommonActiveSearchBar extends AppBar implements PreferredSizeWidget {
  final VoidCallback? onPressedMic;
  final VoidCallback? onBack;
  final VoidCallback? onPressedSearch;
  final VoidCallback? onPressedNotification;

  CommonActiveSearchBar({
    super.key,
    this.onPressedMic,
    this.onPressedSearch,
    this.onPressedNotification,
    this.onBack,
  }) : super(
          actions: [
            InkWell(
                onTap: onBack,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 16, top: 8, bottom: 8, right: 12),
                  child: Assets.images.icArrowLeft.svg(),
                )),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16, 12, 0, 12),
                child: InkWell(
                  onTap: onPressedSearch,
                  child: Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            width: 0.50, color: Color(0xFFE5E9F3)),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: onPressedSearch,
                          child: Assets.images.iconSearch.svg(),
                        ),
                        SizedBox(width: 10),
                        InkWell(
                          onTap: onPressedSearch,
                          child: "Искать товары и категории".w(400).s(14).c(
                                Color(0xFF9EABBE)).copyWith(overflow: TextOverflow.ellipsis),
                        ),
                        Spacer(),
                        InkWell(
                            onTap: onPressedMic,
                            child: Assets.images.icMic.svg()),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
                onTap: onPressedNotification,
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 20, 16, 20),
                    child: Assets.images.icNotification.svg()))
          ],
          backgroundColor: Colors.white,
          elevation: 0.5,
          toolbarHeight: 64,
        );
}
