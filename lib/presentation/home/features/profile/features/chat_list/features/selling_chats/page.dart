import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/common/router/app_router.dart';
import 'package:onlinebozor/common/widgets/chat/chat_item.dart';
import 'package:onlinebozor/common/widgets/dashboard/app_diverder.dart';
import 'package:onlinebozor/presentation/home/features/profile/features/chat_list/features/selling_chats/cubit/page_cubit.dart';

@RoutePage()
class SellingChatsPage extends BasePage<PageCubit, PageState, PageEvent> {
  const SellingChatsPage({super.key});

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
          return AppDivider();
        },
      ),
    );
  }
}
