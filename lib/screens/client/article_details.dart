import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ArticleDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> article;

  const ArticleDetailsScreen({required this.article});

  Future<void> addToCart(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final cartData = prefs.getString('cart');
    List<Map<String, dynamic>> cart = [];

    if (cartData != null) {
      cart = List<Map<String, dynamic>>.from(json.decode(cartData));
    }

    cart.add(article);
    await prefs.setString('cart', json.encode(cart));

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Article ajouté au panier')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(article['name'].toString())),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(article['name'].toString(), style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(article['description'].toString(), style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Prix: ${article['price']} FCFA', style: const TextStyle(fontSize: 18)),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => addToCart(context),
                icon: const Icon(Icons.add_shopping_cart),
                label: const Text('Ajouter au panier'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
