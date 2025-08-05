import 'package:flutter/material.dart';
import '../../utils/user_manager.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  String role = 'client'; // valeur par défaut

  String? errorMessage;

  @override
  void dispose() {
    emailCtrl.dispose();
    passwordCtrl.dispose();
    super.dispose();
  }

  void register() async {
    if (!_formKey.currentState!.validate()) return;

    final user = User(
      email: emailCtrl.text.trim(),
      password: passwordCtrl.text,
      role: role,
    );

    final success = await UserManager.registerUser(user);
    if (success) {
      Navigator.pop(context); // retour vers login
    } else {
      setState(() => errorMessage = "Email déjà utilisé");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Inscription")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              if (errorMessage != null)
                Text(errorMessage!, style: TextStyle(color: Colors.red)),
              TextFormField(
                controller: emailCtrl,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (v) =>
                (v == null || !v.contains('@')) ? "Email invalide" : null,
              ),
              TextFormField(
                controller: passwordCtrl,
                decoration: InputDecoration(labelText: 'Mot de passe'),
                obscureText: true,
                validator: (v) => (v == null || v.length < 6)
                    ? "Mot de passe >= 6 caractères"
                    : null,
              ),
              DropdownButtonFormField<String>(
                value: role,
                items: ['client', 'admin']
                    .map((r) => DropdownMenuItem(value: r, child: Text(r)))
                    .toList(),
                onChanged: (v) => setState(() => role = v ?? 'client'),
                decoration: InputDecoration(labelText: 'Rôle'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(onPressed: register, child: Text("S'inscrire")),
            ],
          ),
        ),
      ),
    );
  }
}
