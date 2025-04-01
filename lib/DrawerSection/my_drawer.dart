import 'package:app_calculadora_carbohidratos/Configuracion/config_page.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Calculadora De Carbohidratos',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text('Opciones',
                    style: TextStyle(fontSize: 14, color: Colors.grey)),
              ],
            ),
          ),
          _createDrawerItem(
              Icons.settings, 'Configuracion', Colors.black, false, context),
        ],
      ),
    );
  }

  Widget _createDrawerItem(IconData icon, String text, Color color,
      bool selected, BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: TextStyle(color: color)),
      selected: selected,
      selectedTileColor: Colors.purple.shade50,
      onTap: () {
        if (text == 'Configuracion') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ConfigPage()),
          );
        }
      },
    );
  }
}
