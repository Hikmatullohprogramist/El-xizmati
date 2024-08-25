import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:El_xizmati/core/enum/enums.dart';
import 'package:El_xizmati/data/datasource/network/responses/ad/ad_detail/ad_detail_response.dart';
import 'package:El_xizmati/data/repositories/cart_repository.dart';
import 'package:El_xizmati/data/repositories/state_repository.dart';
import 'package:El_xizmati/data/repositories/user_order_repository.dart';
import 'package:El_xizmati/domain/models/ad/ad_detail.dart';
import 'package:El_xizmati/domain/models/ad/installments/sm_installments_model.dart';
import 'package:El_xizmati/presentation/support/cubit/base_cubit.dart';

part 'installment_info_cubit.freezed.dart';
part 'installment_info_state.dart';

@Injectable()
class InstallmentInfoCubit
    extends BaseCubit<InstallmentInfoState, InstallmentInfoEvent> {
  InstallmentInfoCubit(
      this.userOrderRepository, this.stateRepository, this.repository)
      : super(InstallmentInfoState());

  final CartRepository repository;
  final UserOrderRepository userOrderRepository;
  final StateRepository stateRepository;

  void setInitialParams(AdDetail detail) async {
    if ((detail.paymentTypes ?? []).isEmpty) {
      updateState((state) => state.copyWith(
            emptyPlanPaymentState: LoadingState.loading,
            enableStartPrice: false,
          ));
    //   try {
    //     final res = await userOrderRepository.calculateSmInstallments(
    //         productId: detail.adId);
    //     if (res.isNotEmpty) {
    //       updateState((state) => state.copyWith(
    //           productDetail: detail,
    //           productCount: 1,
    //           // should be min_amount
    //           planPayments: res.map((e) => e.toMap()).toList(),
    //           constPlanPayments: res.map((e) => e.toMap()).toList(),
    //           emptyPlanPaymentState: LoadingState.success));
    //       selectedItemMonth(0);
    //       startDate();
    //     }
    //   } on DioException catch (e, stackTrace) {
    //     updateState((state) => state.copyWith(
    //         emptyPlanPaymentState: LoadingState.error,
    //         enableStartPrice: false));
    //   }
    // } else {
    //   final planPayments =
    //       states.planPayments.map((e) => e.toMap(isSelected: false)).toList();
    //   updateState((state) => state.copyWith(
    //       emptyPlanPaymentState: LoadingState.success,
    //       productDetail: detail,
    //       productCount: states.productCount ?? 1,
    //       planPayments: planPayments,
    //       constPlanPayments: planPayments));
    //   selectedItemMonth(0);
    //   startDate();
    }
  }

  Future<void> orderCreate() async {
    final pId = states.currentSelectionMonth?.productId ?? 1;
    final productID = pId == 2 ? (states.productDetail?.adId) : pId;

    // try {
    //   final isLogin = stateRepository.isAuthorized() ?? false;
    //   if (isLogin) {
    //     updateState((state) => state.copyWith(orderCreationState: true));
    //     final product = CreateInstallmentOrder(
    //         amount: states.productCount,
    //         begin_price: states.selectionItemStartPrice != 0
    //             ? states.selectionItemStartPrice.toString()
    //             : "0",
    //         num: 1,
    //         plan_payment_date:
    //             DateFormat('yyyy-MM-dd').format(states.startDay!),
    //         plan_payment_id: states.currentSelectionMonth?.id ?? 1,
    //         product_id: productID ?? 0);
    //     final res = await repository.installmentOrderCreate(
    //         products: [product], tin: states.productDetail?.seller?.tin ?? 0);
    //     await Future.delayed(Duration(seconds: 2));
    //     if (res.statusCode == 200) {
    //       emitEvent(InstallmentInfoEvent(
    //           InstallmentInfoEventEventType.onOpenAfterCreation));
    //     }
    //   } else {
    //     emitEvent(InstallmentInfoEvent(
    //         InstallmentInfoEventEventType.onOpenAuthStart));
    //   }
    // } catch (e) {
    //   emitEvent(InstallmentInfoEvent(InstallmentInfoEventEventType.onFailure));
    //   updateState((state) => state.copyWith(orderCreationState: false));
    // } finally {
    //   updateState((state) => state.copyWith(orderCreationState: false));
    // }
  }

  void increaseProductCount() {
    // if ((states.productCount ?? 0) > (states.productCount)) {
    //   updateState((state) => state.copyWith(
    //         productCount: states.productCount + 1,
    //       ));
    //
    //   selectedItemMonth(states.selectionItem);
    // }
  }

  void decreaseProductCount() {
    // if ((states.productCount) > 1) { // should be min_amount
    //   updateState(
    //       (state) => state.copyWith(productCount: states.productCount - 1));
    //   selectedItemMonth(states.selectionItem);
    // }
  }

  selectedItemMonth(int index) {
    final planPayments = [
      for (int i = 0; i < states.constPlanPayments.length; i++)
        if (i == index)
          states.constPlanPayments[i]..isSelected = true
        else
          states.constPlanPayments[i]..isSelected = false
    ];
    final copyList = planPayments.map((e) => e.copy()).toList();
    var f = NumberFormat('###,000');
    var summa = "";
    if (copyList[index].startingPrice != 0) {
      summa = f.format(copyList[index].startingPrice).replaceAll(",", " ");
    } else {
      summa = "${0}";
    }

    updateState(
      (state) => state.copyWith(
        planPayments: copyList,
        currentSelectionMonth: copyList[index],
        constCurrentSelectionMonth: copyList[index],
        startPrice: summa,
        selectionItem: index,
        enableStartPrice: true,
      ),
    );

    final startPrice =
        (states.constCurrentSelectionMonth?.contsStartingPrice ?? 0) *
            states.productCount;

    final selectItem = copyList[index];
    final overallSumma = states.productCount * selectItem.totalPrice -
        startPrice * (1 + selectItem.overtimePercentage / 100);

    updateState((state) => state.copyWith(
        selectionItemStartPrice: startPrice, overallSumma: overallSumma));
  }

  String formattedStartPrice() {
    var res = "";
    var f = NumberFormat('###,000');
    //final summa=(states.constCurrentSelectionMonth?.startingPrice??0)*states.productCount;
    final summa = states.selectionItemStartPrice;
    if (summa == 0) {
      res = "";
    } else {
      if (summa < 999) {
        res = summa.toString();
      } else {
        res = f.format(summa).replaceAll(",", " ");
      }
    }
    return res;
  }

  void checkStartPrice(String price) {
    var str = price
        .trim()
        .toString()
        .replaceAll(RegExp('[^0-9]'), ',')
        .replaceAll(',', "");
    final c = states.productCount;
    final summa = int.tryParse(str) ?? 0;
    final totalPrice = (states.currentSelectionMonth?.totalPrice ?? 1);
    final percentAllSumma = summa *
        (1 + (states.currentSelectionMonth?.overtimePercentage ?? 0) / 100) /
        c;
    final overallSumma = (totalPrice - percentAllSumma) * states.productCount;
    final checkAllPrice = overallSumma > 0 ? overallSumma : 0;
    final monthlyPrice = (totalPrice - percentAllSumma) /
        ((states.currentSelectionMonth?.monthId ?? 1));
    final checkOverSumma = monthlyPrice > 0 ? monthlyPrice : 0;
    final calculateSumma =
        (states.constCurrentSelectionMonth?.contsStartingPrice ?? 1) *
            states.productCount;

    var myList = states.planPayments.map((e) => e.copy()).toList();
    myList[states.selectionItem].monthlyPrice = checkOverSumma;
    updateState((state) => state.copyWith(
        overallSumma: checkAllPrice,
        planPayments: myList,
        constCurrentSelectionMonth: states.currentSelectionMonth
          ?..startingPrice = summa,
        selectionItemStartPrice: summa));

    if ((calculateSumma) <= summa) {
      updateState((state) => state.copyWith(enableStartPrice: true));
    } else {
      updateState((state) => state.copyWith(enableStartPrice: false));
    }
  }

  void startDate() {
    DateTime now = DateTime.now();
    final selectDay = DateTime.utc(now.year, now.month + 1, 1);
    String formattedDate = DateFormat('dd.MM.yyyy').format(selectDay);
    updateState((state) =>
        state.copyWith(startDay: selectDay, startDate: formattedDate));
  }

  void setDate(DateTime selectDay) {
    String formattedDate = DateFormat('dd.MM.yyyy').format(selectDay);
    updateState((state) =>
        state.copyWith(startDate: formattedDate, startDay: selectDay));
  }
}