import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/presentation/support/extensions/color_extension.dart';
import 'package:onlinebozor/presentation/support/cubit/base_page.dart';
import 'package:onlinebozor/core/gen/localization/strings.dart';
import 'package:onlinebozor/domain/mappers/region_mapper.dart';
import 'package:onlinebozor/domain/models/district/district.dart';
import 'package:onlinebozor/presentation/support/extensions/platform_sizes.dart';
import 'package:onlinebozor/presentation/widgets/action/action_item_shimmer.dart';
import 'package:onlinebozor/presentation/widgets/action/multi_selection_expandable_item.dart';
import 'package:onlinebozor/presentation/widgets/bottom_sheet/bottom_sheet_title.dart';
import 'package:onlinebozor/presentation/widgets/button/custom_elevated_button.dart';
import 'package:onlinebozor/presentation/widgets/divider/custom_divider.dart';
import 'package:onlinebozor/presentation/widgets/loading/loader_state_widget.dart';

import 'region_selection_cubit.dart';

@RoutePage()
class RegionSelectionPage extends BasePage<RegionSelectionCubit,
    RegionSelectionState, RegionSelectionEvent> {
  final List<District>? initialSelectedDistricts;

  const RegionSelectionPage({
    super.key,
    this.initialSelectedDistricts,
  });

  @override
  void onWidgetCreated(BuildContext context) {
    cubit(context).setInitialParams(initialSelectedDistricts);
  }

  @override
  Widget onWidgetBuild(BuildContext context, RegionSelectionState state) {
    return Material(
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
                    title: Strings.selectionDeliveryDistrictsTitle,
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
                  SizedBox(height: 56),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(16, 0, 16, bottomSheetBottomPadding),
            child: CustomElevatedButton(
              text: Strings.commonSave,
              onPressed: () {
                List<District> districts = state.allItems
                    .where((e) => !e.isParent && e.isSelected)
                    .map((e) => e.toDistrict())
                    .toList();
                context.router.pop(districts);
              },
            ),
          ),
        ],
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
        return ActionItemShimmer();
      },
      separatorBuilder: (BuildContext context, int index) {
        return CustomDivider(startIndent: 48, color: Color(0xFFE5E9F3));
      },
    );
  }

  Widget _buildSuccessBody(RegionSelectionState state) {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      padding: EdgeInsets.only(bottom: 64),
      itemCount: state.visibleItems.length,
      itemBuilder: (context, index) {
        var element = state.visibleItems[index];
        return MultiSelectionExpandableItem(
          item: element,
          title: element.name,
          isSelected: element.isSelected,
          isOpened: element.isOpened,
          isParent: element.isParent,
          totalChildCount: element.totalChildCount,
          selectedChildCount: element.selectedChildCount,
          onCollapseClicked: (item) {
            cubit(context).openOrClose(item);
          },
          onCheckboxClicked: (item) {
            cubit(context).updateSelectedState(item);
          },
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return CustomDivider(startIndent: 20, endIndent: 20);
      },
    );
  }
}
