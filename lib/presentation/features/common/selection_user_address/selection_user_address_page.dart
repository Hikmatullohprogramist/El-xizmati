import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/core/colors/color_extension.dart';
import 'package:onlinebozor/core/cubit/base_page.dart';
import 'package:onlinebozor/core/gen/localization/strings.dart';
import 'package:onlinebozor/core/vibrator/vibrator_extension.dart';
import 'package:onlinebozor/data/datasource/network/responses/address/user_address_response.dart';
import 'package:onlinebozor/domain/models/user/user_address.dart';
import 'package:onlinebozor/presentation/router/app_router.dart';
import 'package:onlinebozor/presentation/widgets/address/user_address_empty_widget.dart';
import 'package:onlinebozor/presentation/widgets/address/user_address_selection.dart';
import 'package:onlinebozor/presentation/widgets/address/user_address_shimmer.dart';
import 'package:onlinebozor/presentation/widgets/bottom_sheet/bottom_sheet_title.dart';
import 'package:onlinebozor/presentation/widgets/loading/loader_state_widget.dart';

import 'cubit/page_cubit.dart';

@RoutePage()
class SelectionUserAddressPage
    extends BasePage<PageCubit, PageState, PageEvent> {
  const SelectionUserAddressPage({
    super.key,
    this.selectedAddress,
  });

  final UserAddress? selectedAddress;

  @override
  Widget onWidgetBuild(BuildContext context, PageState state) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.sizeOf(context).height * .7,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: Container(
          color: context.bottomNavigationColor,
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
      ),
    );
  }

  Widget _buildLoadingBody() {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: 20,
      itemBuilder: (context, index) {
        return UserAddressShimmer();
      },
      separatorBuilder: (BuildContext context, int index) {
        return Padding(padding: EdgeInsets.only(top: 3, bottom: 3));
      },
    );
  }

  ListView _buildSuccessBody(PageState state) {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(vertical: 12),
      itemCount: state.items.length,
      itemBuilder: (context, index) {
        var element = state.items[index];
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
    );
  }
}
