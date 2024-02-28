import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../../common/core/base_page.dart';
import '../../../common/gen/localization/strings.dart';
import '../../../common/widgets/app_bar/common_app_bar.dart';
import 'cubit/page_cubit.dart';

@RoutePage()
class CreateServiceOrderPage extends BasePage<PageCubit, PageState, PageEvent> {
  const CreateServiceOrderPage({super.key});

  @override
  Widget onWidgetBuild(BuildContext context, PageState state) {
    return Scaffold(
      appBar: CommonAppBar(
        Strings.createRequestTitle,
        () => context.router.pop(),
      ),
    );
  }
}
