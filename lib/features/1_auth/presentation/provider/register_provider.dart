import 'package:flutter/material.dart';

// Este es tu VISTAMODELO (ViewModel) para el Registro
class RegisterProvider extends ChangeNotifier {
  
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // --- Controladores de Texto (con los nuevos campos) ---
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController(); // <-- NUEVO

  // --- Estado de la UI ---
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _obscurePassword = true;
  bool get obscurePassword => _obscurePassword;

  bool _obscureConfirmPassword = true; // <-- NUEVO
  bool get obscureConfirmPassword => _obscureConfirmPassword;

  // --- Métodos (Lógica) ---

  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  // --- NUEVO MÉTODO ---
  void toggleConfirmPasswordVisibility() {
    _obscureConfirmPassword = !_obscureConfirmPassword;
    notifyListeners();
  }

  // Método principal de Registro
  Future<void> register() async {
    // 1. Valida el formulario
    if (!formKey.currentState!.validate()) {
      return; // Si no es válido, no hace nada
    }

    _isLoading = true;
    notifyListeners();

    // 2. Simulación de la llamada al Caso de Uso (y este al API)
    await Future.delayed(const Duration(seconds: 2));

    _isLoading = false;
    notifyListeners();
  }

  // --- Limpieza ---
  @override
  void dispose() {
    nameController.dispose(); // <-- NUEVO
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose(); // <-- NUEVO
    super.dispose();
  }
}