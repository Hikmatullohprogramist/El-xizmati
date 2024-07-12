import 'package:flutter/material.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';
import 'package:onlinebozor/domain/models/notification/notification.dart';

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
                width: .5,
                color: Color(0xFF3f9cfb).withOpacity(0.75),
              )
            : Border.all(color: Colors.transparent),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => onClicked(),
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: notification.title
                          .s(14)
                          .w(notification.isUnread ? 600 : 400)
                          .copyWith(
                              maxLines: 2, overflow: TextOverflow.ellipsis),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: notification.message
                          .s(12)
                          .w(notification.isUnread ? 600 : 400)
                          .copyWith(
                              maxLines: 5, overflow: TextOverflow.ellipsis),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Align(
                  alignment: Alignment.topRight,
                  child: notification.createdAt
                      .s(13)
                      .w(notification.isUnread ? 600 : 400)
                      .copyWith(textAlign: TextAlign.right),
                ),
                SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
