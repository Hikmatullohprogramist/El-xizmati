import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/widgets/common/bottom_sheet_title.dart';
import 'package:onlinebozor/common/widgets/common/multi_selection_list_item.dart';
import 'package:onlinebozor/data/responses/address/user_address_response.dart';
import 'package:onlinebozor/presentation/common/selection_user_warehouse/cubit/page_cubit.dart';

import '../../../../../common/widgets/loading/loader_state_widget.dart';
import '../../../common/widgets/common/common_button.dart';
import '../../../common/widgets/dashboard/app_diverder.dart';

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
      height: MediaQuery.sizeOf(context).height * .4,
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
                  title: "Выберите адреса самовывоза",
                  onCloseClicked: () {
                    context.router.pop();
                  },
                ),
                LoaderStateWidget(
                  isFullScreen: false,
                  loadingState: state.loadState,
                  child: ListView.separated(
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
                      return AppDivider(startIndent: 20, endIndent: 20);
                    },
                  ),
                ),
                SizedBox(height: 16),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: CommonButton(
                    color: context.colors.buttonPrimary,
                    onPressed: () {
                      context.router.pop(state.selectedItems);
                    },
                    child: Container(
                      height: 52,
                      alignment: Alignment.center,
                      width: double.infinity,
                      child: "Сохранить"
                          .w(500)
                          .s(14)
                          .c(context.colors.textPrimaryInverse),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
