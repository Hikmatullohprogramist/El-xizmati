import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/common/widgets/button/custom_elevated_button.dart';
import 'package:onlinebozor/domain/models/district/district.dart';

import '../../../common/gen/localization/strings.dart';
import '../../../common/widgets/action/multi_selection_list_item.dart';
import '../../../common/widgets/action/multi_selection_list_collapse_item.dart';
import '../../../common/widgets/bottom_sheet/bottom_sheet_title.dart';
import '../../../common/widgets/divider/custom_diverder.dart';
import '../../../common/widgets/loading/loader_state_widget.dart';
import '../../../data/responses/region/region_root_response.dart';
import 'cubit/page_cubit.dart';

@RoutePage()
class SelectionAddressPage extends BasePage<PageCubit, PageState, PageEvent> {
  const SelectionAddressPage({
    super.key,
    this.initialSelectedDistricts,
  });

  final List<District>? initialSelectedDistricts;

  @override
  void init(BuildContext context) {
    cubit(context).setInitialParams(initialSelectedDistricts);
  }

  @override
  Widget onWidgetBuild(BuildContext context, PageState state) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.sizeOf(context).height * .9,
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
                      title: "Выбор районов доставки",
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
                        itemCount: state.visibleItems.length,
                        itemBuilder: (context, index) {
                          var element = state.visibleItems[index];
                          return Column(
                            children: [
                              MultiSelectionListCollapseItem(
                                item: element,
                                title: element.name,
                                isSelected: element.isSelected,
                                onClicked: (dynamic item) {
                                  cubit(context).setRegion(element.id);
                                  cubit(context).updateSelectedItems(item);

                                  log("kkk");
                                },
                                count: '${state.selectedItems.where((elem) => elem.id/100==element.id).length}',
                              ),
                              Visibility(
                                  visible:
                                      state.selectedItems.contains(element),
                                  child: LoaderStateWidget(
                                    isFullScreen: false,
                                    loadingState: state.loadState,
                                    child: ListView.separated(
                                      physics: BouncingScrollPhysics(),
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      itemCount: state.allDistricts.length,
                                      itemBuilder: (context, index) {
                                        var element2 = state.allDistricts[index];
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(left: 25),
                                          child: MultiSelectionListItem(
                                            item: element2,
                                            title: element2.name,
                                            isSelected: state.selectedItems
                                                .contains(element2),
                                            onClicked: (dynamic item2) {
                                              log("oo");
                                              log(element.name);
                                              log(element2.name);


                                              cubit(context)
                                                  .updateSelectedItems(item2);

                                             // selectedPaymentTypes.
                                            },
                                          ),
                                        );
                                      },
                                      separatorBuilder:
                                          (BuildContext context, int index) {
                                        return CustomDivider(
                                            height: 2,
                                            startIndent: 20,
                                            endIndent: 20);
                                      },
                                    ),
                                  )),
                            ],
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return CustomDivider(
                              height: 2, startIndent: 20, endIndent: 20);
                        },
                      ),
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
                  context.router.pop(state.selectedItems);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget directions() {
    return Container();
  }
}
