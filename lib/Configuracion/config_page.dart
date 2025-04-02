import 'package:flutter/material.dart';

class ConfigPage extends StatelessWidget {
  const ConfigPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Configuración"),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Image.asset(
          'assets/hola.png', // Reemplaza con la ruta de tu imagen
          width: 600, // Ajusta el tamaño según necesites
          height: 1300,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
