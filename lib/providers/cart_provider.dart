import 'package:flutter/material.dart';
import '../models/cart_item.dart';

class CartProvider with ChangeNotifier {
  // Liste des articles du panier
  final List<CartItem> _items = [];

  // Récupérer tous les articles du panier
  List<CartItem> get items => _items;

  // Ajouter un article au panier
  void addItem(String id, String title, double price) {
    // Vérifier si l'article est déjà dans le panier
    int index = _items.indexWhere((item) => item.id == id);
    if (index != -1) {
      // Si l'article existe déjà, augmenter la quantité
      _items[index] = CartItem(
        id: _items[index].id,
        title: _items[index].title,
        price: _items[index].price,
        quantity: _items[index].quantity + 1,
      );
    } else {
      // Ajouter un nouvel article au panier
      _items.add(CartItem(id: id, title: title, price: price));
    }
    notifyListeners(); // Notifier les autres widgets que les données ont changé
  }

  // Supprimer un article du panier
  void removeItem(String id) {
    _items.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  // Calculer le prix total du panier
  double get totalPrice {
    return _items.fold(0.0, (sum, item) => sum + (item.price * item.quantity));
  }

  // Vider le panier
  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
