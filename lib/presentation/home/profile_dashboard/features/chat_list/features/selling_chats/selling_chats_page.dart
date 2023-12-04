import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/presentation/home/profile_dashboard/features/chat_list/features/selling_chats/cubit/selling_chats_cubit.dart';

import '../../../../../../../common/core/base_page.dart';
import '../../../../../../../common/router/app_router.dart';
import '../../../../../../../common/widgets/dashboard/app_diverder.dart';
import '../../../../../../../common/widgets/chat/chat_item.dart';

@RoutePage()
class SellingChatsPage extends BasePage<SellingChatsCubit, SellingChatsBuildable,
    SellingChatsListenable> {
  const SellingChatsPage({super.key});

  @override
  Widget builder(BuildContext context, SellingChatsBuildable state) {
    return Scaffold(
        body: ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return ChatItem(onPressed: () => context.router.push(ChatRoute()));
          },
          itemCount: 20, separatorBuilder: (BuildContext context, int index) {
          return AppDivider();
        },
        ));
  }
}