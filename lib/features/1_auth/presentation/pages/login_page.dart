import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  // --- ARREGLO 3: QUITA EL 'const' DE AQUÍ ---
  LoginPage({super.key}); 
  // Si tenías 'const LoginPage(...)' antes, quítalo.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kmino Login'),
      ),
      body: const Center(
        child: Text(
          'Esta es la página de Login',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}