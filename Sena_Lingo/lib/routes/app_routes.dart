// lib/routes/app_routes.dart

import 'package:flutter/material.dart';
import '../views/login/login_form.dart';
import '../views/register/register_form.dart';
import '../views/home/home_screen.dart';

class AppRoutes {
  // Nombres de rutas estáticas
  static const String login    = 'login';
  static const String register = 'register';
  static const String home     = 'home';

  // Mapa de todas las rutas
  static Map<String, WidgetBuilder> get routes {
    return {
      login: (_)    => const LoginForm(),
      register: (_) => const RegisterForm(),
      home: (_)     => const HomeScreen(),
    };
  }
}
