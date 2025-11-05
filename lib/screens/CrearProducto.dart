import 'package:flutter/material.dart';
import 'ProductoModel.dart';
import 'MenuPantalla.dart';

class CrearProducto extends StatefulWidget {
  const CrearProducto({super.key});

  @override
  State<CrearProducto> createState() => _CrearProductoState();
}

class _CrearProductoState extends State<CrearProducto> {
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController precioController = TextEditingController();
  String? categoriaSeleccionada;

  final List<String> categorias = ['Plato fuerte', 'Bebida', 'Postre'];

  void guardarProducto() {
    final nombre = nombreController.text.trim();
    final precio = double.tryParse(precioController.text.trim()) ?? 0;

    if (nombre.isNotEmpty && categoriaSeleccionada != null) {
      productosCreados.add(
        Producto(
          nombre: nombre,
          precio: precio,
          categoria: categoriaSeleccionada!,
          cantidad: 0, // ✅ Inicializamos cantidad en 0
        ),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MenuPantalla()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Completa todos los campos')),
      );
    }
  }

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
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 160,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade400),
                ),
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.image_outlined, color: Colors.grey, size: 40),
                      SizedBox(height: 8),
                      Text('Cargar imagen', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const Text('Nombre del producto', style: TextStyle(fontSize: 16)),
              const SizedBox(height: 8),
              TextField(controller: nombreController),
              const SizedBox(height: 20),
              const Text('Precio', style: TextStyle(fontSize: 16)),
              const SizedBox(height: 8),
              TextField(controller: precioController, keyboardType: TextInputType.number),
              const SizedBox(height: 20),
              const Text('Categoría', style: TextStyle(fontSize: 16)),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: categoriaSeleccionada,
                items: categorias
                    .map((cat) => DropdownMenuItem(value: cat, child: Text(cat)))
                    .toList(),
                onChanged: (value) => setState(() {
                  categoriaSeleccionada = value;
                }),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: guardarProducto,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                  child: const Text('Crear producto', style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
