import 'package:app_calculadora_carbohidratos/DrawerSection/my_drawer.dart';
import 'package:app_calculadora_carbohidratos/Secciones%20Diferentes/cereales.dart';
import 'package:app_calculadora_carbohidratos/Secciones%20Diferentes/comidas.dart';
import 'package:app_calculadora_carbohidratos/Secciones%20Diferentes/dulces.dart';
import 'package:app_calculadora_carbohidratos/Secciones%20Diferentes/extras.dart';
import 'package:app_calculadora_carbohidratos/Secciones%20Diferentes/frutas.dart';
import 'package:app_calculadora_carbohidratos/Secciones%20Diferentes/lacteos.dart';
import 'package:app_calculadora_carbohidratos/Secciones%20Diferentes/panificados.dart';
import 'package:app_calculadora_carbohidratos/Secciones%20Diferentes/vegetales.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final appBarColor = Colors.redAccent;
    final tileColor = Colors.purple.shade200;
    final iconColor = Colors.white;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text(
          "¡Calcula Los Carbohidratos!",
          style: TextStyle(fontFamily: "copperplate", fontSize: 24),
        ),
        foregroundColor: Colors.white,
        centerTitle: true,
        backgroundColor: appBarColor,
      ),
      drawer: MyDrawer(),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    "https://previews.123rf.com/images/metrue/metrue1710/metrue171000003/88085246-patr%C3%B3n-sin-fisuras-con-puntos-negros-sobre-fondo-blanco-m%C3%ADnima-fondo-blanco-dise%C3%B1o-del-ornamento.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: GridView.count(
              padding: const EdgeInsets.all(20),
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: [
                _buildCardButton(context, "Cereales", Icons.rice_bowl,
                    tileColor, iconColor, const Cereales()),
                _buildCardButton(context, "Comidas", Icons.fastfood, tileColor,
                    iconColor, Comidas()),
                _buildCardButton(context, "Dulces", Icons.cake, tileColor,
                    iconColor, const Dulces()),
                _buildCardButton(context, "Frutas", Icons.apple, tileColor,
                    iconColor, const Frutas()),
                _buildCardButton(context, "Lacteos", Icons.local_drink,
                    tileColor, iconColor, Lacteos()),
                _buildCardButton(context, "Panificados", Icons.bakery_dining,
                    tileColor, iconColor, Panificados()),
                _buildCardButton(context, "Vegetales", Icons.grass, tileColor,
                    iconColor, const Vegetales()),
                _buildCardButton(context, "Extras", Icons.category, tileColor,
                    iconColor, const Extras()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardButton(BuildContext context, String label, IconData icon,
      Color tileColor, Color iconColor, Widget page) {
    return GestureDetector(
      onTap: () => _navigateWithLoading(context, page),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: tileColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: iconColor, size: 40),
            const SizedBox(height: 10),
            Text(
              label,
              style: TextStyle(
                  fontSize: 20, color: Colors.red, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _navigateWithLoading(BuildContext context, Widget page) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(color: Colors.indigo.shade900),
        );
      },
    );

    await Future.delayed(const Duration(seconds: 2));

    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }
}
