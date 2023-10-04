import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/base/base_page.dart';
import 'package:onlinebozor/common/widgets/app_diverder.dart';
import 'package:onlinebozor/common/widgets/chat/chat_item.dart';
import 'package:onlinebozor/presentation/home/profile_dashboard/features/chat_list/features/buying_chats/cubit/buying_chats_cubit.dart';

import '../../../../../../../common/router/app_router.dart';

@RoutePage()
class BuyingChatsPage extends BasePage<BuyingChatsCubit, BuyingChatsBuildable,
    BuyingChatsListenable> {
  const BuyingChatsPage({super.key});

  @override
  Widget builder(BuildContext context, BuyingChatsBuildable state) {
    return Scaffold(
        body: ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return ChatItem(onPressed: () => context.router.push(ChatRoute()));
      },
      itemCount: 20,
      separatorBuilder: (BuildContext context, int index) {
        return AppDivider();
      },
    ));
  }
}
