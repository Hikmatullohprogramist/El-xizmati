import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:El_xizmati/core/extensions/text_extensions.dart';
import 'package:El_xizmati/presentation/support/extensions/color_extension.dart';

class ChatItem extends StatelessWidget {
  const ChatItem({super.key, required this.listener});

  final VoidCallback listener;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: listener,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                width: 42,
                height: 42,
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  color: Color(0xFFDFE2E9),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: CachedNetworkImage(
                  imageUrl: "https://api.online-bozor.uz/uploads/images/}",
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                          Colors.white,
                          BlendMode.colorBurn,
                        ),
                      ),
                    ),
                  ),
                  placeholder: (context, url) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(6)),
                    child: Center(child: Icon(Icons.error)),
                  ),
                ),
              ),
              SizedBox(width: 12),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      "Техно-ID".w(600).s(14).c(context.textPrimary),
                      "11:23".w(500).s(10).c(context.textSecondary)
                    ],
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  "Планшет Samsung Galaxy Tab A 8.0 SM-T2 S..."
                      .w(400)
                      .s(10)
                      .c(context.textSecondary)
                      .copyWith(overflow: TextOverflow.ellipsis, maxLines: 1),
                ],
              )
            ]),
      ),
    );
  }
}
