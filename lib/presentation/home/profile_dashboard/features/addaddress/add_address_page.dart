import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/base/base_page.dart';

import 'cubit/add_address_cubit.dart';

@RoutePage()
class AddAddressPage extends BasePage<AddAddressCubit, AddAddressBuildable,
    AddAddressListenable> {
  const AddAddressPage({super.key});

  @override
  Widget builder(BuildContext context, AddAddressBuildable state) {
    return Center(
      child: Text("Auth Start"),
    );
  }
}
