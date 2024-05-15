import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/presentation/support/cubit/base_page.dart';
import 'package:onlinebozor/presentation/router/app_router.dart';
import 'package:onlinebozor/presentation/widgets/chat/chat_item.dart';
import 'package:onlinebozor/presentation/widgets/divider/custom_diverder.dart';

import 'cubit/buying_chats_cubit.dart';

@RoutePage()
class BuyingChatsPage extends BasePage<PageCubit, PageState, PageEvent> {
  const BuyingChatsPage({super.key});

  @override
  Widget onWidgetBuild(BuildContext context, PageState state) {
    return Scaffold(
      body: ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return ChatItem(listener: () => context.router.push(ChatRoute()));
        },
        itemCount: 20,
        separatorBuilder: (BuildContext context, int index) {
          return CustomDivider();
        },
      ),
    );
  }
}
