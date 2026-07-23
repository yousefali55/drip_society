import 'package:drip_society/layouts/desktop/products/data/product_model.dart';
import 'package:equatable/equatable.dart';

class CartItem extends Equatable {
  final ProductModel product;
  final int quantity;

  const CartItem({
    required this.product,
    required this.quantity,
  });

  CartItem copyWith({
    ProductModel? product,
    int? quantity,
  }) {
    return CartItem(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      product: ProductModel.fromJson(Map<String, dynamic>.from(json['product'] as Map)),
      quantity: (json['quantity'] as num).toInt(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product': product.toJson(),
      'quantity': quantity,
    };
  }

  @override
  List<Object?> get props => [
        product,
        quantity,
      ];
}