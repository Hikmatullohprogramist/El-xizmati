import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/core/gen/localization/strings.dart';
import 'package:onlinebozor/domain/models/report/report_type.dart';
import 'package:onlinebozor/presentation/support/cubit/base_page.dart';
import 'package:onlinebozor/presentation/support/extensions/color_extension.dart';
import 'package:onlinebozor/presentation/support/extensions/controller_exts.dart';
import 'package:onlinebozor/presentation/support/extensions/resource_exts.dart';
import 'package:onlinebozor/presentation/widgets/action/selection_list_item.dart';
import 'package:onlinebozor/presentation/widgets/bottom_sheet/bottom_sheet_title.dart';
import 'package:onlinebozor/presentation/widgets/button/custom_elevated_button.dart';
import 'package:onlinebozor/presentation/widgets/form_field/custom_text_form_field.dart';
import 'package:onlinebozor/presentation/widgets/form_field/label_text_field.dart';

import 'submit_report_cubit.dart';

@RoutePage()
class SubmitReportPage
    extends BasePage<SubmitReportCubit, SubmitReportState, SubmitReportEvent> {
  final int id;
  final ReportType reportType;

  SubmitReportPage(this.id, this.reportType, {super.key});

  final TextEditingController commentController = TextEditingController();

  @override
  void onWidgetCreated(BuildContext context) {
    cubit(context).setInitialParams(id, reportType);
  }

  @override
  void onEventEmitted(BuildContext context, SubmitReportEvent event) {
    switch (event.type) {
      case SubmitReportEventType.onClose:
        context.router.pop();
    }
  }

  @override
  Widget onWidgetBuild(BuildContext context, SubmitReportState state) {
    commentController.updateOnRestore(state.reportComment);

    return Material(
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              color: context.cardColor,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    BottomSheetTitle(
                      title: reportType.getLocalizedPageTitle(),
                      onCloseClicked: () {
                        context.router.pop();
                      },
                    ),
                    _buildReasonsItems(context, state),
                    SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: LabelTextField(
                        Strings.commonComment,
                        isRequired: state.isCommentEnabled,
                      ),
                    ),
                    SizedBox(height: 8),
                    Padding(
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
                    SizedBox(height: 32),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: CustomElevatedButton(
                        text: reportType.getLocalizedAction(),
                        onPressed: () {
                          cubit(context).submitReport();
                        },
                      ),
                    ),
                    SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ListView _buildReasonsItems(BuildContext context, SubmitReportState state) {
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
