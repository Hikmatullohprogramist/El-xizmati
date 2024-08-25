import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:El_xizmati/core/gen/localization/strings.dart';
import 'package:El_xizmati/data/datasource/network/responses/currencies/currency_response.dart';
import 'package:El_xizmati/presentation/support/cubit/base_page.dart';
import 'package:El_xizmati/presentation/support/extensions/color_extension.dart';
import 'package:El_xizmati/presentation/support/extensions/platform_sizes.dart';
import 'package:El_xizmati/presentation/widgets/action/action_item_shimmer.dart';
import 'package:El_xizmati/presentation/widgets/action/selection_list_item.dart';
import 'package:El_xizmati/presentation/widgets/bottom_sheet/bottom_sheet_title.dart';
import 'package:El_xizmati/presentation/widgets/divider/custom_divider.dart';
import 'package:El_xizmati/presentation/widgets/loading/loader_state_widget.dart';

import 'currency_selection_cubit.dart';

@RoutePage()
class CurrencySelectionPage extends BasePage<CurrencySelectionCubit,
    CurrencySelectionState, CurrencySelectionEvent> {
  const CurrencySelectionPage({
    super.key,
    this.initialSelectedItem,
  });

  final Currency? initialSelectedItem;

  @override
  Widget onWidgetBuild(BuildContext context, CurrencySelectionState state) {
    return Material(
      child: Container(
        color: context.bottomSheetColor,
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
    );
  }

  Widget _buildLoadingBody() {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: 4,
      itemBuilder: (context, index) {
        return ActionItemShimmer();
      },
      separatorBuilder: (BuildContext context, int index) {
        return CustomDivider(startIndent: 48, color: Color(0xFFE5E9F3));
      },
    );
  }

  ListView _buildSuccessBody(CurrencySelectionState state) {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: state.items.length,
      padding: EdgeInsets.only(bottom: defaultBottomPadding),
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
