import 'package:app_calculadora_carbohidratos/pages/plashScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_calculadora_carbohidratos/themes/theme_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => ThemeProvider()), // Agrega tu ThemeProvider aquí
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: themeProvider
              .getTheme(), // Asegúrate de tener esta función en ThemeProvider
          home: const SplashScreen(),
        );
      },
    );
  }
}
