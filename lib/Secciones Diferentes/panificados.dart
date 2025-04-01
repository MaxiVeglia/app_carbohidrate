import 'package:app_calculadora_carbohidratos/OtherServices/calcular6.dart';
import 'package:app_calculadora_carbohidratos/services/api_services6.dart';
import 'package:flutter/material.dart';

class Panificados extends StatefulWidget {
  const Panificados({super.key});

  @override
  State<Panificados> createState() => _PanificadosState();
}

class _PanificadosState extends State<Panificados> {
  List<dynamic> alimentos = [];
  String? alimentoSeleccionado;
  TextEditingController gramosController = TextEditingController();
  double hcTotal = 0;

  @override
  void initState() {
    super.initState();
    cargarAlimentos();
  }

  void cargarAlimentos() async {
    try {
      List<dynamic> datos = await ApiServices6().CalcularCarbohidratos();
      setState(() {
        alimentos = datos;
      });
    } catch (e) {
      print("Error al cargar alimentos: $e");
    }
  }

  void calcularCarbohidratos() {
    if (alimentoSeleccionado == null) {
      mostrarMensaje("Por favor, selecciona un alimento.");
      return;
    }

    if (gramosController.text.isEmpty) {
      mostrarMensaje("Por favor, ingresa los gramos.");
      return;
    }

    double? gramos = double.tryParse(gramosController.text);

    if (gramos == null) {
      mostrarMensaje("Ingresa un valor numérico válido.");
      return;
    }

    var alimento = alimentos.firstWhere(
      (a) => a["id_alimento"].toString() == alimentoSeleccionado,
      orElse: () => null,
    );

    if (alimento == null ||
        alimento["porcion_gr"] == null ||
        alimento["HC_gr"] == null) {
      mostrarMensaje("Error al obtener información del alimento.");
      return;
    }

    // Obtener la porción en gramos y los carbohidratos por porción de la API
    double porcionGramos = double.parse(alimento["porcion_gr"].toString());
    double hcPorPorcion = double.parse(alimento["HC_gr"].toString());

    // Calcular los HC de acuerdo con la cantidad seleccionada, basada en la porción de la API
    hcTotal = (gramos / porcionGramos) * hcPorPorcion;

    // Navegar a la siguiente pantalla con el valor actualizado de hcTotal
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Calcular6(
          alimento1: alimento["alimento"],
          alimento2: "", // Agregar valor adecuado
          cantidad1: gramos,
          cantidad2: 0.0, // Agregar valor adecuado
          hcTotal: hcTotal, alimentosSeleccionados: [],
          cantidades: [], alimentosPorSeccion: {}, cantidadesPorSeccion: {},
          glucemia: 0.0,
        ),
      ),
    );
  }

  void mostrarMensaje(String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mensaje)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text("Selecciona un Alimento"),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            alimentos.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      _buildDropdown(
                          "Selecciona un alimento", alimentoSeleccionado,
                          (value) {
                        setState(() {
                          alimentoSeleccionado = value;
                        });
                      }),
                      const SizedBox(height: 20),
                      TextField(
                        controller: gramosController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Ingresa los gramos",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: calcularCarbohidratos,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                        ),
                        child: const Text(
                          "Calcular Carbohidratos",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown(
      String hint, String? selectedValue, Function(String?) onChanged) {
    return DropdownButtonFormField<String>(
      value: selectedValue,
      decoration: InputDecoration(
        labelText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        filled: true,
        fillColor: Colors.white,
      ),
      items: alimentos.map<DropdownMenuItem<String>>((alimento) {
        return DropdownMenuItem<String>(
          value: alimento["id_alimento"].toString(),
          child: Text(alimento["alimento"]),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
