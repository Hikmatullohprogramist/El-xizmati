import 'package:onlinebozor/core/extensions/list_extensions.dart';
import 'package:onlinebozor/core/gen/localization/strings.dart';
import 'package:onlinebozor/domain/models/order/user_order_product.dart';
import 'package:onlinebozor/domain/models/order/user_order_status.dart';
import 'package:onlinebozor/domain/models/seller/seller.dart';
import 'package:onlinebozor/presentation/support/extensions/mask_formatters.dart';

class UserOrder {
  int orderId;
  Seller? seller;
  UserOrderStatus status;
  double totalSum;
  String createdAt;
  String? cancelNote;
  List<UserOrderProduct> products;

  UserOrder({
    required this.orderId,
    this.seller,
    required this.status,
    required this.totalSum,
    required this.createdAt,
    this.cancelNote,
    required this.products,
  });

  UserOrder updateState(UserOrderStatus status, String? cancelNote) {
    return this
      ..status = status
      ..cancelNote = cancelNote;
  }

  UserOrderProduct? get firstProduct {
    return products.firstOrNull;
  }

  String get firstProductName {
    return products.firstOrNull?.productName ?? "";
  }

  String get formattedTotalSum {
    return "${priceMaskFormatter.formatDouble(totalSum)} ${Strings.currencyUzs}";
  }

  String get formattedPrice {
    return "${priceMaskFormatter.formatDouble(firstProduct?.price?.toDouble() ?? 0.0)} ${Strings.currencyUzs}";
  }

  bool get isCanCancel {
    return ![
      UserOrderStatus.CANCELED,
      UserOrderStatus.SYS_CANCELED,
      UserOrderStatus.REJECTED,
      UserOrderStatus.ACCEPTED
    ].contains(status);
  }

  bool get isCancelled {
    return [
      UserOrderStatus.CANCELED,
      UserOrderStatus.SYS_CANCELED,
      UserOrderStatus.REJECTED,
      UserOrderStatus.ACCEPTED
    ].contains(status);
  }

  bool get hasCancelNote {
    return isCancelled && cancelNote?.trim().isNotEmpty == true;
  }

  get mainPhoto =>
      products.firstIf((e) => e.mainPhoto != null)?.mainPhoto ?? "";
}
