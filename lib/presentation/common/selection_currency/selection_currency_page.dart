import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/common/widgets/action/selection_list_item.dart';
import 'package:onlinebozor/common/widgets/bottom_sheet/bottom_sheet_title.dart';
import 'package:onlinebozor/data/responses/currencies/currency_response.dart';

import '../../../../../common/widgets/loading/loader_state_widget.dart';
import '../../../common/gen/localization/strings.dart';
import '../../../common/widgets/action/action_item_shimmer.dart';
import '../../../common/widgets/divider/custom_diverder.dart';
import 'cubit/page_cubit.dart';

@RoutePage()
class SelectionCurrencyPage extends BasePage<PageCubit, PageState, PageEvent> {
  const SelectionCurrencyPage({
    super.key,
    this.initialSelectedItem,
  });

  final CurrencyResponse? initialSelectedItem;

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
          color: context.bottomNavigationColor,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(height: 20),
                BottomSheetTitle(
                  title: Strings.selectionCurrencyTitle,
                  onCloseClicked: () {
                    context.router.pop();
                  },
                ),
                LoaderStateWidget(
                  isFullScreen: false,
                  loadingState: state.loadState,
                  loadingBody: _buildLoadingBody(),
                  successBody: _buildSuccessBody(state),
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
        return SelectionListItem(
          item: element,
          title: element.name ?? "",
          isSelected: initialSelectedItem?.id == element.id,
          onClicked: (dynamic item) {
            context.router.pop(state.items[index]);
          },
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return CustomDivider(startIndent: 20, endIndent: 20);
      },
    );
  }
}
