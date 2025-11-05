import 'package:flutter/material.dart';
import 'ProductoModel.dart';
import 'AnadirProducto.dart';
import 'CrearProducto.dart';

class MenuPantalla extends StatefulWidget {
  const MenuPantalla({super.key});

  @override
  State<MenuPantalla> createState() => _MenuPantallaState();
}

class _MenuPantallaState extends State<MenuPantalla> {
  @override
  Widget build(BuildContext context) {
    final bool hayContenido = productosCreados.isNotEmpty;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // 🔶 Encabezado naranja
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              color: Colors.orange[700],
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: const CircleAvatar(
                      radius: 24,
                      backgroundImage: AssetImage('assets/Icono.jpeg'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'El Charron',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      Text('Administrador', style: TextStyle(fontSize: 14, color: Colors.white70)),
                    ],
                  ),
                ],
              ),
            ),

            // 🧾 Contenido dinámico
            Expanded(
              child: hayContenido
                  ? ListView.builder(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 50),
                      itemCount: productosCreados.length,
                      itemBuilder: (context, index) {
                        final reversedList = productosCreados.reversed.toList();
                        final producto = reversedList[index];
                        final bool esUltimo = index == reversedList.length - 1;

                        return Padding(
                          padding: EdgeInsets.only(bottom: esUltimo ? 30 : 0),
                          child: ProductoCard(producto: producto),
                        );
                      },
                    )
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.info_outline, size: 60, color: Colors.grey),
                          SizedBox(height: 20),
                          Text(
                            'No tienes productos creados',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Comienza agregando un nuevo producto\nasí organizarás tus ventas a futuro.',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 14, color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),

      // 🟦🟩 Botones flotantes
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton.extended(
              heroTag: 'crear',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CrearProducto()),
                ).then((_) => setState(() {}));
              },
              backgroundColor: Colors.blue,
              icon: const Icon(Icons.add),
              label: const Text('Crear producto'),
            ),
            FloatingActionButton.extended(
              heroTag: 'añadir',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AnadirProducto()),
                ).then((_) => setState(() {}));
              },
              backgroundColor: Colors.green,
              icon: const Icon(Icons.playlist_add),
              label: const Text('Añadir producto'),
            ),
          ],
        ),
      ),

      // 🚀 Barra inferior
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          boxShadow: const [
            BoxShadow(color: Color.fromARGB(62, 0, 0, 0), blurRadius: 3, offset: Offset(0, -5)),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: NavigationBar(
            backgroundColor: Colors.white,
            elevation: 0,
            destinations: const [
              NavigationDestination(icon: ImageIcon(AssetImage('assets/Balance.png')), label: 'Balance'),
              NavigationDestination(icon: ImageIcon(AssetImage('assets/menu.png')), label: 'Menú'),
              NavigationDestination(icon: ImageIcon(AssetImage('assets/gastos.png')), label: 'Gastos'),
            ],
            selectedIndex: 1,
            onDestinationSelected: (int index) {
              // navegación futura
            },
          ),
        ),
      ),
    );
  }
}

// 🧱 Tarjeta visual del producto
class ProductoCard extends StatefulWidget {
  final Producto producto;

  const ProductoCard({super.key, required this.producto});

  @override
  State<ProductoCard> createState() => _ProductoCardState();
}

class _ProductoCardState extends State<ProductoCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
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
                  Text(widget.producto.nombre,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text('\$${widget.producto.precio.toStringAsFixed(2)}',
                      style: const TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove_circle_outline),
                  onPressed: () {
                    setState(() {
                      if (widget.producto.cantidad > 0) {
                        widget.producto.cantidad--;
                      }
                    });
                  },
                ),
                Container(
                  width: 30,
                  alignment: Alignment.center,
                  child: Text('${widget.producto.cantidad}'),
                ),
                IconButton(
                  icon: const Icon(Icons.add_circle_outline),
                  onPressed: () {
                    setState(() {
                      widget.producto.cantidad++;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
