import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiServices4 {
  Future<List<dynamic>> CalcularCarbohidratos() async {
    final url =
        Uri.parse("http://192.168.0.69/ConexionBaseDeDatos/get_alimentos4.php");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Error al obtener datos: ${response.statusCode}");
    }
  }
}
