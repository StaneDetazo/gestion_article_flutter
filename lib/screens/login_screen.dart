import 'package:flutter/material.dart';
import '../../utils/user_manager.dart';
import 'admin/admin_home.dart';
import 'client/client_home.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  String? errorMessage;

  void login() async {
    final email = emailCtrl.text.trim();
    final password = passwordCtrl.text;

    if (email.isEmpty || password.isEmpty) {
      setState(() {
        errorMessage = "Email et mot de passe requis.";
      });
      return;
    }

    final user = await UserManager.login(email, password);

    if (user == null) {
      setState(() {
        errorMessage = "Email ou mot de passe incorrect.";
      });
      return;
    }

    if (user.role == 'admin') {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => AdminHome()));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => ClientHome()));
    }
  }

  @override
  void dispose() {
    emailCtrl.dispose();
    passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.red[800],
        title: const Text("Connexion", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text(
                  errorMessage!,
                  style: const TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold),
                ),
              ),
            TextField(
              controller: emailCtrl,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: "Email",
                labelStyle: TextStyle(color: Colors.red[300]),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red.shade700),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red.shade400, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
                fillColor: Colors.white12,
                filled: true,
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: passwordCtrl,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: "Mot de passe",
                labelStyle: TextStyle(color: Colors.red[300]),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.redAccent),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red.shade700, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
                fillColor: Colors.white12,
                filled: true,
              ),
              obscureText: true,
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                onPressed: login,
                child: const Text("Se connecter"),
              ),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => RegisterScreen()));
              },
              child: Text(
                "Créer un compte",
                style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w600),
              ),
            )
          ],
        ),
      ),
    );
  }
}
