import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kamino_fr/core/app_theme.dart';
import 'package:provider/provider.dart';
import '../provider/register_provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> with TickerProviderStateMixin {
  late AnimationController _headerSlideController;
  late Animation<Offset> _headerSlideAnimation;

  @override
  void initState() {
    super.initState();
    _headerSlideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _headerSlideAnimation = Tween<Offset>(
      begin: const Offset(-1.5, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _headerSlideController,
      curve: Curves.easeOut,
    ));
    _headerSlideController.forward();
  }

  @override
  void dispose() {
    _headerSlideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RegisterProvider(),
      child: Scaffold(
        backgroundColor: AppTheme.textBlack,
        body: SafeArea(
          child: Consumer<RegisterProvider>(
            builder: (context, provider, child) {
              final isLoading = provider.isLoading;

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AnimatedBuilder(
                      animation: _headerSlideController,
                      builder: (context, child) {
                        return SlideTransition(
                          position: _headerSlideAnimation,
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.fromLTRB(30.0, 30.0, 60.0, 20.0),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  AppTheme.primaryMint,
                                  AppTheme.primaryMint.withOpacity(0.8),
                                  AppTheme.primaryMint.withOpacity(0.9),
                                ],
                              ),
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(30.0),
                                bottomRight: Radius.circular(30.0),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: AppTheme.primaryMint.withOpacity(0.3),
                                  blurRadius: 20,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Hola!',
                                  style: TextStyle(
                                    fontSize: 48,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Estas listo para una nueva aventura?',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),

                    // 4. El resto del contenido
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 40.0),
                          const Text(
                            'Crear Cuenta', // <-- CAMBIADO
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 20.0),

                          Form(
                            key: provider.formKey,
                            child: Column(
                              children: [
                                // 5. NUEVO CAMPO: Nombre
                                TextFormField(
                                  controller: provider.nameController,
                                  decoration: InputDecoration(
                                    hintText: 'Nombre',
                                    filled: true,
                                    fillColor: AppTheme.background.withOpacity(0.9),
                                     border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide.none,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide.none,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: const BorderSide(color: AppTheme.primaryMint, width: 2),
                                    ),
                                  ),
                                  keyboardType: TextInputType.name,
                                  style: const TextStyle(fontSize: 16),
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'El nombre es obligatorio';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 20.0),

                                // --- Campo de Email (igual) ---
                                TextFormField(
                                  controller: provider.emailController,
                                  decoration: InputDecoration(
                                    hintText: 'Tu@correo.com',
                                    filled: true,
                                    fillColor: AppTheme.background.withOpacity(0.9),
                                     border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide.none,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide.none,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: const BorderSide(color: AppTheme.primaryMint, width: 2),
                                    ),
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                  style: const TextStyle(fontSize: 16),
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'El correo es obligatorio';
                                    }
                                     if (!RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}").hasMatch(value.trim())) {
                                      return 'Ingresa un correo válido';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 20.0),
                                
                                // --- Campo de Contraseña (igual) ---
                                TextFormField(
                                  controller: provider.passwordController,
                                  obscureText: provider.obscurePassword,
                                  decoration: InputDecoration(
                                    hintText: 'Contraseña',
                                    filled: true,
                                    fillColor: AppTheme.background.withOpacity(0.9),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        provider.obscurePassword
                                            ? Icons.visibility_outlined
                                            : Icons.visibility_off_outlined,
                                        color: AppTheme.textBlack,
                                      ),
                                      onPressed: provider.togglePasswordVisibility,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide.none,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide.none,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: const BorderSide(color: AppTheme.primaryMint, width: 2),
                                    ),
                                  ),
                                  style: const TextStyle(fontSize: 16),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'La contraseña es obligatoria';
                                    }
                                    if (value.length < 6) {
                                      return 'Mínimo 6 caracteres';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 20.0),

                                // 6. NUEVO CAMPO: Confirmar Contraseña
                                TextFormField(
                                  controller: provider.confirmPasswordController,
                                  obscureText: provider.obscureConfirmPassword,
                                  decoration: InputDecoration(
                                    hintText: 'Confirmar Contraseña',
                                    filled: true,
                                    fillColor: AppTheme.background.withOpacity(0.9),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        provider.obscureConfirmPassword
                                            ? Icons.visibility_outlined
                                            : Icons.visibility_off_outlined,
                                        color: AppTheme.textBlack,
                                      ),
                                      onPressed: provider.toggleConfirmPasswordVisibility,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide.none,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide.none,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: const BorderSide(color: AppTheme.primaryMint, width: 2),
                                    ),
                                  ),
                                  style: const TextStyle(fontSize: 16),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Confirma tu contraseña';
                                    }
                                    if (value != provider.passwordController.text) {
                                      return 'Las contraseñas no coinciden';
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 25.0),

                          // 7. CAMBIO DE BOTÓN
                          SizedBox(
                            width: double.infinity,
                            height: 55,
                            child: ElevatedButton(
                              onPressed: isLoading
                                  ? null
                                  : () => context.read<RegisterProvider>().register(), // <-- Llama a register()
                              child: isLoading
                                  ? const SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: CircularProgressIndicator(
                                        color: AppTheme.textBlack,
                                        strokeWidth: 3,
                                      ),
                                    )
                                  : const Text(
                                      'Registrarse', // <-- CAMBIADO
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                            ),
                          ),

                          const SizedBox(height: 30.0),
                          
                          // 8. CAMBIO DE TEXTO INFERIOR
                          Align(
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  'Ya tienes cuenta? ', // <-- CAMBIADO
                                  style: TextStyle(color: Colors.white),
                                ),
                                TextButton(
                                  onPressed: () {
                                    // Navega de vuelta al login
                                    Navigator.pop(context); 
                                  },
                                  child: const Text(
                                    'Inicia Sesion', // <-- CAMBIADO
                                    style: TextStyle(
                                        color: AppTheme.primaryMint,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          
                          // 9. LOGO AÑADIDO
                          const SizedBox(height: 5.0),
                          Align(
                            alignment: Alignment.center,
                            child: Image.asset(
                              'assets/images/logo.png', // Asegúrate que el path sea correcto
                              height: 100,
                            ),
                          ),
                          
                          const SizedBox(height: 50.0),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}