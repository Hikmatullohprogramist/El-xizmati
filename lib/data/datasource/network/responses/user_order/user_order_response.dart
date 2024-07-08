import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:onlinebozor/core/gen/localization/strings.dart';
import 'package:onlinebozor/domain/mappers/common_mapper_exts.dart';
import 'package:onlinebozor/domain/models/order/user_order_status.dart';
import 'package:onlinebozor/presentation/support/extensions/mask_formatters.dart';

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
    required List<UserOrderResponse> results,
  }) = _Data;

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
}

@freezed
class UserOrderResponse with _$UserOrderResponse {
  const factory UserOrderResponse({
    @JsonKey(name: "order_id") required int orderId,
    UserOrderSellerResponse? seller,
    String? status,
    @JsonKey(name: "final_sum") double? totalSum,
    @JsonKey(name: "created_at") String? createdAt,
    @JsonKey(name: "cancel_note") String? cancelNote,
    List<UserOrderProductResponse>? products,
  }) = _UserOrderResponse;

  const UserOrderResponse._();

  factory UserOrderResponse.fromJson(Map<String, dynamic> json) =>
      _$UserOrderResponseFromJson(json);

  UserOrderProductResponse? get firstProduct {
    return products?.firstOrNull;
  }

  UserOrderInfoResponse? get firstInfo {
    return products?.firstOrNull?.product;
  }

  String get formattedTotalSum {
    return "${priceMaskFormatter.formatDouble(totalSum ?? 0.0)} ${Strings.currencyUzs}";
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
class UserOrderProductResponse with _$UserOrderProductResponse {
  const factory UserOrderProductResponse({
    int? id,
    @JsonKey(name: "order_id") int? orderId,
    @JsonKey(name: "amount") int? quantity,
    int? price,
    @JsonKey(name: "total_sum") int? totalSum,
    UserOrderInfoResponse? product,
    @JsonKey(name: "payment_type") UserOrderInfoResponse? paymentType,
    UserOrderInfoResponse? unit,
    UserOrderInfoResponse? shipping,
    UserOrderInfoResponse? delivery,
    String? status,
    @JsonKey(name: "main_photo") String? mainPhoto,
  }) = _UserOrderProductResponse;

  factory UserOrderProductResponse.fromJson(Map<String, dynamic> json) =>
      _$UserOrderProductResponseFromJson(json);
}

@freezed
class UserOrderInfoResponse with _$UserOrderInfoResponse {
  const factory UserOrderInfoResponse({
    int? id,
    String? name,
  }) = _UserOrderInfoResponse;

  factory UserOrderInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$UserOrderInfoResponseFromJson(json);
}

@freezed
class UserOrderSellerResponse with _$UserOrderSellerResponse {
  const factory UserOrderSellerResponse({
    int? id,
    String? name,
    int? tin,
    String? image,
  }) = _UserOrderSellerResponse;

  factory UserOrderSellerResponse.fromJson(Map<String, dynamic> json) => _$UserOrderSellerResponseFromJson(json);
}

@freezed
class Valid with _$Valid {
  const factory Valid() = _Valid;

  factory Valid.fromJson(Map<String, dynamic> json) => _$ValidFromJson(json);
}
