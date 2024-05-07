import 'package:onlinebozor/domain/models/language/language.dart';
import 'package:onlinebozor/domain/models/order/order_cancel_reason.dart';

extension DistrictIdExts on List<int> {
  List<Map<String, int>> toMapList(String key) {
    return map((id) => {key: id}).toList();
  }
}

extension LanguageExts on Language {
  String getRestCode() {
    return switch (this) {
      Language.uzbekLatin => "la",
      Language.russian => "ru",
      Language.uzbekCyrill => "uz",
    };
  }
}

extension OrderCancelReasonExts on OrderCancelReason {
  String getRestCode() {
    return switch (this) {
      OrderCancelReason.SELLER_NOT_ANSWERED => "sellernone",
      OrderCancelReason.CHANGED_IDEA => "changedidea",
      OrderCancelReason.SELECTED_INCORRECTED_AD => "selectedother",
      OrderCancelReason.OTHER_REASON => "other",
    };
  }
}
