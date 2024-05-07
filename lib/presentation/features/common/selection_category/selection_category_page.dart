import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/presentation/support/colors/color_extension.dart';
import 'package:onlinebozor/presentation/support/cubit/base_page.dart';
import 'package:onlinebozor/data/datasource/network/responses/category/category/category_response.dart';
import 'package:onlinebozor/presentation/widgets/action/selection_list_item.dart';
import 'package:onlinebozor/presentation/widgets/bottom_sheet/bottom_sheet_title.dart';
import 'package:onlinebozor/presentation/widgets/divider/custom_diverder.dart';

import '../../../../../presentation/widgets/loading/loader_state_widget.dart';
import 'cubit/page_cubit.dart';

@RoutePage()
class SelectionCategoryPage extends BasePage<PageCubit, PageState, PageEvent> {
  const SelectionCategoryPage({
    super.key,
    this.initialSelectedItem,
  });

  final CategoryResponse? initialSelectedItem;

  @override
  Widget onWidgetBuild(BuildContext context, PageState state) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.sizeOf(context).height * .8,
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
                  title: "Выберите категорию",
                  onCloseClicked: () {
                    context.router.pop();
                  },
                ),
                LoaderStateWidget(
                  isFullScreen: false,
                  loadingState: state.loadState,
                  onRetryClicked: () {
                    cubit(context).getItems();
                  },
                  successBody: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: state.items.length,
                    itemBuilder: (context, index) {
                      var element = state.items[index];
                      return SelectionListItem(
                        item: element,
                        title: element.label ?? "",
                        isSelected: initialSelectedItem?.id == element.id,
                        onClicked: (dynamic item) {
                          context.router.pop(item);
                        },
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return CustomDivider(startIndent: 20, endIndent: 20);
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
