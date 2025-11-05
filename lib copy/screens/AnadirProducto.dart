import 'package:flutter/material.dart';
import 'ProductoModel.dart';

class AnadirProducto extends StatefulWidget {
  const AnadirProducto({super.key});

  @override
  State<AnadirProducto> createState() => _AnadirProductoState();
}

class _AnadirProductoState extends State<AnadirProducto> {
  List<Producto> get productosSeleccionados =>
      productosCreados.where((p) => p.cantidad > 0).toList();

  void eliminarProducto(Producto producto) {
    setState(() {
      producto.cantidad = 0;
    });
  }

  void confirmarPedido() {
    pedidosConfirmados.clear();

    for (var producto in productosSeleccionados) {
      pedidosConfirmados.add(
        Pedido(
          nombre: producto.nombre,
          precioUnitario: producto.precio,
          cantidad: producto.cantidad,
        ),
      );
      producto.cantidad = 0;
    }

    setState(() {});

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Pedido confirmado')),
    );
  }

  int get totalCantidad =>
      productosSeleccionados.fold(0, (sum, p) => sum + p.cantidad);

  double get totalPrecio =>
      productosSeleccionados.fold(0, (sum, p) => sum + (p.precio * p.cantidad));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.orange[700],
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Productos añadidos', style: TextStyle(color: Colors.white)),
      ),
      body: productosSeleccionados.isEmpty
          ? const Center(
              child: Text(
                'No has seleccionado productos',
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
              itemCount: productosSeleccionados.length,
              itemBuilder: (context, index) {
                final producto = productosSeleccionados[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.image, color: Colors.grey),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(producto.nombre,
                                  style: const TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.bold)),
                              const SizedBox(height: 4),
                              Text('Precio \$${producto.precio.toStringAsFixed(2)}',
                                  style: const TextStyle(color: Colors.black87)),
                              const SizedBox(height: 4),
                              const Text(
                                'Breve descripción del producto...',
                                style: TextStyle(color: Colors.grey),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Cantidad por unidad',
                                style: TextStyle(fontSize: 13, color: Colors.blueGrey),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.remove_circle_outline),
                                    onPressed: () {
                                      setState(() {
                                        if (producto.cantidad > 0) {
                                          producto.cantidad--;
                                        }
                                      });
                                    },
                                  ),
                                  Container(
                                    width: 30,
                                    alignment: Alignment.center,
                                    child: Text('${producto.cantidad}'),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.add_circle_outline),
                                    onPressed: () {
                                      setState(() {
                                        producto.cantidad++;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => eliminarProducto(producto),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      bottomSheet: productosSeleccionados.isEmpty
          ? null
          : Container(
              color: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '$totalCantidad Confirmar',
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  ElevatedButton(
                    onPressed: confirmarPedido,
                    style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 0, 0, 0)),
                    child: Text(
                      '\$${totalPrecio.toStringAsFixed(2)}',
                      style: const TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
