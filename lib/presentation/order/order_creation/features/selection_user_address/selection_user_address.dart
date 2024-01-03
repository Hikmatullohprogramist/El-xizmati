import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/widgets/address/address_widget.dart';
import 'package:onlinebozor/presentation/order/order_creation/features/selection_user_address/cubit/selection_user_address_cubit.dart';

import '../../../../../common/gen/assets/assets.gen.dart';
import '../../../../../common/widgets/loading/loader_state_widget.dart';
import '../../../../../data/responses/address/user_address_response.dart';

@RoutePage()
class SelectionUserAddressPage extends BasePage<SelectionUserAddressCubit,
    SelectionUserAddressBuildable, SelectionUserAddressListenable> {
  const SelectionUserAddressPage(this.onResult, {super.key});

  final void Function(UserAddressResponse userAddressResponse) onResult;

  @override
  void listener(BuildContext context, SelectionUserAddressListenable state) {
    switch (state.effect) {
      case SelectionUserAddressEffect.back:
        {
          onResult.call(state.userAddressResponse!);
          context.router.pop(true);
        }
    }
  }

  @override
  Widget builder(BuildContext context, SelectionUserAddressBuildable state) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading:
            IconButton(icon: Assets.images.icArrowLeft.svg(), onPressed: () {context.router.pop();}),
        elevation: 0.5,
        backgroundColor: Colors.white,
        centerTitle: true,
        bottomOpacity: 1,
        title: "".w(500).s(16).c(context.colors.textPrimary),
      ),
      body: LoaderStateWidget(
        isFullScreen: true,
        loadingState: state.userAddressState,
        child: ListView.separated(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: state.userAddresses.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: AppAddressWidgets(
                listener: () {
                  context
                      .read<SelectionUserAddressCubit>()
                      .selectionUserAddress(state.userAddresses[index]);
                },
                address: state.userAddresses[index],
                listenerEdit: () {},
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox();
          },
        ),
      ),
    );
  }
}
