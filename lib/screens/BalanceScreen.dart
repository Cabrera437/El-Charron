import 'package:flutter/material.dart';

class BalanceScreen extends StatefulWidget {
  const BalanceScreen({super.key});

  @override
  State<BalanceScreen> createState() => _BalanceScreenState();
}

class _BalanceScreenState extends State<BalanceScreen> {
  bool mostrarIngresos = true;

  final List<Map<String, dynamic>> ingresos = [];
  final List<Map<String, dynamic>> egresos = [];

  final TextEditingController nombreCtrl = TextEditingController();
  final TextEditingController fechaCtrl = TextEditingController();
  final TextEditingController montoCtrl = TextEditingController();

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
        title: const Text(
          'Balance General',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: ingresos.isEmpty && egresos.isEmpty
          ? _buildEmptyState()
          : SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  _buildBalanceCard(),
                  const SizedBox(height: 10),
                  _buildTabs(),
                  _buildInputForm(),
                  const SizedBox(height: 10),
                  _buildMovimientosList(),
                ],
              ),
            ),
    );
  }

  /// 🟠 Estado vacío
  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.inbox_outlined, size: 100, color: Colors.grey),
            const SizedBox(height: 20),
            const Text(
              "No tienes registros aún",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              "Agrega tus ingresos o egresos para ver el balance general",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                // Simula abrir el formulario de ingreso directamente
                _showFormDialog(context);
              },
              child: const Text("Agregar registro",
                  style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  /// 💰 Tarjeta del balance
  Widget _buildBalanceCard() {
    double totalIngresos = ingresos.fold(0, (sum, item) => sum + item['monto']);
    double totalEgresos = egresos.fold(0, (sum, item) => sum + item['monto']);
    double balance = totalIngresos - totalEgresos;

    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(horizontal: 12),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Balance',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text('\$${balance.toStringAsFixed(2)}',
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    const Text('Ingresos',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('\$${totalIngresos.toStringAsFixed(2)}'),
                  ],
                ),
                Column(
                  children: [
                    const Text('Egresos',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('\$${totalEgresos.toStringAsFixed(2)}'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// 🧾 Pestañas de ingresos/egresos
  Widget _buildTabs() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => mostrarIngresos = true),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: mostrarIngresos ? Colors.white : Colors.grey.shade300,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(5),
                    bottomLeft: Radius.circular(5),
                  ),
                ),
                child: Center(
                  child: Text(
                    'Ingresos',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: mostrarIngresos ? Colors.black : Colors.black54,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => mostrarIngresos = false),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: mostrarIngresos ? Colors.grey.shade300 : Colors.white,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                  ),
                ),
                child: Center(
                  child: Text(
                    'Egresos',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: mostrarIngresos ? Colors.black54 : Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 🧮 Formulario simple
  Widget _buildInputForm() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          TextField(
            controller: nombreCtrl,
            decoration: const InputDecoration(
              labelText: 'Nombre del producto o gasto',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: fechaCtrl,
            decoration: const InputDecoration(
              labelText: 'Fecha (ej: 15/10/2025)',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: montoCtrl,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Monto en \$',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  if (nombreCtrl.text.isNotEmpty &&
                      fechaCtrl.text.isNotEmpty &&
                      montoCtrl.text.isNotEmpty) {
                    setState(() {
                      ingresos.add({
                        'nombre': nombreCtrl.text,
                        'fecha': fechaCtrl.text,
                        'monto': double.tryParse(montoCtrl.text) ?? 0,
                      });
                      nombreCtrl.clear();
                      fechaCtrl.clear();
                      montoCtrl.clear();
                    });
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                icon: const Icon(Icons.add),
                label: const Text('Agregar ingreso'),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  if (nombreCtrl.text.isNotEmpty &&
                      fechaCtrl.text.isNotEmpty &&
                      montoCtrl.text.isNotEmpty) {
                    setState(() {
                      egresos.add({
                        'nombre': nombreCtrl.text,
                        'fecha': fechaCtrl.text,
                        'monto': double.tryParse(montoCtrl.text) ?? 0,
                      });
                      nombreCtrl.clear();
                      fechaCtrl.clear();
                      montoCtrl.clear();
                    });
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                icon: const Icon(Icons.remove),
                label: const Text('Agregar egreso'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 📋 Lista de movimientos
  Widget _buildMovimientosList() {
    final lista = mostrarIngresos ? ingresos : egresos;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: lista.isEmpty
            ? [
                const Padding(
                  padding: EdgeInsets.all(20),
                  child: Text('No hay datos aún'),
                )
              ]
            : lista
                .map(
                  (item) => Card(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: const BorderSide(color: Colors.black54),
                    ),
                    child: ListTile(
                      title: Text(item['nombre']),
                      subtitle: Text(item['fecha']),
                      trailing: Text(
                        '\$${(item['monto'] as double).toStringAsFixed(2)}',
                      ),
                    ),
                  ),
                )
                .toList(),
      ),
    );
  }

  /// 🧾 Muestra un formulario emergente (opcional)
  void _showFormDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Nuevo registro"),
        content: _buildInputForm(),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cerrar"),
          ),
        ],
      ),
    );
  }
}
