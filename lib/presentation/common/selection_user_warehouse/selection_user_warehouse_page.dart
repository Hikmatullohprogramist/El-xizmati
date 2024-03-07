import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/common/widgets/bottom_sheet/bottom_sheet_title.dart';
import 'package:onlinebozor/common/widgets/button/custom_elevated_button.dart';
import 'package:onlinebozor/data/responses/address/user_address_response.dart';
import 'package:onlinebozor/presentation/common/selection_user_warehouse/cubit/page_cubit.dart';

import '../../../../../common/widgets/loading/loader_state_widget.dart';
import '../../../common/gen/localization/strings.dart';
import '../../../common/widgets/action/action_item_shimmer.dart';
import '../../../common/widgets/action/multi_selection_list_item.dart';
import '../../../common/widgets/divider/custom_diverder.dart';

@RoutePage()
class SelectionUserWarehousePage
    extends BasePage<PageCubit, PageState, PageEvent> {
  const SelectionUserWarehousePage({super.key, this.selectedItems});

  final List<UserAddressResponse>? selectedItems;

  @override
  void onWidgetCreated(BuildContext context) {
    cubit(context).setInitialSelectedParams(selectedItems);
  }

  @override
  Widget onWidgetBuild(BuildContext context, PageState state) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.sizeOf(context).height * .6,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(height: 20),
                BottomSheetTitle(
                  title: Strings.selectionPickupAddressesTitle,
                  onCloseClicked: () {
                    context.router.pop();
                  },
                ),
                LoaderStateWidget(
                  isFullScreen: false,
                  loadingState: state.loadState,
                  loadingBody: _buildLoadingBody(),
                  successBody: _buildSuccessBody(state),
                ),
                SizedBox(height: 16),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: CustomElevatedButton(
                    text: Strings.commonSave,
                    onPressed: () {
                      context.router.pop(state.selectedItems);
                    },
                  ),
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
      itemCount: 6,
      itemBuilder: (context, index) {
        return ActionItemShimmer();
      },
      separatorBuilder: (BuildContext context, int index) {
        return CustomDivider(startIndent: 48, color: Color(0xFFE5E9F3));
      },
    );
  }

  ListView _buildSuccessBody(PageState state) {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: state.items.length,
      itemBuilder: (context, index) {
        var element = state.items[index];
        return MultiSelectionListItem(
          item: element,
          title: element.name ?? "",
          isSelected: state.selectedItems.contains(element),
          onClicked: (dynamic item) {
            cubit(context).updateSelectedItems(item);
          },
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return CustomDivider(startIndent: 20, endIndent: 20);
      },
    );
  }
}
