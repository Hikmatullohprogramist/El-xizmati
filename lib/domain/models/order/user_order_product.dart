class UserOrderProduct {
  int? id;
  int? orderId;
  int? quantity;
  int? price;
  int? totalSum;
  int? productId;
  String? productName;
  int? paymentTypeId;
  String? paymentTypeName;
  int? unitId;
  String? unitName;
  int? shippingId;
  String? shippingName;
  int? deliveryId;
  String? deliveryName;
  String? status;
  String? mainPhoto;

  UserOrderProduct({
    this.id,
    this.orderId,
    this.quantity,
    this.price,
    this.totalSum,
    this.productId,
    this.productName,
    this.paymentTypeId,
    this.paymentTypeName,
    this.unitId,
    this.unitName,
    this.shippingId,
    this.shippingName,
    this.deliveryId,
    this.deliveryName,
    this.status,
    this.mainPhoto,
  });
}
