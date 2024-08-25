import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:El_xizmati/core/gen/localization/strings.dart';
import 'package:El_xizmati/data/datasource/network/responses/unit/unit_response.dart';
import 'package:El_xizmati/presentation/support/cubit/base_page.dart';
import 'package:El_xizmati/presentation/support/extensions/color_extension.dart';
import 'package:El_xizmati/presentation/support/extensions/platform_sizes.dart';
import 'package:El_xizmati/presentation/widgets/action/action_item_shimmer.dart';
import 'package:El_xizmati/presentation/widgets/action/selection_list_item.dart';
import 'package:El_xizmati/presentation/widgets/bottom_sheet/bottom_sheet_title.dart';
import 'package:El_xizmati/presentation/widgets/divider/custom_divider.dart';
import 'package:El_xizmati/presentation/widgets/loading/loader_state_widget.dart';

import 'unit_selection_cubit.dart';

@RoutePage()
class UnitSelectionPage extends BasePage<UnitSelectionCubit, UnitSelectionState,
    UnitSelectionEvent> {
  final UnitResponse? selectedUnit;

  const UnitSelectionPage({
    super.key,
    this.selectedUnit,
  });

  @override
  Widget onWidgetBuild(BuildContext context, UnitSelectionState state) {
    return Material(
      child: Container(
        color: context.bottomSheetColor,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: 20),
              BottomSheetTitle(
                title: Strings.selectionUnitTitle,
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
      itemCount: 8,
      itemBuilder: (context, index) {
        return ActionItemShimmer();
      },
      separatorBuilder: (BuildContext context, int index) {
        return CustomDivider(startIndent: 48, color: Color(0xFFE5E9F3));
      },
    );
  }

  Widget _buildSuccessBody(UnitSelectionState state) {
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
          isSelected: selectedUnit?.id == element.id,
          onClicked: (dynamic item) {
            context.router.pop(item);
          },
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return CustomDivider(height: 2, startIndent: 20, endIndent: 20);
      },
    );
  }
}
