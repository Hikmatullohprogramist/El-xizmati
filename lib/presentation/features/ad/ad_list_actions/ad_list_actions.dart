import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/core/colors/color_extension.dart';
import 'package:onlinebozor/core/cubit/base_page.dart';
import 'package:onlinebozor/core/gen/assets/assets.gen.dart';
import 'package:onlinebozor/core/gen/localization/strings.dart';
import 'package:onlinebozor/data/datasource/network/responses/user_ad/user_ad_response.dart';
import 'package:onlinebozor/domain/models/ad/ad_action.dart';
import 'package:onlinebozor/domain/models/ad/user_ad_status.dart';
import 'package:onlinebozor/presentation/widgets/action/action_list_item.dart';
import 'package:onlinebozor/presentation/widgets/bottom_sheet/bottom_sheet_title.dart';

import 'cubit/page_cubit.dart';

@RoutePage()
class AdListActionsPage extends BasePage<PageCubit, PageState, PageEvent> {
  const AdListActionsPage({
    super.key,
    this.userAdResponse,
    this.userAdStatus,
  });

  final UserAdResponse? userAdResponse;
  final UserAdStatus? userAdStatus;

  @override
  void onWidgetCreated(BuildContext context) {
    cubit(context).setInitialParams(userAdResponse, userAdStatus);
  }

  @override
  void onEventEmitted(BuildContext context, PageEvent event) {
    switch (event.type) {
      case PageEventType.closeOnSuccess:
        context.router.pop(null);
    }
  }

  @override
  Widget onWidgetBuild(BuildContext context, PageState state) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.sizeOf(context).height * .35,
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
                SizedBox(height: 10),
                BottomSheetTitle(
                  title: Strings.actionTitle,
                  onCloseClicked: () {
                    context.router.pop(null);
                  },
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 16),
                    Visibility(
                      visible: state.isEditEnabled,
                      child: ActionListItem(
                        item: "",
                        title: Strings.actionEdit,
                        icon: Assets.images.icActionEdit,
                        onClicked: (item) {
                          context.router.pop(AdAction.ACTION_EDIT);
                        },
                      ),
                    ),
                    Visibility(
                      visible: state.isAdvertiseEnabled,
                      child: ActionListItem(
                        item: "",
                        title: Strings.actionAdvertise,
                        icon: Assets.images.icAdvertise,
                        onClicked: (item) {
                          context.router.pop(AdAction.ACTION_ADVERTISE);
                        },
                      ),
                    ),
                    Visibility(
                      visible: state.isActivateEnabled,
                      child: ActionListItem(
                        item: "",
                        title: Strings.actionActivate,
                        icon: Assets.images.icActionActivate,
                        onClicked: (item) {
                          context.router.pop(AdAction.ACTION_ACTIVATE);
                        },
                      ),
                    ),
                    Visibility(
                      visible: state.isDeactivateEnabled,
                      child: ActionListItem(
                        item: "",
                        title: Strings.actionDeactivate,
                        icon: Assets.images.icActionDeactivate,
                        color: Color(0xFFFA6F5D),
                        onClicked: (item) {
                          context.router.pop(AdAction.ACTION_DEACTIVATE);
                        },
                      ),
                    ),
                    Visibility(
                      visible: state.isDeleteEnabled,
                      child: ActionListItem(
                        item: "",
                        title: Strings.actionDelete,
                        icon: Assets.images.icDelete,
                        color: Color(0xFFFA6F5D),
                        onClicked: (item) {
                          context.router.pop(AdAction.ACTION_DELETE);
                        },
                      ),
                    ),
                    SizedBox(height: 16),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
