import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';
import 'package:onlinebozor/core/gen/assets/assets.gen.dart';
import 'package:onlinebozor/core/gen/localization/strings.dart';
import 'package:onlinebozor/data/datasource/network/responses/transaction/payment_transaction_response.dart';
import 'package:onlinebozor/domain/models/payment_filter/paymant_filter.dart';
import 'package:onlinebozor/presentation/support/colors/color_extension.dart';
import 'package:onlinebozor/presentation/support/cubit/base_page.dart';
import 'package:onlinebozor/presentation/support/state_message/state_snack_bar_exts.dart';
import 'package:onlinebozor/presentation/widgets/action/selection_list_item.dart';
import 'package:onlinebozor/presentation/widgets/app_bar/default_app_bar.dart';
import 'package:onlinebozor/presentation/widgets/button/custom_elevated_button.dart';
import 'package:onlinebozor/presentation/widgets/divider/custom_diverder.dart';
import 'package:onlinebozor/presentation/widgets/transaction/transaction_widget.dart';

import 'cubit/page_cubit.dart';

@RoutePage()
class PaymentTransactionFilterPage
    extends BasePage<PageCubit, PageState, PageEvent> {
  const PaymentTransactionFilterPage({super.key});

  @override
  Widget onWidgetBuild(BuildContext context, PageState state) {
    return Scaffold(
      backgroundColor: context.backgroundColor,
      appBar: DefaultAppBar(
        titleText: Strings.commonFilter,
        backgroundColor: context.backgroundColor,
        onBackPressed: () => context.router.pop(),
      ),
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 16),
            child: Row(
              children: [
                Flexible(
                    flex: 1,
                    child: InkWell(
                      onTap: () {
                        _showDatePicker(context, state.fromDate).then((value) {
                          cubit(context).fromDate(value);
                        });
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              color: Color(0xFFFAF9FF),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                width: 1,
                                color: Color(0xFFFAF9FF),
                              )),
                          padding: EdgeInsets.symmetric(
                              horizontal: 24, vertical: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              if (state.fromDate.isEmpty)
                                Strings.paymentFilterFromDate
                                    .w(600)
                                    .s(14)
                                    .c(Color(0xFF9EABBE)),
                              if (state.fromDate.isNotEmpty)
                                state.fromDate.w(600).s(14).c(Colors.black),
                              Assets.images.icCalendar
                                  .svg(height: 24, width: 24)
                            ],
                          )),
                    )),
                SizedBox(width: 16),
                Flexible(
                  flex: 1,
                  child: InkWell(
                      onTap: () {
                        _showDatePicker(context, state.toDate).then((value) {
                          cubit(context).toDate(value);
                        });
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              color: Color(0xFFFAF9FF),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                width: 1,
                                color: Color(0xFFFAF9FF),
                              )),
                          padding: EdgeInsets.symmetric(
                              horizontal: 24, vertical: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              if (state.toDate.isEmpty)
                                Strings.paymentFilterToDate
                                    .w(600)
                                    .s(14)
                                    .c(Color(0xFF9EABBE)),
                              if (state.toDate.isNotEmpty)
                                state.toDate.w(600).s(14).c(Colors.black),
                              Assets.images.icCalendar
                                  .svg(height: 24, width: 24)
                            ],
                          ))),
                ),
              ],
            ),
          ),
          InkWell(
              onTap: () async {
                var result =
                    await showResultBottomSheet(context, state.paymentTypes);
                cubit(context).paymentTypes();
                state.paymentTypes[result].isSelected = true;
                cubit(context).setPaymentType(state.paymentTypes[result].name);
              },
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (state.paymentType.isNotEmpty)
                      Strings.paymentFilterPaymentType
                          .w(400)
                          .c(Color(0xFF9EABBE))
                          .s(12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (state.paymentType.isEmpty)
                          Strings.paymentFilterPaymentType
                              .w(400)
                              .c(Colors.black)
                              .s(14),
                        if (state.paymentType.isNotEmpty)
                          state.paymentType.w(400).c(Colors.black).s(14),
                        Spacer(),
                        Strings.paymentFilterAll
                            .w(400)
                            .s(12)
                            .c(Color(0xFF9EABBE)),
                        SizedBox(width: 16),
                        Assets.images.icArrowRight.svg(width: 20, height: 20)
                      ],
                    ),
                  ],
                ),
              )),
          CustomDivider(height: 1),
          InkWell(
              onTap: () async {
                var result =
                    await showResultBottomSheet(context, state.paymentMethods);
                cubit(context).paymentMethods();
                state.paymentMethods[result].isSelected = true;
                cubit(context)
                    .setPaymentMethod(state.paymentMethods[result].name);
              },
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (state.paymentMethod.isNotEmpty)
                      Strings.paymentFilterPaymentMethod
                          .w(400)
                          .c(Color(0xFF9EABBE))
                          .s(12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (state.paymentMethod.isEmpty)
                          Strings.paymentFilterPaymentMethod
                              .w(400)
                              .c(Colors.black)
                              .s(14),
                        if (state.paymentMethod.isNotEmpty)
                          state.paymentMethod.w(400).c(Colors.black).s(14),
                        Spacer(),
                        Strings.paymentFilterAll
                            .w(400)
                            .s(12)
                            .c(Color(0xFF9EABBE)),
                        SizedBox(width: 16),
                        Assets.images.icArrowRight.svg(width: 20, height: 20),
                      ],
                    ),
                  ],
                ),
              )),
          CustomDivider(height: 1),
          InkWell(
              onTap: () async {
                var result = await showResultBottomSheet(
                    context, state.transactionStates);
                cubit(context).transactionStates();
                state.transactionStates[result].isSelected = true;
                cubit(context)
                    .setTransactionStates(state.transactionStates[result].name);
              },
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (state.transactionState.isNotEmpty)
                      Strings.paymentFilterStatus
                          .w(400)
                          .c(Color(0xFF9EABBE))
                          .s(12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (state.transactionState.isEmpty)
                          Strings.paymentFilterStatus
                              .w(400)
                              .c(Colors.black)
                              .s(14),
                        if (state.transactionState.isNotEmpty)
                          state.transactionState.w(400).c(Colors.black).s(14),
                        Spacer(),
                        Strings.paymentFilterAll
                            .w(400)
                            .s(12)
                            .c(Color(0xFF9EABBE)),
                        SizedBox(width: 16),
                        Assets.images.icArrowRight.svg(width: 20, height: 20)
                      ],
                    ),
                  ],
                ),
              )),
          Spacer(),
          Padding(
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 16),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: InkWell(
                    child: SizedBox(
                      child: CustomElevatedButton(
                        text: Strings.commonFilterReset,
                        onPressed: () {
                          cubit(context).clearAllFilter();
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  flex: 1,
                  child: InkWell(
                    child: SizedBox(
                      child: CustomElevatedButton(
                        text: Strings.commonApply,
                        onPressed: () {
                          if (_filterData(context, state).isEmpty) {
                            context.showCustomSnackBar(
                                message: 'Transactions not found');
                          } else {
                            showFilterList(
                                context, _filterData(context, state));
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24)
        ],
      ),
    );
  }

  Future<String> _showDatePicker(BuildContext context, String date) async {
    if (date.isEmpty) {
      date = DateFormat("dd.MM.yyyy").format(DateTime.now());
    }
    var result = await showDatePicker(
      context: context,
      initialDate: DateFormat("dd.MM.yyyy").parseStrict(date),
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.black, // Set your primary color here
            colorScheme: ColorScheme.light(primary: Color(0xFF5C6AC3)),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );
    return DateFormat('dd.MM.yyyy').format(result!);
  }

  Future<int> showResultBottomSheet(
      BuildContext context, List<PaymentFilter> items) async {
    var selectedIndex = 3;
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0),
            // Adjust the radius as needed
            topRight: Radius.circular(10.0), // Adjust the radius as needed
          ),
        ),
        child: ListView.separated(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: items.length,
          itemBuilder: (context, index) {
            var element = items[index];
            return SelectionListItem(
              item: element,
              title: element.name,
              isSelected: element.isSelected,
              onClicked: (dynamic item) async {
                selectedIndex = index;
                context.router.pop(item);
              },
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return CustomDivider(height: 2, startIndent: 20, endIndent: 20);
          },
        ),
      ),
    );
    return selectedIndex;
  }

  void showFilterList(BuildContext context, List<PaymentTransaction> items) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (context) => InkWell(
        onTap: () {
          context.router.pop();
        },
        child: Container(
          height: MediaQuery.of(context).size.height * 0.75,
          padding: EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            color: context.primaryContainer,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0), // Adjust the radius as needed
              topRight: Radius.circular(10.0), // Adjust the radius as needed
            ),
          ),
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: items.length,
            itemBuilder: (context, index) {
              var item = items[index];
              return TransactionWidget(transaction: item);
            },
          ),
        ),
      ),
    );
  }

  List<PaymentTransaction> _filterData(
    BuildContext context,
    PageState state,
  ) {
    var response = state.transactions;

    if (state.paymentType == "Reklama") {
      response = response.where((element) => element.type == "ADS").toList();
    }
    if (state.paymentType == "Hamyon") {
      response = response.where((element) => element.type == "WALLET").toList();
    }

    if (state.paymentMethod == "Hamyon") {
      response =
          response.where((element) => element.pay_method == "WALLET").toList();
    }
    if (state.paymentMethod == "REALPAY") {
      response =
          response.where((element) => element.pay_method == "REALPAY").toList();
    }

    if (state.transactionState == "To'landi") {
      response =
          response.where((element) => element.pay_status == "PAID").toList();
    }
    if (state.transactionState == "To'lanmadi") {
      response = response.where((element) => element.pay_status == "").toList();
    }
    if (state.fromDate.isNotEmpty) {
      response = response
          .where((element) => compareDate(element.pay_date, state.fromDate))
          .toList();
    }
    if (state.toDate.isNotEmpty) {
      response = response
          .where((element) => compareDate(state.toDate, element.pay_date))
          .toList();
    }

    return response;
  }

  bool compareDate(String str1, String str2) {
    DateFormat format = DateFormat("dd.MM.yyyy");
    DateTime date1 = format.parseStrict(str1.substring(0, 10));
    DateTime date2 = format.parseStrict(str2.substring(0, 10));
    if (date1.compareTo(date2) > 0) {
      return true;
    } else {
      return false;
    }
  }
}
