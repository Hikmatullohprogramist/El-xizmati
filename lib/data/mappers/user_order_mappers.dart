import 'package:El_xizmati/data/datasource/network/responses/user_order/user_order_response.dart';
import 'package:El_xizmati/domain/mappers/common_mapper_exts.dart';
import 'package:El_xizmati/domain/models/order/user_order.dart';
import 'package:El_xizmati/domain/models/order/user_order_product.dart';
import 'package:El_xizmati/domain/models/seller/seller.dart';

extension UserOrderResponseMapper on UserOrderResponse {
  UserOrder toOrder() {
    return UserOrder(
      orderId: orderId,
      seller: seller?.toSeller(),
      status: status.toUserOrderStatus(),
      totalSum: totalSum ?? 0.0,
      createdAt: createdAt ?? "",
      cancelNote: cancelNote,
      products: products?.map((e) => e.toProduct()).toList() ?? [],
    );
  }
}

extension UserOrderSellerResponseMapper on UserOrderSellerResponse {
  Seller toSeller() {
    return Seller(
      id: id,
      name: name,
      tin: tin,
      image: image,
    );
  }
}

extension UserOrderProductResponseMapper on UserOrderProductResponse {
  UserOrderProduct toProduct() {
    return UserOrderProduct(
      id: id,
      orderId: orderId,
      quantity: quantity,
      price: price,
      totalSum: totalSum,
      productId: product?.id,
      productName: product?.name,
      paymentTypeId: paymentType?.id,
      paymentTypeName: paymentType?.name,
      unitId: unit?.id,
      unitName: unit?.name,
      shippingId: shipping?.id,
      shippingName: shipping?.name,
      deliveryId: delivery?.id,
      deliveryName: delivery?.name,
      status: status,
      mainPhoto: mainPhoto,
    );
  }
}
