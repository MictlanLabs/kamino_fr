import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kamino_fr/core/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:kamino_fr/features/1_auth/presentation/provider/login_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
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
      create: (_) => LoginProvider(),
      child: Scaffold(
        backgroundColor: AppTheme.textBlack,
        body: SafeArea(
          child: Consumer<LoginProvider>(
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
        padding: const EdgeInsets.fromLTRB(30.0, 50.0, 60.0, 40.0),
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
          children: [
            const SizedBox(height: 8),
            const Text(
              'Hola!',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Bienvenido de vuelta',
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
                          const SizedBox(height: 50.0),
                          const Text(
                            'Iniciar Sesion',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 20.0),

                          // 5. Conectamos el Form a la clave del Provider
                          Form(
                            key: provider.formKey, // <-- CONECTADO
                            child: Column(
                              children: [
                                // 6. Conectamos el TextFormField al controlador del Provider
                                TextFormField(
                                  controller: provider.emailController, // <-- CONECTADO
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
                                
                                // 7. Conectamos el TextFormField de Contraseña
                                TextFormField(
                                  controller: provider.passwordController, // <-- CONECTADO
                                  obscureText: provider.obscurePassword, // <-- CONECTADO
                                  decoration: InputDecoration(
                                    hintText: 'Contraseña',
                                    filled: true,
                                    fillColor: AppTheme.background.withOpacity(0.9),
                                    // 8. Conectamos el botón de visibilidad
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        provider.obscurePassword
                                            ? Icons.visibility_outlined
                                            : Icons.visibility_off_outlined,
                                        color: AppTheme.textBlack,
                                      ),
                                      // 9. Llamamos al método del Provider
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
                                      return 'La contraseña debe tener al menos 6 caracteres';
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 10.0),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {},
                              child: const Text(
                                '¿Olvidaste tu contraseña?',
                                style: TextStyle(
                                  color: AppTheme.primaryMint,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 25.0),

                          // 10. Conectamos el botón de Login
                          SizedBox(
                            width: double.infinity,
                            height: 55,
                            child: ElevatedButton(
                              // Deshabilitamos el botón si está cargando
                              onPressed: isLoading
                                  ? null
                                  // Llamamos al método login() del Provider
                                  : () => context.read<LoginProvider>().login(),
                              child: isLoading
                                  // Mostramos el spinner si está cargando
                                  ? const SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: CircularProgressIndicator(
                                        color: AppTheme.textBlack,
                                        strokeWidth: 3,
                                      ),
                                    )
                                  : const Text(
                                      'Iniciar Sesión',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                            ),
                          ),

                          // ... (El resto del código: "Registrate", Logo, etc.) ...
                          const SizedBox(height: 30.0),
                          Align(
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  'No tienes cuenta? ',
                                  style: TextStyle(color: Colors.white),
                                ),
                                TextButton(
                                  onPressed: () {
                                    // TODO: Navegar a la pantalla de registro
                                  },
                                  child: const Text(
                                    'Registrate',
                                    style: TextStyle(
                                        color: AppTheme.primaryMint,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              width: 100,
                              height: 100,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(
                                  'assets/images/logo.png',
                                  fit: BoxFit.contain,
                                ),
                              ),
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