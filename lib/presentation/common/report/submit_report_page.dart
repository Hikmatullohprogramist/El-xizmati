import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/controller/controller_exts.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/common/gen/localization/strings.dart';
import 'package:onlinebozor/common/widgets/action/selection_list_item.dart';
import 'package:onlinebozor/common/widgets/bottom_sheet/bottom_sheet_title.dart';
import 'package:onlinebozor/common/widgets/button/custom_elevated_button.dart';
import 'package:onlinebozor/common/widgets/form_field/custom_text_form_field.dart';
import 'package:onlinebozor/common/widgets/form_field/label_text_field.dart';
import 'package:onlinebozor/domain/models/report/report_type.dart';
import 'package:onlinebozor/presentation/utils/resource_exts.dart';

import '../../common/report/cubit/page_cubit.dart';

@RoutePage()
class SubmitReportPage extends BasePage<PageCubit, PageState, PageEvent> {
  SubmitReportPage(this.id, this.reportType, {super.key});

  final int id;
  final ReportType reportType;

  final TextEditingController commentController = TextEditingController();

  @override
  void onWidgetCreated(BuildContext context) {
    cubit(context).setInitialParams(id, reportType);
  }

  @override
  void onEventEmitted(BuildContext context, PageEvent event) {
    switch (event.type) {
      case PageEventType.onBackAfterCancel:
        context.router.pop();
    }
  }

  @override
  Widget onWidgetBuild(BuildContext context, PageState state) {
    commentController.updateOnRestore(state.reportComment);

    return SizedBox(
      width: double.infinity,
      // height: MediaQuery.sizeOf(context).height * .5,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              color: context.primaryContainer,
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
            // Padding(
            //   padding: EdgeInsets.only(left: 16, right: 16, bottom: 32),
            //   child: CustomElevatedButton(
            //     text: reportType.getLocalizedAction(),
            //     onPressed: () {
            //       cubit(context).submitReport();
            //     },
            //   ),
            // ),
            // SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  ListView _buildReasonsItems(BuildContext context, PageState state) {
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
