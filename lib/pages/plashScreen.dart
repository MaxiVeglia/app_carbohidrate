import 'package:flutter/material.dart';
import 'home_page.dart'; // Asegúrate de tener esta página creada

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  void _navigateWithLoading(BuildContext context) {
    // Mostrar el loading
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    // Esperar 1.5 segundos antes de navegar
    Future.delayed(const Duration(seconds: 1, milliseconds: 500), () {
      Navigator.pop(context); // Cierra el diálogo de carga
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Fondo completamente blanco
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white, // Fondo blanco
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/Carbotrack_Logo.png', // Asegúrate de tener esta imagen en assets
                    width: 350,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              width: double.infinity,
              color: Colors.white, // Fondo inferior también blanco
              child: Center(
                child: ElevatedButton(
                  onPressed: () => _navigateWithLoading(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF215A6D), // Color del botón
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 90,
                      vertical: 22,
                    ),
                  ),
                  child: const Text(
                    'Siguiente',
                    style: TextStyle(
                      fontSize: 26,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
