import 'package:elegant_notification/elegant_notification.dart';
import 'package:elegant_notification/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/core/di/injection.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';
import 'package:onlinebozor/core/snackbar/snack_bar_manager.dart';
import 'package:onlinebozor/core/snackbar/snack_bar_message_type.dart';

class SnackBarWidget extends StatelessWidget {
  const SnackBarWidget({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Inter',
        // scaffoldBackgroundColor: Colors.white,
      ),
      home: Stack(
        children: [
          child,
          Builder(
            builder: (context) {
              _initDisplay(context);
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }

  void _initDisplay(BuildContext context) {
    final display = getIt<SnackBarManager>();

    display.setOnShowListener((message) {
      final IconData icon;
      final Color color;
      switch (message.type) {
        case SnackBarMessageType.error:
          icon = Icons.error;
          color = Colors.red;
          break;
        case SnackBarMessageType.warning:
          icon = Icons.warning;
          color = Colors.orange;
          break;
        case SnackBarMessageType.info:
          icon = Icons.info_outline;
          color = Colors.blue;
          break;
        case SnackBarMessageType.success:
          icon = Icons.check_circle_outline;
          color = Colors.green;
          break;
      }

      ElegantNotification(
        title: message.title?.s(16).w(600).c(color),
        description: message.description.s(14).w(400).c(color),
        icon: Icon(icon, color: color),
        notificationPosition: NotificationPosition.topCenter,
        animation: AnimationType.fromTop,
        progressIndicatorColor: color,
      ).show(context);
    });
  }
}
