import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const fondo = Color(0xFFF3E6FF);
    const contenedorClaro = Color(0xFFE8DEF8);
    const contenedorFondo = Color(0xFFDDC8F7);
    const textoOscuro = Color(0xFF3B2F49);
    const moradoBoton = Color(0xFF7B1FA2);

    return Scaffold(
      backgroundColor: fondo,
      body: SafeArea(
        child: Column(
          children: [
            // Título superior
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              width: double.infinity,
              color: contenedorFondo,
              child: const Center(
                child: Text(
                  'Página principal',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: textoOscuro,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Lecciones completadas
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: contenedorFondo,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Lecciones completadas',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: textoOscuro,
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 120,
                      child: ListView(
                        padding: EdgeInsets.zero,
                        children: List.generate(3, (index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 16),
                              decoration: BoxDecoration(
                                color: contenedorClaro,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Text(
                                'N. Lorem Ipsum',
                                style: const TextStyle(
                                  color: textoOscuro,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Siguiente lección
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: contenedorFondo,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: const [
                    Text(
                      'Siguiente lección',
                      style: TextStyle(
                        color: textoOscuro,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12),
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: contenedorClaro,
                      child: Text(
                        'N',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: textoOscuro,
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Lorem Ipsum',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: textoOscuro,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Botón "Iniciar lección"
            ElevatedButton(
              onPressed: () {
                // Navegar a pantalla de lección
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: moradoBoton,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding:
                const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
              ),
              child: const Text(
                'Iniciar lección',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),

            const Spacer(),

            // Espacio para íconos personalizados (BottomNavigationBar simulado)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              decoration: BoxDecoration(
                color: contenedorClaro,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset('assets/hogar.png', height: 32),
                  Image.asset('assets/libro.png', height: 32),
                  Image.asset('assets/comunidad.png', height: 32),
                  Image.asset('assets/usuario.png', height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
