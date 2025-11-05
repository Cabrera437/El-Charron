class Producto {
  final String nombre;
  final double precio;
  final String categoria;
  int cantidad;

  Producto({
    required this.nombre,
    required this.precio,
    required this.categoria,
    this.cantidad = 0,
  });
}

List<Producto> productosCreados = [];

class Pedido {
  final String nombre;
  final double precioUnitario;
  final int cantidad;
  final double total;

  Pedido({
    required this.nombre,
    required this.precioUnitario,
    required this.cantidad,
  }) : total = precioUnitario * cantidad;
}

List<Pedido> pedidosConfirmados = [];



