import 'dart:developer';

import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/widgets/common/multi_selection_list_item_for_adress.dart';

import '../../../common/widgets/common/bottom_sheet_title.dart';
import '../../../common/widgets/common/common_button.dart';
import '../../../common/widgets/common/multi_selection_list_item.dart';
import '../../../common/widgets/dashboard/app_diverder.dart';
import '../../../common/widgets/loading/loader_state_widget.dart';
import '../../../data/responses/region/region_response.dart';
import 'cubit/page_cubit.dart';

@RoutePage()
class SelectionAddressPage extends BasePage<PageCubit, PageState, PageEvent> {
  const SelectionAddressPage({
    super.key,
    this.selectedPaymentTypes,
  });

  final List<RegionResponse>? selectedPaymentTypes;

  @override
  void init(BuildContext context) {
    cubit(context).setInitialSelectedItems(selectedPaymentTypes);
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
                      title: "Yetgazib berish maznili",
                      onCloseClicked: () {
                        context.router.pop();
                      },
                    ),
                    LoaderStateWidget(
                      isFullScreen: false,
                      loadingState: state.itemsLoadState,
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: state.items.length,
                        itemBuilder: (context, index) {
                          var element = state.items[index];
                          return Column(
                            children: [
                              MultiSelectionListItemForAddress(
                                item: element,
                                title: element.name ?? "",
                                isSelected: state.selectedItems.contains(element),
                                onClicked: (dynamic item) {
                                   context.read<SelectionAddressCubit>().
                                   setRegion(element.id);
                                   cubit(context).updateSelectedItems(item);
                                }, count: '${state.selectedItems.length}',

                              ),
                              Visibility(
                                  visible: state.selectedItems.contains(element),
                                   child: LoaderStateWidget(
                                     isFullScreen: false,
                                     loadingState: state.itemsLoadState,
                                     child: ListView.separated(
                                       physics: BouncingScrollPhysics(),
                                       scrollDirection: Axis.vertical,
                                       shrinkWrap: true,
                                       itemCount: state.districts.length,
                                       itemBuilder: (context, index) {
                                         var element = state.districts[index];
                                         return Padding(
                                           padding: const EdgeInsets.only(left: 25),
                                           child: MultiSelectionListItem(
                                             item: element,
                                             title: element.name,
                                             isSelected: state.selectedItems.contains(element),
                                             onClicked: (dynamic item) {
                                               cubit(context).updateSelectedItems(item);
                                             },
                                           ),
                                         );

                                       },
                                       separatorBuilder: (BuildContext context, int index) {
                                         return AppDivider(height: 2, startIndent: 20, endIndent: 20);
                                       },

                                     ),
                                   )
                              )
                            ],
                          );

                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return AppDivider(height: 2, startIndent: 20, endIndent: 20);
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
    );
  }
  Widget directions(){
    return Container();
  }
}
