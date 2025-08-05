import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CartScreen extends StatefulWidget {
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<Map<String, dynamic>> cartItems = [];

  @override
  void initState() {
    super.initState();
    loadCart();
  }

  Future<void> loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    final cartData = prefs.getString('cart') ?? '[]';
    setState(() {
      cartItems = List<Map<String, dynamic>>.from(jsonDecode(cartData));
    });
  }

  Future<void> removeItem(int index) async {
    cartItems.removeAt(index);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('cart', jsonEncode(cartItems));
    setState(() {});
  }

  Future<void> clearCart() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('cart');
    setState(() => cartItems = []);
  }

  int getTotal() {
    return cartItems.fold(0, (sum, item) => sum + (item['price'] as int));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mon Panier'),
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            onPressed: clearCart,
            icon: const Icon(Icons.delete),
            tooltip: 'Vider le panier',
          ),
        ],
      ),
      body: cartItems.isEmpty
          ? const Center(child: Text('Panier vide'))
          : ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          final item = cartItems[index];
          return ListTile(
            title: Text(item['name']),
            subtitle: Text('${item['price']} FCFA'),
            trailing: IconButton(
              icon: const Icon(Icons.remove_circle, color: Colors.red),
              onPressed: () => removeItem(index),
            ),
          );
        },
      ),
      bottomNavigationBar: cartItems.isNotEmpty
          ? Container(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton.icon(
          onPressed: () {
            // Paiement fictif
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Paiement effectué')),
            );
            clearCart();
          },
          icon: const Icon(Icons.payment),
          label: Text('Payer ${getTotal()} FCFA'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal,
            minimumSize: const Size(double.infinity, 50),
          ),
        ),
      )
          : null,
    );
  }
}
