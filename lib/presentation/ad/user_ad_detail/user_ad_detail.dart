import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/base/base_page.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/presentation/ad/user_ad_detail/cubit/user_ad_detail_cubit.dart';

@RoutePage()
class UserAdDetailPage extends BasePage<UserAdDetailCubit,
    UserAdDetailBuildable, UserAdDetailListenable> {
  const UserAdDetailPage({super.key});

  @override
  Widget builder(BuildContext context, UserAdDetailBuildable state) {
    return Scaffold(
      body: Center(child: "User Ad Detail".w(500).s(16)),
    );
  }
}
