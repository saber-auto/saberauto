import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String name;
  final double price;

  CartItem({required this.id, required this.name, required this.price});
}

class CartProvider with ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  void addToCart(String id, String name, double price) {
    _items.add(CartItem(id: id, name: name, price: price));
    notifyListeners(); // Updates UI
  }

  void removeFromCart(String id) {
    _items.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  double get totalPrice {
    return _items.fold(0, (sum, item) => sum + item.price);
  }
}
