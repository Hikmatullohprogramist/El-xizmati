import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/common/widgets/action/action_item_shimmer.dart';
import 'package:onlinebozor/common/widgets/button/custom_elevated_button.dart';
import 'package:onlinebozor/domain/mappers/region_mapper.dart';
import 'package:onlinebozor/domain/models/district/district.dart';

import '../../../common/gen/localization/strings.dart';
import '../../../common/widgets/action/multi_selection_list_collapse_item.dart';
import '../../../common/widgets/bottom_sheet/bottom_sheet_title.dart';
import '../../../common/widgets/divider/custom_diverder.dart';
import '../../../common/widgets/loading/loader_state_widget.dart';
import 'cubit/page_cubit.dart';

@RoutePage()
class SelectionRegionAndDistrictPage
    extends BasePage<PageCubit, PageState, PageEvent> {
  const SelectionRegionAndDistrictPage({
    super.key,
    this.initialSelectedDistricts,
  });

  final List<District>? initialSelectedDistricts;

  @override
  void onWidgetCreated(BuildContext context) {
    cubit(context).setInitialParams(initialSelectedDistricts);
  }

  @override
  Widget onWidgetBuild(BuildContext context, PageState state) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.sizeOf(context).height * 0.9,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              color: Colors.white,
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
              padding: EdgeInsets.symmetric(horizontal: 12),
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

  Widget _buildSuccessBody(PageState state) {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: state.visibleItems.length,
      itemBuilder: (context, index) {
        var element = state.visibleItems[index];
        return MultiSelectionListCollapseItem(
          item: element,
          title: element.name,
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
