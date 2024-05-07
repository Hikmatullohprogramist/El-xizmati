import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:onlinebozor/core/gen/localization/strings.dart';
import 'package:onlinebozor/domain/mappers/common_mapper_exts.dart';
import 'package:onlinebozor/domain/models/order/user_order_status.dart';
import 'package:onlinebozor/presentation/utils/mask_formatters.dart';

part 'user_order_response.freezed.dart';
part 'user_order_response.g.dart';

@freezed
class UserOrderRootResponse with _$UserOrderRootResponse {
  const factory UserOrderRootResponse({
    dynamic error,
    dynamic message,
    dynamic timestamp,
    int? status,
    dynamic path,
    required Data data,
    dynamic response,
  }) = _UserOrderRootResponse;

  factory UserOrderRootResponse.fromJson(Map<String, dynamic> json) =>
      _$UserOrderRootResponseFromJson(json);
}

@freezed
class Data with _$Data {
  const factory Data({
    Valid? valid,
    int? count,
    required List<UserOrder> results,
  }) = _Data;

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
}

@freezed
class UserOrder with _$UserOrder {
  const factory UserOrder({
    @JsonKey(name: "order_id") required int orderId,
    Seller? seller,
    String? status,
    @JsonKey(name: "final_sum") double? totalSum,
    @JsonKey(name: "created_at") String? createdAt,
    @JsonKey(name: "cancel_note") String? cancelNote,
    List<UserOrderProduct>? products,
  }) = _UserOrder;

  const UserOrder._();

  factory UserOrder.fromJson(Map<String, dynamic> json) =>
      _$UserOrderFromJson(json);

  UserOrderProduct? get firstProduct {
    return products?.firstOrNull;
  }

  String get formattedTotalSum {
    return "${priceMaskFormatter.formatDouble(totalSum ?? 0.0)} ${Strings.currencyUzb}";
  }

  String get formattedPrice {
    return "${priceMaskFormatter.formatDouble(firstProduct?.price?.toDouble() ?? 0.0)} ${Strings.currencyUzb}";
  }

  bool get isCanCancel {
    return ![
      UserOrderStatus.CANCELED,
      UserOrderStatus.SYSCANCELED,
      UserOrderStatus.REJECTED,
      UserOrderStatus.ACCEPTED
    ].contains(orderStatus);
  }

  UserOrderStatus get orderStatus {
    return status.toUserOrderStatus();
  }

  String get mainPhoto {
    return products
            ?.where((e) => e.mainPhoto != null)
            .toList()
            .firstOrNull
            ?.mainPhoto ??
        "";
  }
}

@freezed
class UserOrderProduct with _$UserOrderProduct {
  const factory UserOrderProduct({
    int? id,
    @JsonKey(name: "order_id") int? orderId,
    @JsonKey(name: "amount") int? quantity,
    int? price,
    @JsonKey(name: "total_sum") int? totalSum,
    UserOrderInfo? product,
    @JsonKey(name: "payment_type") UserOrderInfo? paymentType,
    UserOrderInfo? unit,
    UserOrderInfo? shipping,
    UserOrderInfo? delivery,
    String? status,
    @JsonKey(name: "main_photo") String? mainPhoto,
  }) = _UserOrderProduct;

  factory UserOrderProduct.fromJson(Map<String, dynamic> json) =>
      _$UserOrderProductFromJson(json);
}

@freezed
class UserOrderInfo with _$UserOrderInfo {
  const factory UserOrderInfo({
    int? id,
    String? name,
  }) = _UserOrderInfo;

  factory UserOrderInfo.fromJson(Map<String, dynamic> json) =>
      _$UserOrderInfoFromJson(json);
}

@freezed
class Seller with _$Seller {
  const factory Seller({
    int? id,
    String? name,
    int? tin,
    String? photo,
  }) = _Seller;

  factory Seller.fromJson(Map<String, dynamic> json) => _$SellerFromJson(json);
}

@freezed
class Valid with _$Valid {
  const factory Valid() = _Valid;

  factory Valid.fromJson(Map<String, dynamic> json) => _$ValidFromJson(json);
}
