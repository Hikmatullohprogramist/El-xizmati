import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/base/base_page.dart';
import 'package:onlinebozor/presentation/home/profile_dashboard/features/message/cubit/message_cubit.dart';

@RoutePage()
class MessagePage
    extends BasePage<MessageCubit, MessageBuildable, MessageListenable> {
  const MessagePage({super.key});

  @override
  Widget builder(BuildContext context, MessageBuildable state) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(child: Text("Message Screen")),
    );
  }
}
