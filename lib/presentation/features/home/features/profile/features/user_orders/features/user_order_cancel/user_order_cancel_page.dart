import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onlinebozor/core/gen/localization/strings.dart';
import 'package:onlinebozor/domain/models/order/order_type.dart';
import 'package:onlinebozor/domain/models/order/user_order.dart';
import 'package:onlinebozor/presentation/support/cubit/base_page.dart';
import 'package:onlinebozor/presentation/support/extensions/color_extension.dart';
import 'package:onlinebozor/presentation/support/extensions/controller_exts.dart';
import 'package:onlinebozor/presentation/support/extensions/platform_sizes.dart';
import 'package:onlinebozor/presentation/support/extensions/resource_exts.dart';
import 'package:onlinebozor/presentation/widgets/action/selection_list_item.dart';
import 'package:onlinebozor/presentation/widgets/bottom_sheet/bottom_sheet_title.dart';
import 'package:onlinebozor/presentation/widgets/button/custom_elevated_button.dart';
import 'package:onlinebozor/presentation/widgets/form_field/custom_text_form_field.dart';
import 'package:onlinebozor/presentation/widgets/form_field/label_text_field.dart';
import 'package:onlinebozor/presentation/widgets/form_field/validator/default_validator.dart';

import 'user_order_cancel_cubit.dart';

@RoutePage()
class UserOrderCancelPage extends BasePage<UserOrderCancelCubit,
    UserOrderCancelState, UserOrderCancelEvent> {
  final OrderType orderType;
  final UserOrder order;

  UserOrderCancelPage({
    super.key,
    required this.orderType,
    required this.order,
  });

  final TextEditingController commentController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void onWidgetCreated(BuildContext context) {
    cubit(context).setInitialParams(orderType, order);
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

    return WillPopScope(
      onWillPop: () async {
        context.router.pop(state.userOrder!);
        return true;
      },
      child: Material(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              color: context.bottomSheetColor,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Form(
                  key: _formKey,
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
                          padding: const EdgeInsets.symmetric(horizontal: 16),
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
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: CustomTextFormField(
                            autofillHints: const [AutofillHints.name],
                            inputType: TextInputType.name,
                            keyboardType: TextInputType.name,
                            maxLines: 3,
                            minLines: 2,
                            hint: Strings.commonComment,
                            textInputAction: TextInputAction.next,
                            controller: commentController,
                            validator: (v) => NotEmptyValidator.validate(v),
                            onChanged: (value) {
                              cubit(context).setEnteredComment(value);
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(16, 8, 16, 0),
                        child: CustomElevatedButton(
                          text: Strings.commonCancel,
                          onPressed: () {
                            HapticFeedback.lightImpact();
                            if (_formKey.currentState!.validate()) {
                              cubit(context).cancelOrder();
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height:
                            state.isCommentEnabled ? 360 : defaultBottomPadding,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ListView _buildReasonsItems(
    BuildContext context,
    UserOrderCancelState state,
  ) {
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
