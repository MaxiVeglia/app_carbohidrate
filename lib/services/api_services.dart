import 'dart:convert';
import 'package:http/http.dart' as http;

Future CalcularCarbohidratos() async {
  final response = await http.get(
    Uri.parse('http://192.168.0.69/ConexionBaseDeDatos/get_alimentos.php'),
    headers: {
      'Cache-Control': 'no-cache, no-store, must-revalidate',
      'Pragma': 'no-cache',
      'Expires': '0',
    },
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Error al cargar datos');
  }
}
