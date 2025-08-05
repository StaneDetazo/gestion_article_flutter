import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class User {
  final String email;
  final String password;
  final String role; // 'admin' ou 'client'

  User({required this.email, required this.password, required this.role});

  Map<String, dynamic> toJson() =>
      {'email': email, 'password': password, 'role': role};

  static User fromJson(Map<String, dynamic> json) => User(
    email: json['email'],
    password: json['password'],
    role: json['role'],
  );
}

class UserManager {
  static const _usersKey = 'users';
  static const _currentUserKey = 'current_user';

  // Enregistre un nouvel utilisateur
  static Future<bool> registerUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    final usersJson = prefs.getString(_usersKey);

    List<dynamic> users = usersJson == null ? [] : jsonDecode(usersJson);

    // Vérifier doublon email
    if (users.any((u) => u['email'] == user.email)) return false;

    users.add(user.toJson());
    await prefs.setString(_usersKey, jsonEncode(users));
    return true;
  }

  // Connexion : retourne User si succès, sinon null
  static Future<User?> login(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final usersJson = prefs.getString(_usersKey);
    if (usersJson == null) return null;

    final users = List<Map<String, dynamic>>.from(jsonDecode(usersJson));
    final userJson =
    users.firstWhere((u) => u['email'] == email && u['password'] == password, orElse: () => {});
    if (userJson.isEmpty) return null;

    final user = User.fromJson(userJson);
    await prefs.setString(_currentUserKey, jsonEncode(user.toJson()));
    return user;
  }

  // Récupérer l'utilisateur connecté
  static Future<User?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final currentUserJson = prefs.getString(_currentUserKey);
    if (currentUserJson == null) return null;

    return User.fromJson(jsonDecode(currentUserJson));
  }

  // Déconnexion
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_currentUserKey);
  }
}
