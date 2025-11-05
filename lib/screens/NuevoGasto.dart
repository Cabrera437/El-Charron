import 'package:flutter/material.dart';
import 'CrearProducto.dart';

class NuevoGasto extends StatefulWidget {
  const NuevoGasto({super.key});

  @override
  State<NuevoGasto> createState() => _NuevoGastoState();
}

class _NuevoGastoState extends State<NuevoGasto> {
  final TextEditingController fechaCtrl = TextEditingController();
  final TextEditingController valorCtrl = TextEditingController();
  String? categoriaSeleccionada;

  final List<String> categorias = [
    "Insumos",
    "Transporte",
    "Servicios",
    "Otro"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.orange[700],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Nuevo gasto",
            style: TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              color: Colors.grey.shade200,
              child: const Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.red),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "Podrás visualizar este gasto en tu dashboard.",
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: fechaCtrl,
              decoration: InputDecoration(
                labelText: "Fecha del gasto",
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2030),
                    );
                    if (picked != null) {
                      fechaCtrl.text =
                          "${picked.day}/${picked.month}/${picked.year}";
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: 15),
            DropdownButtonFormField<String>(
              value: categoriaSeleccionada,
              decoration: const InputDecoration(
                labelText: "Categoría del gasto",
                border: OutlineInputBorder(),
              ),
              items: categorias
                  .map((cat) =>
                      DropdownMenuItem(value: cat, child: Text(cat)))
                  .toList(),
              onChanged: (value) {
                setState(() => categoriaSeleccionada = value);
              },
            ),
            const SizedBox(height: 15),
            TextField(
              controller: valorCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Valor (\$)",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              color: Colors.grey.shade300,
              child: Text(
                "Valor total: \$${valorCtrl.text.isEmpty ? '0' : valorCtrl.text}",
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text("Gasto registrado exitosamente.")),
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const CrearProducto()),
                );
              },
              child: const Text("Crear gasto"),
            ),
          ],
        ),
      ),
    );
  }
}
