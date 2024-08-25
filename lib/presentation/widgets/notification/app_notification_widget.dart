import 'package:flutter/material.dart';
import 'package:El_xizmati/core/extensions/text_extensions.dart';
import 'package:El_xizmati/domain/models/notification/notification.dart';
import 'package:El_xizmati/presentation/widgets/divider/custom_divider.dart';

class AppNotificationWidget extends StatelessWidget {
  final AppNotification notification;
  final VoidCallback onClicked;

  const AppNotificationWidget({
    super.key,
    required this.notification,
    required this.onClicked,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: notification.isUnread
            ? Border.all(
                width: 1.5,
                color: Color(0xFF3f9cfb).withOpacity(0.75),
              )
            : Border.all(color: Colors.transparent),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => onClicked(),
          borderRadius: BorderRadius.circular(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 16),
                  Expanded(
                    child: notification.title
                        .s(16)
                        .w(notification.isUnread ? 600 : 400)
                        .copyWith(
                            maxLines: 2, overflow: TextOverflow.ellipsis),
                  ),
                  SizedBox(width: 16),
                ],
              ),
              SizedBox(height: 12),
              CustomDivider(),
              SizedBox(height: 12),
              Row(
                children: [
                  SizedBox(width: 16),
                  Expanded(
                    child: notification.message
                        .s(14)
                        .w(notification.isUnread ? 600 : 400)
                        .copyWith(
                            maxLines: 5, overflow: TextOverflow.ellipsis),
                  ),
                  SizedBox(width: 16),
                ],
              ),
              SizedBox(height: 12),
              CustomDivider(),
              SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Align(
                  alignment: Alignment.topRight,
                  child: notification.createdAt
                      .s(12)
                      .w(notification.isUnread ? 600 : 400)
                      .copyWith(textAlign: TextAlign.right),
                ),
              ),
              SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
