import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/presentation/support/extensions/color_extension.dart';
import 'package:onlinebozor/presentation/support/extensions/controller_exts.dart';
import 'package:onlinebozor/presentation/support/cubit/base_page.dart';
import 'package:onlinebozor/core/gen/localization/strings.dart';
import 'package:onlinebozor/data/datasource/network/responses/user_order/user_order_response.dart';
import 'package:onlinebozor/presentation/support/extensions/resource_exts.dart';
import 'package:onlinebozor/presentation/widgets/action/selection_list_item.dart';
import 'package:onlinebozor/presentation/widgets/bottom_sheet/bottom_sheet_title.dart';
import 'package:onlinebozor/presentation/widgets/button/custom_elevated_button.dart';
import 'package:onlinebozor/presentation/widgets/form_field/custom_text_form_field.dart';
import 'package:onlinebozor/presentation/widgets/form_field/label_text_field.dart';

import 'user_order_cancel_cubit.dart';

@RoutePage()
class UserOrderCancelPage extends BasePage<UserOrderCancelCubit,
    UserOrderCancelState, UserOrderCancelEvent> {
  final UserOrder order;

  UserOrderCancelPage({
    super.key,
    required this.order,
  });

  final TextEditingController commentController = TextEditingController();

  @override
  void onWidgetCreated(BuildContext context) {
    cubit(context).setInitialParams(order);
  }

  @override
  void onEventEmitted(BuildContext context, UserOrderCancelEvent event) {
    switch (event.type) {
      case UserOrderCancelEventType.onBackAfterCancel:
        context.router.pop(cubit(context).states.userOrder!);
    }
  }

  @override
  Widget onWidgetBuild(BuildContext context, UserOrderCancelState state) {
    commentController.updateOnRestore(state.cancelComment);

    return SizedBox(
      width: double.infinity,
      // height: MediaQuery.sizeOf(context).height * .9,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
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
                      title: Strings.orderCancellationTitle,
                      onCloseClicked: () {
                        context.router.pop();
                      },
                    ),
                    _buildReasonsItems(context, state),
                    Visibility(
                      visible: state.isCommentEnabled,
                      child: SizedBox(height: 8),
                    ),
                    Visibility(
                      visible: state.isCommentEnabled,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: LabelTextField(
                          Strings.commonComment,
                          isRequired: true,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: state.isCommentEnabled,
                      child: SizedBox(height: 8),
                    ),
                    Visibility(
                      visible: state.isCommentEnabled,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: CustomTextFormField(
                          autofillHints: const [AutofillHints.name],
                          inputType: TextInputType.name,
                          keyboardType: TextInputType.name,
                          maxLines: 5,
                          minLines: 3,
                          hint: Strings.commonComment,
                          textInputAction: TextInputAction.next,
                          controller: commentController,
                          onChanged: (value) {
                            cubit(context).setEnteredComment(value);
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 32),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: CustomElevatedButton(
                        text: Strings.commonCancel,
                        onPressed: () {
                          cubit(context).cancelOrder();
                        },
                      ),
                    ),
                    SizedBox(height: 32),
                  ],
                ),
              ),
            ),
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 16),
            //   child: CustomElevatedButton(
            //     text: Strings.commonCancel,
            //     onPressed: () {
            //       cubit(context).cancelOrder();
            //     },
            //   ),
            // ),
            // SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  ListView _buildReasonsItems(BuildContext context, UserOrderCancelState state) {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: state.reasons.length,
      // padding: EdgeInsets.only(left: 10, right: 16),
      itemBuilder: (context, index) {
        var item = state.reasons[index];
        return SelectionListItem(
          item: item,
          title: item.getLocalizedName(),
          isSelected: item == state.selectedReason,
          onClicked: (item) {
            cubit(context).setSelectedReason(item);
          },
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(width: 10);
      },
    );
  }
}
