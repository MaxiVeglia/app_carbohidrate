import 'package:flutter/material.dart';

class CalculoTotal extends StatefulWidget {
  final double hcCalcular;
  final double hcCalcular1;
  final double hcCalcular2;
  final double hcCalcular3;
  final double hcCalcular4;
  final double hcCalcular5;
  final double hcCalcular6;
  final double hcCalcular7;

  const CalculoTotal({
    super.key,
    required this.hcCalcular,
    required this.hcCalcular1,
    required this.hcCalcular2,
    required this.hcCalcular3,
    required this.hcCalcular4,
    required this.hcCalcular5,
    required this.hcCalcular6,
    required this.hcCalcular7,
  });

  @override
  _CalculoTotalState createState() => _CalculoTotalState();
}

class _CalculoTotalState extends State<CalculoTotal> {
  double totalCarbohidratos = 0;

  @override
  void initState() {
    super.initState();
    _sumarCarbohidratos();
  }

  void _sumarCarbohidratos() {
    setState(() {
      totalCarbohidratos = widget.hcCalcular +
          widget.hcCalcular1 +
          widget.hcCalcular2 +
          widget.hcCalcular3 +
          widget.hcCalcular4 +
          widget.hcCalcular5 +
          widget.hcCalcular6 +
          widget.hcCalcular7;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Total de Carbohidratos"),
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
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                title: const Text("Carbohidratos Totales",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                trailing: Text("${totalCarbohidratos.toStringAsFixed(2)} g",
                    style: const TextStyle(fontSize: 16, color: Colors.teal)),
              ),
            ),
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
}
