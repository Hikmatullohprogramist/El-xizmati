import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';

import '../../../../../../../../common/gen/assets/assets.gen.dart';
import 'cubit/chat_cubit.dart';

@RoutePage()
class ChatPage extends BasePage<ChatCubit, ChatBuildable, ChatListenable> {
  const ChatPage({super.key});

  @override
  Widget builder(BuildContext context, ChatBuildable state) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: 'Техно-ID'.w(500).s(14).c(context.colors.textPrimary),
        centerTitle: true,
        elevation: 0.5,
        leading: IconButton(
          icon: Assets.images.icArrowLeft.svg(),
          onPressed: () => context.router.pop(),
        ),
      ),
      body: Center(child: Text("Chat Page")),
    );
  }
}
