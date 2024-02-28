import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/core/base_page.dart';

import 'cubit/page_cubit.dart';

@RoutePage()
class SelectionAddressPage extends BasePage<PageCubit, PageState, PageEvent> {
  const SelectionAddressPage({super.key});

  @override
  Widget onWidgetBuild(context, PageState state) {
    return Scaffold();
  }
}
