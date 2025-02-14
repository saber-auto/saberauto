import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Mon Panier"),
        actions: [
          IconButton(
            icon: Icon(Icons.clear_all),
            onPressed: () {
              cartProvider.clearCart();  // Vide le panier
            },
          ),
        ],
      ),
      body: cartProvider.items.isEmpty
          ? Center(child: Text("Votre panier est vide"))
          : ListView.builder(
              itemCount: cartProvider.items.length,
              itemBuilder: (context, index) {
                final item = cartProvider.items[index];
                return Card(
                  child: ListTile(
                    leading: Icon(Icons.shopping_cart),
                    title: Text(item.title),
                    subtitle: Text("Prix: ${item.price} TND"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: () {
                            // Réduire la quantité ou supprimer l'article si quantité = 1
                            if (item.quantity > 1) {
                              cartProvider.addItem(item.id, item.title, item.price);
                            } else {
                              cartProvider.removeItem(item.id);
                            }
                          },
                        ),
                        Text("x${item.quantity}"),
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            cartProvider.addItem(item.id, item.title, item.price);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Total: ${cartProvider.totalPrice} TND",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              onPressed: () {
                // Redirige vers la page de paiement ou autre action
              },
              child: Text("Passer à la caisse"),
            ),
          ],
        ),
      ),
    );
  }
}
