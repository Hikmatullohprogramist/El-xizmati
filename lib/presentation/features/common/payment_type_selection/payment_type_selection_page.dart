import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/presentation/support/colors/color_extension.dart';
import 'package:onlinebozor/presentation/support/cubit/base_page.dart';
import 'package:onlinebozor/core/gen/localization/strings.dart';
import 'package:onlinebozor/data/datasource/network/responses/payment_type/payment_type_response.dart';
import 'package:onlinebozor/presentation/widgets/action/action_item_shimmer.dart';
import 'package:onlinebozor/presentation/widgets/action/multi_selection_list_item.dart';
import 'package:onlinebozor/presentation/widgets/bottom_sheet/bottom_sheet_title.dart';
import 'package:onlinebozor/presentation/widgets/button/custom_elevated_button.dart';
import 'package:onlinebozor/presentation/widgets/divider/custom_diverder.dart';

import '../../../../../presentation/widgets/loading/loader_state_widget.dart';
import 'cubit/payment_type_selection_cubit.dart';

@RoutePage()
class PaymentTypeSelectionPage
    extends BasePage<PageCubit, PageState, PageEvent> {
  const PaymentTypeSelectionPage({
    super.key,
    this.selectedPaymentTypes,
  });

  final List<PaymentTypeResponse>? selectedPaymentTypes;

  @override
  void onWidgetCreated(BuildContext context) {
    cubit(context).setInitialParams(selectedPaymentTypes);
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
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              color: context.bottomSheetColor,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    BottomSheetTitle(
                      title: Strings.selectionPaymentTypeTitle,
                      onCloseClicked: () {
                        context.router.pop();
                      },
                    ),
                    LoaderStateWidget(
                      isFullScreen: false,
                      loadingState: state.loadState,
                      loadingBody: _buildLoadingBody(),
                      successBody: _buildSuccessBody(state),
                      onRetryClicked: () => cubit(context).getItems(),
                    ),
                    SizedBox(height: 72),
                  ],
                ),
              ),
            ),
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
    );
  }

  Widget _buildLoadingBody() {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: 7,
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
        return CustomDivider(height: 2, startIndent: 20, endIndent: 20);
      },
    );
  }

  Widget directions() {
    return Container();
  }
}
