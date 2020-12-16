import 'package:flutter/foundation.dart';

import './cart_item_provider.dart';

class OrderItemProivder {
  final String id;
  final double amount;
  final List<CartItemProvider> products;
  final DateTime dateTime;

  OrderItemProivder({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime,
  });
}
