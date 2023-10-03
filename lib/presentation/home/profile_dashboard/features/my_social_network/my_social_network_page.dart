import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/base/base_page.dart';
import 'package:onlinebozor/presentation/home/profile_dashboard/features/my_social_network/cubit/my_social_network_cubit.dart';

@RoutePage()
class MySocialNetworkPage extends BasePage<MySocialNetworkCubit,
    MySocialNetworkBuildable, MySocialNetworkListenable> {
  const MySocialNetworkPage({super.key});

  @override
  Widget builder(BuildContext context, MySocialNetworkBuildable state) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text("My Social Network page"),
      ),
    );
  }
}
