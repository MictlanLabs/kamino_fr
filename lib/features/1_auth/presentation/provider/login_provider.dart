import 'package:flutter/material.dart';

// Este es tu VISTAMODELO (ViewModel)
class LoginProvider extends ChangeNotifier {
  
  // --- Clave del Formulario ---
  // Se la pasaremos desde la Vista para poder validar
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // --- Controladores de Texto ---
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // --- Estado de la UI ---
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _obscurePassword = true;
  bool get obscurePassword => _obscurePassword;

  // --- Métodos (Lógica) ---

  // Método para cambiar la visibilidad de la contraseña
  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    notifyListeners(); // Avisa a la Vista que debe redibujarse
  }

  // Método principal de Login
  Future<void> login() async {
    // 1. Valida el formulario
    if (!formKey.currentState!.validate()) {
      return; // Si no es válido, no hace nada
    }

    // 2. Inicia el estado de carga
    _isLoading = true;
    notifyListeners(); // Avisa a la Vista

    // 3. Simulación de la llamada al Caso de Uso (y este al API)
    // (Aquí es donde llamarías a tu LoginUseCase)
    await Future.delayed(const Duration(seconds: 2));

    // 4. Finaliza el estado de carga
    _isLoading = false;
    notifyListeners(); // Avisa a la Vista

    // TODO: 5. Aquí iría la navegación si el login es exitoso
    // Navigator.pushReplacementNamed(context, '/home');
  }

  // --- Limpieza ---
  // Sobrescribimos 'dispose' para limpiar los controladores
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}