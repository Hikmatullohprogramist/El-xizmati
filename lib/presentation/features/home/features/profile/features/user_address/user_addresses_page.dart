import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:onlinebozor/core/gen/assets/assets.gen.dart';
import 'package:onlinebozor/core/gen/localization/strings.dart';
import 'package:onlinebozor/domain/models/user/user_address.dart';
import 'package:onlinebozor/presentation/router/app_router.dart';
import 'package:onlinebozor/presentation/support/cubit/base_page.dart';
import 'package:onlinebozor/presentation/support/extensions/color_extension.dart';
import 'package:onlinebozor/presentation/widgets/action/action_list_item.dart';
import 'package:onlinebozor/presentation/widgets/address/user_address_empty_widget.dart';
import 'package:onlinebozor/presentation/widgets/address/user_address_shimmer.dart';
import 'package:onlinebozor/presentation/widgets/address/user_address_widget.dart';
import 'package:onlinebozor/presentation/widgets/app_bar/action_app_bar.dart';
import 'package:onlinebozor/presentation/widgets/bottom_sheet/bottom_sheet_title.dart';
import 'package:onlinebozor/presentation/widgets/button/custom_text_button.dart';
import 'package:onlinebozor/presentation/widgets/elevation/elevation_widget.dart';
import 'package:onlinebozor/presentation/widgets/loading/default_error_widget.dart';

import 'user_addresses_cubit.dart';

@RoutePage()
class UserAddressesPage extends BasePage<UserAddressesCubit, UserAddressesState,
    UserAddressesEvent> {
  const UserAddressesPage({super.key});

  @override
  Widget onWidgetBuild(BuildContext context, UserAddressesState state) {
    return Scaffold(
      appBar: ActionAppBar(
        titleText: Strings.userAddressMyAddress,
        titleTextColor: context.textPrimary,
        backgroundColor: context.appBarColor,
        onBackPressed: () => context.router.pop(),
        actions: [
          CustomTextButton(
            text: Strings.commonAdd,
            onPressed: () async {
              final isAdded = await context.router.push(AddAddressRoute());
              if (isAdded is bool && isAdded == true) {
                cubit(context).getController(true);
              }
            },
          )
        ],
      ),
      backgroundColor: context.backgroundGreyColor,
      body: PagedListView<int, UserAddress>(
        shrinkWrap: true,
        addAutomaticKeepAlives: true,
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(vertical: 12),
        pagingController: state.controller!,
        builderDelegate: PagedChildBuilderDelegate<UserAddress>(
            firstPageErrorIndicatorBuilder: (_) {
              return DefaultErrorWidget(
                isFullScreen: true,
                onRetryClicked: () =>
                    cubit(context).states.controller?.refresh(),
              );
            },
            firstPageProgressIndicatorBuilder: (_) {
              return SingleChildScrollView(
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return UserAddressShimmer();
                  },
                ),
              );
            },
            noItemsFoundIndicatorBuilder: (_) {
              return UserAddressEmptyWidget(onActionClicked: () async {
                final isAdded = await context.router.push(AddAddressRoute());
                if (isAdded is bool && isAdded == true) {
                  cubit(context).getController(true);
                }
              });
            },
            newPageProgressIndicatorBuilder: (_) {
              return SizedBox(
                height: 160,
                child: Center(
                  child: CircularProgressIndicator(color: Colors.blue),
                ),
              );
            },
            newPageErrorIndicatorBuilder: (_) {
              return DefaultErrorWidget(
                isFullScreen: false,
                onRetryClicked: () =>
                    cubit(context).states.controller?.refresh(),
              );
            },
            transitionDuration: Duration(milliseconds: 100),
            itemBuilder: (context, item, index) {
              return ElevationWidget(
                topLeftRadius: 8,
                topRightRadius: 8,
                bottomLeftRadius: 8,
                bottomRightRadius: 8,
                shadowSpreadRadius: 1.5,
                leftMargin: 16,
                topMargin: 6,
                rightMargin: 16,
                bottomMargin: 6,
                child: UserAddressWidget(
                  onClicked: () {},
                  address: item,
                  onEditClicked: () {
                    // _showAddressActions(context, state, item);
                    _showAddressActions(context, item, index);
                  },
                  isManageEnabled: true,
                ),
              );
            }),
      ),
    );
  }

  void _showAddressActions(
    BuildContext context,
    UserAddress address,
    int index,
  ) {
    showCupertinoModalBottomSheet(
        context: context,
        builder: (BuildContext buildContext) {
          return Material(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 20),
                BottomSheetTitle(
                  title: Strings.actionTitle,
                  onCloseClicked: () {
                    context.router.pop();
                  },
                ),
                SizedBox(height: 6),
                ActionListItem(
                  item: address,
                  title: Strings.actionEdit,
                  icon: Assets.images.icActionEdit,
                  onClicked: (item) async {
                    context.router.pop();

                    final isChanged = await context.router
                        .push(AddAddressRoute(address: address));

                    if (isChanged is bool && isChanged == true) {
                      cubit(context).getController(true);
                    }
                  },
                ),
                Visibility(
                  visible: !address.isMain,
                  child: ActionListItem(
                    item: address,
                    title: Strings.actionMakeMain,
                    icon: Assets.images.icActionMakeMain,
                    onClicked: (item) {
                      cubit(context).makeMainAddress(address, index);
                      context.router.pop();
                    },
                  ),
                ),
                ActionListItem(
                  item: address,
                  title: Strings.actionDelete,
                  icon: Assets.images.icActionDelete,
                  color: Color(0xFFFA6F5D),
                  onClicked: (item) {
                    cubit(context).deleteUserAddress(address);
                    context.router.pop();
                  },
                ),
                SizedBox(height: 16),
              ],
            ),
          );
        });
  }
}
