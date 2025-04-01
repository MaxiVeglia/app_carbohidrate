import 'package:flutter/material.dart';

class Calcular2 extends StatefulWidget {
  final Map<String, List<String>> alimentosPorSeccion;
  final Map<String, List<double>> cantidadesPorSeccion;
  final double hcTotal;

  const Calcular2({
    super.key,
    required this.alimentosPorSeccion,
    required this.cantidadesPorSeccion,
    required this.hcTotal,
    required alimento1,
    required String alimento2,
    required double cantidad1,
    required double cantidad2,
    required List cantidades,
    required double glucemia,
    required List alimentosSeleccionados,
  });

  @override
  _Calcular2State createState() => _Calcular2State();
}

class _Calcular2State extends State<Calcular2> {
  Map<String, List<String>> alimentosAcumulados = {};
  Map<String, List<double>> cantidadesAcumuladas = {};
  double hcAcumulado = 0;

  @override
  void initState() {
    super.initState();
    _acumularDatos();
  }

  void _acumularDatos() {
    setState(() {
      hcAcumulado = widget.hcTotal;

      widget.alimentosPorSeccion.forEach((seccion, alimentos) {
        if (!alimentosAcumulados.containsKey(seccion)) {
          alimentosAcumulados[seccion] = [];
          cantidadesAcumuladas[seccion] = [];
        }

        for (int i = 0; i < alimentos.length; i++) {
          alimentosAcumulados[seccion]!.add(alimentos[i]);
          double hc = widget.cantidadesPorSeccion[seccion]![i];
          cantidadesAcumuladas[seccion]!.add(hc);
          hcAcumulado += hc;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Resultados del Cálculo"),
        backgroundColor: Colors.teal,
        centerTitle: true,
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (var seccion in alimentosAcumulados.keys) ...[
              Text("Sección: $seccion",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
              for (int i = 0;
                  i < alimentosAcumulados[seccion]!.length;
                  i++) ...[
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${alimentosAcumulados[seccion]![i]}",
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        Text(
                            "Cantidad: ${cantidadesAcumuladas[seccion]![i]} gramos",
                            style: const TextStyle(
                                fontSize: 16, color: Colors.black54)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
              const SizedBox(height: 20),
            ],
            _buildInfoCard("Total HC", "${hcAcumulado.toStringAsFixed(2)} g"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: const Text("Regresar", style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, String value) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        trailing: Text(value,
            style: const TextStyle(fontSize: 16, color: Colors.teal)),
      ),
    );
  }
}
