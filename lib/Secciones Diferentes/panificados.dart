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

  void calcularCarbohidratos() async {
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
      mostrarMensaje("Ingresa valores numéricos válidos.");
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

    // Mostrar el diálogo de carga
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    // Simular un tiempo de espera antes de calcular
    await Future.delayed(const Duration(seconds: 1, milliseconds: 500));

    double porcionGramos = double.parse(alimento["porcion_gr"].toString());
    double hcPorPorcion = double.parse(alimento["HC_gr"].toString());

    hcTotal = (gramos / porcionGramos) * hcPorPorcion;

    Navigator.pop(context); // Cierra el diálogo de carga

    // Navegar a la pantalla de cálculo
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Calcular6(
          alimento1: alimento["alimento"],
          alimento2: "",
          cantidad1: gramos,
          cantidad2: 0.0,
          hcTotal: hcTotal,
          alimentosSeleccionados: [],
          cantidades: [],
          alimentosPorSeccion: {},
          cantidadesPorSeccion: {},
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
      backgroundColor: const Color(0xFFDDEAE3),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1F4D57),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text("Cereales", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildDropdown("Selecciona un alimento", alimentoSeleccionado,
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
                labelText: "Ingresa la cantidad (gramos)",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: calcularCarbohidratos,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1F4D57),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              child: const Text(
                "Calcular",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
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
