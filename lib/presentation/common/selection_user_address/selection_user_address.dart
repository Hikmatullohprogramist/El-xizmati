import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/common/vibrator/vibrator_extension.dart';
import 'package:onlinebozor/common/widgets/address/user_address_selection.dart';

import '../../../../../common/widgets/loading/loader_state_widget.dart';
import '../../../../../data/responses/address/user_address_response.dart';
import '../../../common/widgets/common/bottom_sheet_title.dart';
import 'cubit/selection_user_address_cubit.dart';

@RoutePage()
class SelectionUserAddressPage extends BasePage<SelectionUserAddressCubit,
    SelectionUserAddressBuildable, SelectionUserAddressListenable> {
  const SelectionUserAddressPage({
    super.key,
    this.selectedAddress,
  });

  final UserAddressResponse? selectedAddress;

  @override
  void listener(BuildContext context, SelectionUserAddressListenable event) {
    switch (event.effect) {
      case SelectionUserAddressEffect.back:
        {}
    }
  }

  @override
  Widget builder(BuildContext context, SelectionUserAddressBuildable state) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.sizeOf(context).height * .7,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: LoaderStateWidget(
              isFullScreen: false,
              loadingState: state.userAddressState,
              child: Column(
                children: [
                  SizedBox(height: 20),
                  BottomSheetTitle(
                    title: "Выберите адрес",
                    onCloseClicked: () {
                      context.router.pop();
                    },
                  ),
                  ListView.separated(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(vertical: 12),
                    itemCount: state.userAddresses.length,
                    itemBuilder: (context, index) {
                      var element = state.userAddresses[index];
                      return UserAddressSelection(
                        address: element,
                        onClicked: () {
                          context.router.pop(element);
                          vibrateAsHapticFeedback();
                        },
                        isSelected: selectedAddress?.id == element.id,
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
