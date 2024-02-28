import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/common/widgets/common/bottom_sheet_title.dart';
import 'package:onlinebozor/common/widgets/common/selection_list_item.dart';
import 'package:onlinebozor/data/responses/unit/unit_response.dart';
import 'package:onlinebozor/presentation/common/selection_unit/cubit/page_cubit.dart';

import '../../../../../common/widgets/loading/loader_state_widget.dart';
import '../../../common/widgets/dashboard/app_diverder.dart';

@RoutePage()
class SelectionUnitPage extends BasePage<PageCubit, PageState, PageEvent> {
  const SelectionUnitPage({
    super.key,
    this.selectedUnit,
  });

  final UnitResponse? selectedUnit;

  @override
  Widget onWidgetBuild(BuildContext context, PageState state) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.sizeOf(context).height * .7,
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
                  title: "Выберите тип",
                  onCloseClicked: () {
                    context.router.pop();
                  },
                ),
                LoaderStateWidget(
                  isFullScreen: false,
                  loadingState: state.loadState,
                  onErrorToAgainRequest: () {
                    cubit(context).getItems();
                  },
                  child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: state.items.length,
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
                      return AppDivider(
                          height: 2, startIndent: 20, endIndent: 20);
                    },
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
