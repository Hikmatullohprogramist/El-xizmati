import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/core/base_page.dart';

import 'cubit/selection_address_cubit.dart';

@RoutePage()
class SelectionAddressPage extends BasePage<SelectionAddressCubit,
    SelectionAddressBuildable, SelectionAddressListenable> {
  const SelectionAddressPage({super.key});

  @override
  Widget builder(context, SelectionAddressBuildable state) {
    return Scaffold();
  }
}
