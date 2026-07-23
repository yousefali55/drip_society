import 'package:equatable/equatable.dart';

import '../models/cart_item.dart';

class CartState extends Equatable {
  final List<CartItem> items;

  const CartState({
    this.items = const [],
  });

  CartState copyWith({
    List<CartItem>? items,
  }) {
    return CartState(
      items: items ?? this.items,
    );
  }

  double get totalPrice =>
      items.fold(
        0,
        (sum, item) => sum + item.product.price * item.quantity,
      );

  int get totalQuantity =>
      items.fold(
        0,
        (sum, item) => sum + item.quantity,
      );

  @override
  List<Object> get props => [items];
}