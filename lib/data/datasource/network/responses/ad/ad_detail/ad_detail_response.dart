import 'package:freezed_annotation/freezed_annotation.dart';

part 'ad_detail_response.freezed.dart';
part 'ad_detail_response.g.dart';

@freezed
class AdDetailRootResponse with _$AdDetailRootResponse {
  const factory AdDetailRootResponse({
    dynamic error,
    dynamic message,
    dynamic timestamp,
    int? status,
    dynamic path,
    required Data data,
    dynamic response,
  }) = _AdDetailRootResponse;

  factory AdDetailRootResponse.fromJson(Map<String, dynamic> json) =>
      _$AdDetailRootResponseFromJson(json);
}

@freezed
class Data with _$Data {
  const factory Data({
    required AdDetailResponse results,
  }) = _Data;

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
}

@freezed
class AdDetailResponse with _$AdDetailResponse {
  const factory AdDetailResponse({
//
    @JsonKey(name: "id") required int id,
    @JsonKey(name: "name") String? name,
    @JsonKey(name: "description") String? description,
    @JsonKey(name: "category") AdDetailCategory? category,
    @JsonKey(name: "category_id") int? categoryId,
    @JsonKey(name: "photos") List<AdDetailPhoto>? photos,
    @JsonKey(name: "video") String? videoUrl,
    @JsonKey(name: "has_installment") bool? hasInstallment,
//
    @JsonKey(name: "type_status") String? adType,
    @JsonKey(name: "sale_type") String? saleType,
    @JsonKey(name: "main_type_status") String? adTransactionType,
    @JsonKey(name: "property_status") String? adItemCondition,
    @JsonKey(name: "type") String? adPriorityLevel,
//
    @JsonKey(name: "price") int? price,
    @JsonKey(name: "to_price") int? toPrice,
    @JsonKey(name: "from_price") int? fromPrice,
    @JsonKey(name: "currency") String? currency,
    @JsonKey(name: "payment_types") List<AdDetailResponseItem>? paymentTypes,
    @JsonKey(name: "is_contract") bool? isContract,
    @JsonKey(name: "price_range") AdDetailPriceComparison? priceComparison,
//
    @JsonKey(name: "installments") AdDetailInstallmentInfo? installmentInfo,
    @JsonKey(name: "plan_payments") List<AdDetailInstallmentPlan>? paymentPlans,
//
    @JsonKey(name: "region") AdDetailResponseItem? region,
    @JsonKey(name: "district") AdDetailResponseItem? district,
//
    @JsonKey(name: "seller") AdDetailSellerResponse? seller,
    @JsonKey(name: "tin") int? tin,
    @JsonKey(name: "email") String? email,
    @JsonKey(name: "phone_number") String? phoneNumber,
    @JsonKey(name: "route_type") String? adAuthorType,
    @JsonKey(name: "address_id") int? addressId,
    @JsonKey(name: "address") AdDetailAddressResponse? address,
//
    @JsonKey(name: "is_autoRenew") bool? isAutoRenew,
    @JsonKey(name: "showSocial") bool? isShowSocial,
//
    @JsonKey(name: "begin_date") String? beginDate,
    @JsonKey(name: "end_date") String? endDate,
    @JsonKey(name: "created_at") String? createdAt,
//
    @JsonKey(name: "other_name") String? otherAdName,
    @JsonKey(name: "other_category") AdDetailResponseItem? otherAdCategory,
    @JsonKey(name: "other_description") String? otherAdDescription,
    @JsonKey(name: "other_route_type") String? otherAdAuthorType,
    @JsonKey(name: "other_property_status") String? otherAdItemCondition,
//
    @JsonKey(name: "has_free_shipping") bool? hasFreeShipping,
    @JsonKey(name: "has_shipping") bool? hasShipping,
    @JsonKey(name: "has_warehouse") bool? hasWarehouse,
    @JsonKey(name: "shipping_price") int? shippingPrice,
    @JsonKey(name: "shipping_unitId") int? shippingUnitId,
//
    @JsonKey(name: "view") int? viewedCount,
    @JsonKey(name: "selected") int? favoritesCount,
    @JsonKey(name: "phone_view") int? phoneNumberViewedCount,
    @JsonKey(name: "message_number") int? smsNumberViewedCount,
//
    @JsonKey(name: "type_expire_date") dynamic typeExpireDate,
    @JsonKey(name: "unit_id") int? unitId,
//
    // @JsonKey(name: "params") List<dynamic>? params,
    // @JsonKey(name: "social_medias") List<dynamic>? social_medias,
    // @JsonKey(name: "warehouses") List<dynamic>? warehouses,
    // @JsonKey(name: "shippings") List<dynamic>? shippings,
//
  }) = _AdDetailResponse;

  factory AdDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$AdDetailResponseFromJson(json);
}

@freezed
class AdDetailAddressResponse with _$AdDetailAddressResponse {
  const factory AdDetailAddressResponse({
    int? id,
    AdDetailResponseItem? region,
    AdDetailResponseItem? district,
    String? name,
    AdDetailResponseItem? mahalla,
    dynamic home_num,
    dynamic street_num,
    AdDetailResponseItem? floor,
    dynamic apartment_num,
    String? geo,
  }) = _AdDetailAddressResponse;

  factory AdDetailAddressResponse.fromJson(Map<String, dynamic> json) =>
      _$AdDetailAddressResponseFromJson(json);
}

@freezed
class AdDetailResponseItem with _$AdDetailResponseItem {
  const factory AdDetailResponseItem({
    int? id,
    String? name,
  }) = _AdDetailResponseItem;

  factory AdDetailResponseItem.fromJson(Map<String, dynamic> json) =>
      _$AdDetailResponseItemFromJson(json);
}

@freezed
class AdDetailPriceComparison with _$AdDetailPriceComparison {
  const factory AdDetailPriceComparison({
    @JsonKey(name: "max_price") required double maxPrice,
    @JsonKey(name: "min_price") required double minPrice,
  }) = _AdDetailPriceComparison;

  factory AdDetailPriceComparison.fromJson(Map<String, dynamic> json) =>
      _$AdDetailPriceComparisonFromJson(json);
}

@freezed
class AdDetailInstallmentInfo with _$AdDetailInstallmentInfo {
  const factory AdDetailInstallmentInfo({
    @JsonKey(name: "month_id") required int monthCount,
    @JsonKey(name: "monthly_price") required double monthlyPrice,
  }) = _AdDetailInstallmentInfo;

  factory AdDetailInstallmentInfo.fromJson(Map<String, dynamic> json) =>
      _$AdDetailInstallmentInfoFromJson(json);
}

@freezed
class AdDetailInstallmentPlan with _$AdDetailInstallmentPlan {
  const factory AdDetailInstallmentPlan({
    @JsonKey(name: "id") required int id,
    @JsonKey(name: "ads_id") required int adId,
    @JsonKey(name: "month_id") required int monthCount,
    @JsonKey(name: "monthly_price") required double monthlyPrice,
    @JsonKey(name: "starting_price") required double startingPrice,
    @JsonKey(name: "starting_percentage") required double startingPercentage,
    @JsonKey(name: "total_price") required double totalPrice,
    @JsonKey(name: "overtime_price") required double overtimePrice,
    @JsonKey(name: "overtime_percentage") required double overtimePercentage,
  }) = _AdDetailInstallmentPlan;

  factory AdDetailInstallmentPlan.fromJson(Map<String, dynamic> json) =>
      _$AdDetailInstallmentPlanFromJson(json);
}

@freezed
class AdDetailCategory with _$AdDetailCategory {
  const factory AdDetailCategory({
    @JsonKey(name: "id") int? id,
    @JsonKey(name: "name") String? name,
    @JsonKey(name: "is_sell") bool? isSell,
    @JsonKey(name: "key_word") String? keyWord,
  }) = _AdDetailCategory;

  factory AdDetailCategory.fromJson(Map<String, dynamic> json) =>
      _$AdDetailCategoryFromJson(json);
}

@freezed
class AdDetailPhoto with _$AdDetailPhoto {
  const factory AdDetailPhoto({
    @JsonKey(name: "image") String? image,
    @JsonKey(name: "is_main") bool? isMain,
  }) = _AdDetailPhoto;

  factory AdDetailPhoto.fromJson(Map<String, dynamic> json) =>
      _$AdDetailPhotoFromJson(json);
}

@freezed
class AdDetailSellerResponse with _$AdDetailSellerResponse {
  const factory AdDetailSellerResponse({
    @JsonKey(name: "id") int? id,
    @JsonKey(name: "full_name") String? fullName,
    @JsonKey(name: "tin") int? tin,
    @JsonKey(name: "last_login_at") String? lastLoginAt,
    @JsonKey(name: "phote") String? photo,
    @JsonKey(name: "order_cancellations") int? cancelledOrdersCount,
    @JsonKey(name: "is_trusted") bool? isTrusted,
  }) = _AdDetailSellerResponse;

  factory AdDetailSellerResponse.fromJson(Map<String, dynamic> json) =>
      _$AdDetailSellerResponseFromJson(json);
}


@freezed
class UserOrderSmartDetailResponse with _$UserOrderSmartDetailResponse {
  const factory UserOrderSmartDetailResponse({
    required int id,
    int? product_id,
    String? main_photo,
    String? name,
    int? amount,
    num? credit_price_product,
    num? price,
    num? total_sum,
    OrderProductDetail? product,
    dynamic plan_payment_date,
    dynamic month_id,
    dynamic begin_price,
    dynamic overtime_percentage,
    dynamic starting_percentage,
    bool?  has_installment,

  }) = _UserOrderSmartDetailResponse;

  factory UserOrderSmartDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$UserOrderSmartDetailResponseFromJson(json);
}

@freezed
class OrderProductDetail with _$OrderProductDetail {
  const factory OrderProductDetail({
    int? id,
    String? status,
  }) = _OrderProductDetail;

  factory OrderProductDetail.fromJson(Map<String, dynamic> json) => _$OrderProductDetailFromJson(json);
}

@freezed
class UserOrderSmartResponse with _$UserOrderSmartResponse {
  const factory UserOrderSmartResponse({
    required int id,
    Order? order,
    String? status,
    Seller? seller,
    int? amount,
    num? final_sum,
    String? payment_type,
    String? note,
  }) = _UserOrderSmartResponse;

  factory UserOrderSmartResponse.fromJson(Map<String, dynamic> json) =>
      _$UserOrderSmartResponseFromJson(json);
}


@freezed
class Order with _$Order {
  const factory Order({
    String? doc_date,
    String? doc_num,
  }) = _Order;
  factory Order.fromJson(Map<String, dynamic> json) =>
      _$OrderFromJson(json);
}

@freezed
class Seller with _$Seller {
  const factory Seller({
    String? name,
    String? phone,
    int? tin,
    dynamic photo,
  }) = _Seller;

  factory Seller.fromJson(Map<String, dynamic> json) => _$SellerFromJson(json);
}
