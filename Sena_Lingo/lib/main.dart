// lib/main.dart

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Registro Flutter Firebase',
      theme: ThemeData(primarySwatch: Colors.teal),

      // Arrancamos en la ruta 'login'
      initialRoute: AppRoutes.login,

      // Aquí pasamos todas las rutas que definimos en AppRoutes.routes
      routes: AppRoutes.routes,
    );
  }
}
