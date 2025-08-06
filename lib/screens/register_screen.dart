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
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.red[800],
        title: const Text("Inscription", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Text(
                    errorMessage!,
                    style: const TextStyle(
                      color: Colors.redAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              TextFormField(
                controller: emailCtrl,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Email',
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
                validator: (v) =>
                (v == null || !v.contains('@')) ? "Email invalide" : null,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: passwordCtrl,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Mot de passe',
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
                obscureText: true,
                validator: (v) =>
                (v == null || v.length < 6) ? "Mot de passe >= 6 caractères" : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: role,
                decoration: InputDecoration(
                  labelText: 'Rôle',
                  labelStyle: TextStyle(color: Colors.red[300]),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red.shade700),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red.shade400, width: 2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                  fillColor: Colors.white12,
                ),
                dropdownColor: Colors.black,
                style: const TextStyle(color: Colors.white),
                items: ['client', 'admin']
                    .map((r) => DropdownMenuItem(
                  value: r,
                  child: Text(r, style: const TextStyle(color: Colors.white)),
                ))
                    .toList(),
                onChanged: (v) => setState(() => role = v ?? 'client'),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    textStyle:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  onPressed: register,
                  child: const Text("S'inscrire"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
