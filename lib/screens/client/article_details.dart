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
      const SnackBar(
        content: Text('Article ajouté au panier'),
        backgroundColor: Colors.redAccent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(article['name'].toString(),
            style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.redAccent,
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              article['name'].toString(),
              style: const TextStyle(
                  fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 12),
            Text(
              article['description'].toString(),
              style: TextStyle(fontSize: 18, color: Colors.white70),
            ),
            const SizedBox(height: 12),
            Text(
              'Prix : ${article['price']} FCFA',
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.w600, color: Colors.red[400]),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () => addToCart(context),
                icon: const Icon(Icons.add_shopping_cart),
                label: const Text(
                  'Ajouter au panier',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
