import 'package:flutter/material.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';
import 'package:onlinebozor/core/gen/assets/assets.gen.dart';
import 'package:onlinebozor/core/gen/localization/strings.dart';

class SearchAppBar2 extends AppBar implements PreferredSizeWidget {
  final VoidCallback? listenerMic;
  final VoidCallback? listener;
  final VoidCallback? listenerSearch;
  final VoidCallback? listenerNotification;
  @override
  final Color backgroundColor;

  SearchAppBar2({
    super.key,
    required this.backgroundColor,
    this.listenerMic,
    this.listenerSearch,
    this.listenerNotification,
    this.listener,
  }) : super(
          backgroundColor: backgroundColor,
          actions: [
            InkWell(
              onTap: listener,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 16, top: 8, bottom: 8, right: 12),
                child: Assets.images.icArrowLeft.svg(),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16, 12, 0, 12),
                child: InkWell(
                  onTap: listenerSearch,
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
                          onTap: listenerSearch,
                          child: Assets.images.iconSearch.svg(),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                            child: InkWell(
                          onTap: listenerSearch,
                          child: Strings.adSearchHint
                              .w(400)
                              .s(14)
                              .c(Color(0xFF9EABBE))
                              .copyWith(overflow: TextOverflow.ellipsis),
                        )),
                        InkWell(
                            onTap: listenerMic,
                            child: Assets.images.icMic.svg()),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: listenerNotification,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 20, 16, 20),
                child: Assets.images.icNotification.svg(),
              ),
            )
          ],
          // backgroundColor: context.themeOf.backgroundColor,
          elevation: 0.5,
          toolbarHeight: 64,
        );
}
