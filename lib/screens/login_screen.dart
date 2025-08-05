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

    // Navigation selon rôle
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
      appBar: AppBar(title: const Text("Connexion")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (errorMessage != null)
              Text(errorMessage!, style: TextStyle(color: Colors.red)),
            TextField(
              controller: emailCtrl,
              decoration: InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: passwordCtrl,
              decoration: InputDecoration(labelText: "Mot de passe"),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: login, child: Text("Se connecter")),
            TextButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => RegisterScreen()));
              },
              child: const Text("Créer un compte"),
            )
          ],
        ),
      ),
    );
  }
}
