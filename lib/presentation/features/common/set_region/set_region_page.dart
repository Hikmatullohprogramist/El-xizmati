import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:El_xizmati/core/extensions/text_extensions.dart';
import 'package:El_xizmati/core/gen/localization/strings.dart';
import 'package:El_xizmati/presentation/support/colors/static_colors.dart';
import 'package:El_xizmati/presentation/support/cubit/base_page.dart';
import 'package:El_xizmati/presentation/support/extensions/color_extension.dart';
import 'package:El_xizmati/presentation/support/extensions/platform_sizes.dart';
import 'package:El_xizmati/presentation/widgets/action/action_item_shimmer.dart';
import 'package:El_xizmati/presentation/widgets/bottom_sheet/bottom_sheet_title.dart';
import 'package:El_xizmati/presentation/widgets/button/custom_elevated_button.dart';
import 'package:El_xizmati/presentation/widgets/divider/custom_divider.dart';
import 'package:El_xizmati/presentation/widgets/loading/loader_state_widget.dart';

import '../../../../core/gen/assets/assets.gen.dart';
import 'set_region_cubit.dart';

@RoutePage()
class SetRegionPage
    extends BasePage<SetRegionCubit, SetRegionState, SetRegionEvent> {
  const SetRegionPage({super.key});

  @override
  void onEventEmitted(BuildContext context, SetRegionEvent event) {
    switch (event.type) {
      case SetRegionEventType.onClose:
        context.router.pop();
      case SetRegionEventType.onSave:
        context.router.pop();
    }
  }

  @override
  Widget onWidgetBuild(BuildContext context, SetRegionState state) {
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
                    title: Strings.setRegionTitle,
                    onCloseClicked: () {
                      context.router.pop();
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Strings.setRegionDescription.s(14).w(400),
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
            padding: EdgeInsets.only(bottom: defaultBottomPadding),
            child: Row(
              children: [
                SizedBox(width: 16),
                Expanded(
                  child: CustomElevatedButton(
                    text: Strings.commonFilterReset,
                    onPressed: () {
                      cubit(context).clearSelectedRegion();
                    },
                    backgroundColor: StaticColors.majorelleBlue,
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: CustomElevatedButton(
                    text: Strings.commonSave,
                    onPressed: () {
                      cubit(context).saveSelectedRegion();
                    },
                  ),
                ),
                SizedBox(width: 16),
              ],
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

  Widget _buildSuccessBody(SetRegionState state) {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      padding: EdgeInsets.only(bottom: 64),
      itemCount: state.visibleItems.length,
      itemBuilder: (context, index) {
        var element = state.visibleItems[index];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        if (element.isParent) {
                          cubit(context).openOrClose(element);
                        } else if (element.isChild) {
                          cubit(context).setSelectedDistrict(element);
                        }
                        HapticFeedback.lightImpact();
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                          top: 16,
                          bottom: 16,
                          right: 20,
                          left: 8,
                        ),
                        child: Row(
                          children: [
                            Visibility(
                              visible: !element.isParent,
                              child: SizedBox(width: 16),
                            ),
                            SizedBox(width: 15),
                            Expanded(
                              child: element.name
                                  .toString()
                                  .w(element.isSelected ? 600 : 400)
                                  .s(16)
                                  .c(context.textPrimary)
                                  .copyWith(
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                            ),
                            Visibility(
                              visible: element.isParent,
                              child: (element.isOpened
                                      ? Assets.images.icArrowDown
                                      : Assets.images.icArrowUp)
                                  .svg(),
                            ),
                            Visibility(
                              visible: element.isChild,
                              child: (element.isSelected
                                      ? Assets.images.icRadioButtonSelected
                                      : Assets.images.icRadioButtonUnSelected)
                                  .svg(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return CustomDivider(startIndent: 20, endIndent: 20);
      },
    );
  }
}
