import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/router/app_router.dart';
import 'package:onlinebozor/presentation/home/profile_dashboard/features/chat_list/features/saved_chats/cubit/saved_chats_cubit.dart';

import '../../../../../../../common/core/base_page.dart';
import '../../../../../../../common/widgets/app_diverder.dart';
import '../../../../../../../common/widgets/chat/chat_item.dart';

@RoutePage()
class SavedChatsPage extends BasePage<SavedChatsCubit, SavedChatsBuildable,
    SavedChatsListenable> {
  const SavedChatsPage({super.key});

  @override
  Widget builder(BuildContext context, SavedChatsBuildable state) {
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