import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/core/gen/localization/strings.dart';
import 'package:onlinebozor/domain/models/user/user_address.dart';
import 'package:onlinebozor/presentation/router/app_router.dart';
import 'package:onlinebozor/presentation/support/cubit/base_page.dart';
import 'package:onlinebozor/presentation/support/extensions/color_extension.dart';
import 'package:flutter/services.dart';
import 'package:onlinebozor/presentation/support/extensions/platform_sizes.dart';
import 'package:onlinebozor/presentation/widgets/address/user_address_empty_widget.dart';
import 'package:onlinebozor/presentation/widgets/address/user_address_selection_widget.dart';
import 'package:onlinebozor/presentation/widgets/address/user_address_shimmer.dart';
import 'package:onlinebozor/presentation/widgets/bottom_sheet/bottom_sheet_title.dart';
import 'package:onlinebozor/presentation/widgets/loading/loader_state_widget.dart';

import 'user_address_selection_cubit.dart';

@RoutePage()
class UserAddressSelectionPage extends BasePage<UserAddressSelectionCubit,
    UserAddressSelectionState, UserAddressSelectionEvent> {
  final UserAddress? selectedAddress;

  const UserAddressSelectionPage({
    super.key,
    this.selectedAddress,
  });

  @override
  Widget onWidgetBuild(BuildContext context, UserAddressSelectionState state) {
    return Material(
      child: Container(
        color: context.bottomSheetColor,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: 20),
              BottomSheetTitle(
                title: Strings.selectionUserAddressTitle,
                onCloseClicked: () {
                  context.router.pop();
                },
              ),
              LoaderStateWidget(
                isFullScreen: false,
                loadingState: state.loadState,
                loadingBody: _buildLoadingBody(),
                successBody: _buildSuccessBody(state),
                emptyBody: UserAddressEmptyWidget(
                  onActionClicked: () async {
                    final isAdded =
                        await context.router.push(AddAddressRoute());
                    if (isAdded is bool && isAdded == true) {
                      cubit(context).getItems();
                    }
                  },
                ),
                onRetryClicked: () {
                  cubit(context).getItems();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingBody() {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: 3,
      itemBuilder: (context, index) {
        return UserAddressShimmer();
      },
      separatorBuilder: (BuildContext context, int index) {
        return Padding(padding: EdgeInsets.only(top: 3, bottom: 3));
      },
    );
  }

  ListView _buildSuccessBody(UserAddressSelectionState state) {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      padding: EdgeInsets.only(top: 12, bottom: bottomSheetBottomPadding),
      itemCount: state.items.length,
      itemBuilder: (context, index) {
        var element = state.items[index];
        return UserAddressSelectionWidget(
          address: element,
          onClicked: () {
            context.router.pop(element);
            HapticFeedback.lightImpact();
          },
          isSelected: selectedAddress?.id == element.id,
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox();
      },
    );
  }
}
