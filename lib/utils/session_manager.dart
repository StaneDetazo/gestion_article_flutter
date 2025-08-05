import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static const String _cartKey = 'cart_items';

  // Ajouter un article au panier
  static Future<void> addToCart(Map<String, dynamic> article) async {
    final prefs = await SharedPreferences.getInstance();
    final cart = await getCartItems();
    cart.add(article);
    await prefs.setString(_cartKey, jsonEncode(cart));
  }

  // Supprimer un article par index
  static Future<void> removeFromCart(int index) async {
    final prefs = await SharedPreferences.getInstance();
    final cart = await getCartItems();
    cart.removeAt(index);
    await prefs.setString(_cartKey, jsonEncode(cart));
  }

  // Vider tout le panier
  static Future<void> clearCart() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_cartKey);
  }

  // Obtenir les articles du panier
  static Future<List<Map<String, dynamic>>> getCartItems() async {
    final prefs = await SharedPreferences.getInstance();
    final cartJson = prefs.getString(_cartKey);
    if (cartJson == null) return [];
    final List<dynamic> list = jsonDecode(cartJson);
    return list.map((item) => Map<String, dynamic>.from(item)).toList();
  }
}
