import 'dart:convert';

import 'package:drip_society/layouts/desktop/cart/cubit/cart_item_state.dart';
import 'package:drip_society/layouts/desktop/products/data/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/cart_item.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(const CartState()) {
    _loadFromStorage();
  }

  static const _storageKey = 'cart_items';

  Future<void> _loadFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_storageKey);
    if (raw == null || raw.isEmpty) return;

    try {
      final decoded = jsonDecode(raw) as List<dynamic>;
      final items = decoded
          .map((item) => CartItem.fromJson(item as Map<String, dynamic>))
          .toList();
      emit(CartState(items: items));
    } catch (_) {}
  }

  Future<void> _persist() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(state.items.map((item) => item.toJson()).toList());
    await prefs.setString(_storageKey, encoded);
  }

  Future<void> add(ProductModel product) async {
    final items = List<CartItem>.from(state.items);
    final index = items.indexWhere((e) => e.product.id == product.id);

    if (index == -1) {
      items.add(CartItem(product: product, quantity: 1));
    } else {
      items[index] = items[index].copyWith(quantity: items[index].quantity + 1);
    }

    emit(state.copyWith(items: items));
    await _persist();
  }

  Future<void> increase(ProductModel product) async {
    await add(product);
  }

  Future<void> decrease(ProductModel product) async {
    final items = List<CartItem>.from(state.items);
    final index = items.indexWhere((e) => e.product.id == product.id);
    if (index == -1) return;

    final item = items[index];
    if (item.quantity == 1) {
      items.removeAt(index);
    } else {
      items[index] = item.copyWith(quantity: item.quantity - 1);
    }

    emit(state.copyWith(items: items));
    await _persist();
  }

  Future<void> remove(String productId) async {
    final items = state.items.where((item) => item.product.id != productId).toList();
    emit(state.copyWith(items: items));
    await _persist();
  }

  int quantity(String productId) {
    try {
      return state.items.firstWhere((e) => e.product.id == productId).quantity;
    } catch (_) {
      return 0;
    }
  }

  Future<void> clear() async {
    emit(const CartState());
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_storageKey);
  }
}