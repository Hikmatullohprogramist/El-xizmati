import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/localization/strings.dart';
import 'package:onlinebozor/common/router/app_router.dart';
import 'package:onlinebozor/common/widgets/address/user_address_empty_widget.dart';
import 'package:onlinebozor/common/widgets/address/user_address_widget.dart';
import 'package:onlinebozor/common/widgets/common/action_list_item.dart';
import 'package:onlinebozor/common/widgets/common/common_button.dart';
import 'package:onlinebozor/presentation/home/features/profile/features/user_address/cubit/page_cubit.dart';

import '../../../../../../common/gen/assets/assets.gen.dart';
import '../../../../../../common/widgets/common/bottom_sheet_title.dart';
import '../../../../../../data/responses/address/user_address_response.dart';

@RoutePage()
class UserAddressesPage extends BasePage<PageCubit, PageState, PageEvent> {
  const UserAddressesPage({super.key});

  @override
  Widget onWidgetBuild(BuildContext context, PageState state) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          CommonButton(
            type: ButtonType.text,
            onPressed: () async {
              final isAdded = await context.router
                  .push(AddAddressRoute(address: null));

              if(isAdded is bool && isAdded == true) {
                cubit(context).getController(true);
              }

            },
            child: Strings.commonAdd.w(500).s(12).c(Color(0xFF5C6AC3)),
          )
        ],
        backgroundColor: Colors.white,
        title: Strings.userAddressMyAddress
            .w(500)
            .s(16)
            .c(context.colors.textPrimary),
        centerTitle: true,
        elevation: 0.5,
        leading: IconButton(
          icon: Assets.images.icArrowLeft.svg(),
          onPressed: () => context.router.pop(),
        ),
      ),
      backgroundColor: Color(0xFFF2F4FB),
      body: PagedListView<int, UserAddressResponse>(
        shrinkWrap: true,
        addAutomaticKeepAlives: true,
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(vertical: 12),
        pagingController: state.controller!,
        builderDelegate: PagedChildBuilderDelegate<UserAddressResponse>(
          firstPageErrorIndicatorBuilder: (_) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              padding: EdgeInsets.only(left: 12, top: 12, right: 12),
              decoration: BoxDecoration(
                color: Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(width: 1, color: Color(0xFFE5E9F3)),
              ),
              child: SizedBox(
                height: 100,
                child: Center(
                  child: Column(
                    children: [
                      Strings.loadingStateError
                          .w(400)
                          .s(14)
                          .c(context.colors.textPrimary),
                      SizedBox(height: 12),
                      CommonButton(
                          onPressed: () {},
                          type: ButtonType.elevated,
                          child: Strings.loadingStateRetry.w(400).s(15))
                    ],
                  ),
                ),
              ),
            );
          },
          firstPageProgressIndicatorBuilder: (_) {
            return SizedBox(
              height: 160,
              child: Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              ),
            );
          },
          noItemsFoundIndicatorBuilder: (_) {
            return UserAddressEmptyWidget(callBack: () {
              context.router.push(AddAddressRoute());
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
            return SizedBox(
              height: 160,
              child: Center(
                child: CircularProgressIndicator(color: Colors.blue),
              ),
            );
          },
          transitionDuration: Duration(milliseconds: 100),
          itemBuilder: (context, item, index) => UserAddressWidget(
            onClicked: () {},
            address: item,
            onEditClicked: () {
              // _showAddressActions(context, state, item);
              _showAddressActions(context, item, index);
            },
            isManageEnabled: true,
          ),
        ),
      ),
    );
  }

  void _showAddressActions(
    BuildContext context,
    UserAddressResponse address,
    int index,
  ) {
    showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        backgroundColor: Colors.white,
        context: context,
        builder: (BuildContext buildContext) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
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
                  visible: address.is_main != true,
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
