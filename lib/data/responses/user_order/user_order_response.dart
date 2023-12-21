import 'package:freezed_annotation/freezed_annotation.dart';

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
    required int order_id,
    Seller? seller,
    String? status,
    double? final_sum,
    String? created_at,
    String? cancel_note,
    required List<UserOrderProductResponse> products,
  }) = _UserOrderResponse;

  factory UserOrderResponse.fromJson(Map<String, dynamic> json) =>
      _$UserOrderResponseFromJson(json);
}

@freezed
class UserOrderProductResponse with _$UserOrderProductResponse {
  const factory UserOrderProductResponse({
    int? id,
    int? order_id,
    int? amount,
    int? price,
    int? total_sum,
    Delivery? product,
    Delivery? payment_type,
    Delivery? unit,
    Delivery? shipping,
    Delivery? delivery,
    String? status,
    String? main_photo,
  }) = _UserOrderProductResponse;

  factory UserOrderProductResponse.fromJson(Map<String, dynamic> json) =>
      _$UserOrderProductResponseFromJson(json);
}

@freezed
class Delivery with _$Delivery {
  const factory Delivery({
    int? id,
    String? name,
  }) = _Delivery;

  factory Delivery.fromJson(Map<String, dynamic> json) =>
      _$DeliveryFromJson(json);
}

@freezed
class Seller with _$Seller {
  const factory Seller({
    int? id,
    String? name,
    int? tin,
    dynamic photo,
  }) = _Seller;

  factory Seller.fromJson(Map<String, dynamic> json) => _$SellerFromJson(json);
}

@freezed
class Valid with _$Valid {
  const factory Valid() = _Valid;

  factory Valid.fromJson(Map<String, dynamic> json) => _$ValidFromJson(json);
}
