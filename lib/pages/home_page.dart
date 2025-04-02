import 'package:app_calculadora_carbohidratos/Configuracion/config_page.dart';
import 'package:app_calculadora_carbohidratos/Secciones%20Diferentes/cereales.dart';
import 'package:app_calculadora_carbohidratos/Secciones%20Diferentes/comidas.dart';
import 'package:app_calculadora_carbohidratos/Secciones%20Diferentes/dulces.dart';
import 'package:app_calculadora_carbohidratos/Secciones%20Diferentes/extras.dart';
import 'package:app_calculadora_carbohidratos/Secciones%20Diferentes/frutas.dart';
import 'package:app_calculadora_carbohidratos/Secciones%20Diferentes/lacteos.dart';
import 'package:app_calculadora_carbohidratos/Secciones%20Diferentes/panificados.dart';
import 'package:app_calculadora_carbohidratos/Secciones%20Diferentes/vegetales.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static final List<Widget> _pages = [
    const HomeContent(), // Contenido principal de la HomePage
    const ConfigPage(), // Página de configuración
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F0F1),
      appBar: AppBar(
        title: const Text(
          "CARBOTRACK",
          style: TextStyle(
              fontFamily: "Montserrat",
              fontSize: 24,
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF1A5C65),
        centerTitle: true,
        foregroundColor: Colors.white,
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF1A5C65),
        selectedItemColor: const Color(0xFFE8F0F1),
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(LucideIcons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(LucideIcons.settings),
            label: 'Configuración',
          ),
        ],
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  void _navigateWithLoading(BuildContext context, Widget page) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pop(context); // Cierra el diálogo de carga
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => page),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        children: [
          _buildCardButton(context, "Cereales", LucideIcons.wheat, Cereales()),
          _buildCardButton(context, "Comidas", LucideIcons.utensils, Comidas()),
          _buildCardButton(
              context, "Vegetales", LucideIcons.carrot, Vegetales()),
          _buildCardButton(context, "Frutas", LucideIcons.apple, Frutas()),
          _buildCardButton(context, "Dulces", LucideIcons.candy, Dulces()),
          _buildCardButton(context, "Lácteos", LucideIcons.milk, Lacteos()),
          _buildCardButton(
              context, "Panificados", LucideIcons.croissant, Panificados()),
          _buildCardButton(context, "Extras", LucideIcons.star, Extras()),
        ],
      ),
    );
  }

  Widget _buildCardButton(
      BuildContext context, String label, IconData icon, Widget page) {
    return GestureDetector(
      onTap: () => _navigateWithLoading(context, page),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: const Color(0xFF2D95A1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 40),
            const SizedBox(height: 10),
            Text(
              label,
              style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
