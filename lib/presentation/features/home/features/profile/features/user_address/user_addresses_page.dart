import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:onlinebozor/core/gen/assets/assets.gen.dart';
import 'package:onlinebozor/core/gen/localization/strings.dart';
import 'package:onlinebozor/domain/models/user/user_address.dart';
import 'package:onlinebozor/presentation/router/app_router.dart';
import 'package:onlinebozor/presentation/support/colors/static_colors.dart';
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
import 'package:onlinebozor/presentation/widgets/loading/loader_state_widget.dart';

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
                cubit(context).reloadAddresses();
              }
            },
          )
        ],
      ),
      backgroundColor: context.backgroundGreyColor,
      body: LoaderStateWidget(
        isFullScreen: true,
        loadingState: state.loadingState,
        loadingBody: _buildLoadingBody(),
        successBody: _buildSuccessBody(context, state),
        emptyBody: _buildEmptyBody(context),
        errorBody: _buildErrorBody(context),
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

  Widget _buildSuccessBody(BuildContext context, UserAddressesState state) {
    return RefreshIndicator(
      displacement: 80,
      strokeWidth: 3,
      color: StaticColors.colorPrimary,
      onRefresh: () async {
        cubit(context).reloadAddresses();
      },
      child: ListView.separated(
        // physics: BouncingScrollPhysics(),
        // shrinkWrap: true,
        padding: EdgeInsets.symmetric(vertical: 12),
        itemCount: state.addresses.length,
        itemBuilder: (context, index) {
          var address = state.addresses[index];
          return ElevationWidget(
            topLeftRadius: 8,
            topRightRadius: 8,
            bottomLeftRadius: 8,
            bottomRightRadius: 8,
            leftMargin: 16,
            topMargin: 6,
            rightMargin: 16,
            bottomMargin: 6,
            child: UserAddressWidget(
              onClicked: () {},
              address: address,
              onEditClicked: () {
                _showAddressActions(context, address, index);
              },
              isManageEnabled: true,
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox();
        },
      ),
    );
  }

  Widget _buildEmptyBody(BuildContext context) {
    return UserAddressEmptyWidget(
      onActionClicked: () async {
        final isAdded = await context.router.push(AddAddressRoute());
        if (isAdded is bool && isAdded == true) {
          cubit(context).reloadAddresses();
        }
      },
    );
  }

  Widget _buildErrorBody(BuildContext context) {
    return DefaultErrorWidget(
      isFullScreen: true,
      onRetryClicked: () => cubit(context).reloadAddresses(),
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
                title: Strings.userAddressActionsTitle,
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
                    cubit(context).reloadAddresses();
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
      },
    );
  }
}
