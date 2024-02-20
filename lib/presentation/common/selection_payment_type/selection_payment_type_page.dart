import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/widgets/common/bottom_sheet_title.dart';
import 'package:onlinebozor/common/widgets/common/multi_selection_list_item.dart';
import 'package:onlinebozor/data/responses/payment_type/payment_type_response.dart';
import 'package:onlinebozor/presentation/common/selection_payment_type/cubit/selection_payment_type_cubit.dart';

import '../../../../../common/widgets/loading/loader_state_widget.dart';
import '../../../common/gen/localization/strings.dart';
import '../../../common/widgets/common/common_button.dart';
import '../../../common/widgets/dashboard/app_diverder.dart';

@RoutePage()
class SelectionPaymentTypePage extends BasePage<SelectionPaymentTypeCubit,
    SelectionPaymentTypeBuildable, SelectionPaymentTypeListenable> {
  const SelectionPaymentTypePage({
    super.key,
    this.selectedPaymentTypes,
  });

  final List<PaymentTypeResponse>? selectedPaymentTypes;

  @override
  void init(BuildContext context) {
    cubit(context).setInitialSelectedPaymentTypes(selectedPaymentTypes);
  }

  @override
  Widget builder(BuildContext context, SelectionPaymentTypeBuildable state) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.sizeOf(context).height * .4,
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
                  title: "Выберите типы оплаты",
                  onCloseClicked: () {
                    context.router.pop();
                  },
                ),
                LoaderStateWidget(
                  isFullScreen: false,
                  loadingState: state.paymentTypesState,
                  child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: state.paymentTypes.length,
                    itemBuilder: (context, index) {
                      var element = state.paymentTypes[index];
                      return MultiSelectionListItem(
                        item: element,
                        title: element.name ?? "",
                        isSelected:
                            state.selectedPaymentTypes.contains(element),
                        onClicked: (dynamic item) {
                          cubit(context).updateSelectedPaymentTypes(item);
                        },
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return AppDivider(height: 2, indent: 20, endIndent: 20);
                    },
                  ),
                ),
                SizedBox(height: 16),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: CommonButton(
                    color: context.colors.buttonPrimary,
                    onPressed: () {
                      context.router.pop(state.selectedPaymentTypes);
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
        ),
      ),
    );
  }
}
