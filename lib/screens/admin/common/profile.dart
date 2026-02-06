import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => LoginScreen()),
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profil")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.account_circle, size: 80),
            SizedBox(height: 20),
            Text("Vous êtes connecté", style: TextStyle(fontSize: 18)),
            SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: () => logout(context),
              icon: Icon(Icons.logout),
              label: Text("Déconnexion"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            )
          ],
        ),
      ),
    );
  }
}
