enum OrderCancelReason {
  SELLER_NOT_ANSWERED, // "sellernone": "Ta'minotchi javob bermadi",
  CHANGED_IDEA, // "changedidea": "Fikrim o'zgarib qoldi",
  SELECTED_INCORRECTED_AD, // "selectedother": "Adashib buyurtma beribman",
  OTHER_REASON; // "other":"Boshqa"

  String getRestCode() {
    return switch (this) {
      OrderCancelReason.SELLER_NOT_ANSWERED => "sellernone",
      OrderCancelReason.CHANGED_IDEA => "changedidea",
      OrderCancelReason.SELECTED_INCORRECTED_AD => "selectedother",
      OrderCancelReason.OTHER_REASON => "other",
    };
  }

  static OrderCancelReason? valurOrNull(String? value) {
    if (value == null) return null;

    switch (value) {
      case "sellernone":
        return OrderCancelReason.SELLER_NOT_ANSWERED;
      case "SELLER_NOT_ANSWERED":
        return OrderCancelReason.SELLER_NOT_ANSWERED;

      case "changedidea":
        return OrderCancelReason.CHANGED_IDEA;
      case "CHANGED_IDEA":
        return OrderCancelReason.CHANGED_IDEA;

      case "selectedother":
        return OrderCancelReason.SELECTED_INCORRECTED_AD;
      case "SELECTED_INCORRECTED_AD":
        return OrderCancelReason.SELECTED_INCORRECTED_AD;

      case "other":
        return OrderCancelReason.OTHER_REASON;
      case "OTHER_REASON":
        return OrderCancelReason.OTHER_REASON;
    }

    return null;
  }
}
