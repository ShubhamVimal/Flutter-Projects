import 'package:flutter/foundation.dart';

class CartItemProvider {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItemProvider({
    @required this.id,
    @required this.title,
    @required this.quantity,
    @required this.price,
  });
}
