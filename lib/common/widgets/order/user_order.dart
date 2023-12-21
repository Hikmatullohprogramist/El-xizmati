import 'package:flutter/material.dart';
import 'package:onlinebozor/data/responses/user_order/user_order_response.dart';

class UserOrderWidget extends StatelessWidget {
  const UserOrderWidget({
    super.key,
    required this.listenerAddressEdit,
    required this.listener,
    required this.response,
  });

  final UserOrderResponse response;
  final VoidCallback listenerAddressEdit;
  final VoidCallback listener;

  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: listener, child: SizedBox());
  }
}
