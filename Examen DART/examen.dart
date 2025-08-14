import 'dart:io';

void main() {
  // Lista para almacenar los productos.
  List<Map<String, dynamic>> productos = [];
  bool salir = false;

  while (!salir) {
    print("\n--- MENÚ PRINCIPAL ---");
    print("1. Agregar producto");
    print("2. Listar productos");
    print("3. Actualizar producto");
    print("4. Eliminar producto");
    print("0. Salir");
    print("----------------------");
    stdout.write("Seleccione una opción: ");

    String? opcion = stdin.readLineSync();

    // Opciones del usuario
    switch (opcion) {
      case '1':
        agregarProducto(productos);
        break;
      case '2':
        listarProductos(productos);
        break;
      case '3':
        actualizarProducto(productos);
        break;
      case '4':
        eliminarProducto(productos);
        break;
      case '0':
        salir = true;
        print("\nGracias por usar el gestor de productos. ¡Hasta pronto!");
        break;
      default:
        print("\n[ERROR] Opción no válida. Por favor, intente de nuevo.");
    }
  }
}

// Agregar un nuevo producto a la lista.
void agregarProducto(List<Map<String, dynamic>> productos) {
  print("\n--- AGREGAR NUEVO PRODUCTO ---");

  // Solicitar nombre
  stdout.write("Nombre del producto: ");
  String? nombre = stdin.readLineSync();
  if (nombre == null || nombre.isEmpty) {
    print("\n[ERROR] El nombre no puede estar vacío.");
    return;
  }
  final RegExp soloLetras = RegExp(r'^[a-zA-Z\s]+$');
  if (!soloLetras.hasMatch(nombre)) {
    print("\n[ERROR] El nombre solo puede contener letras y espacios.");
    return;
  }

  // Solicitar precio
  stdout.write("Precio del producto: ");
  String? precioInput = stdin.readLineSync();
  double? precio = double.tryParse(precioInput ?? '');
  if (precio == null || precio < 0) {
    print("\n[ERROR] Precio no válido.");
    return;
  }

  // Solicitar cantidad
  stdout.write("Cantidad disponible: ");
  String? cantidadInput = stdin.readLineSync();
  int? cantidad = int.tryParse(cantidadInput ?? '');
  if (cantidad == null || cantidad < 0) {
    print("\n[ERROR] Cantidad no válida.");
    return;
  }

  // Crear el mapa del producto y agregarlo a la lista
  productos.add({'nombre': nombre, 'precio': precio, 'cantidad': cantidad});

  print("\n¡Producto '${nombre}' agregado con éxito!");
}

// Mostrar todos los productos en la lista.
void listarProductos(List<Map<String, dynamic>> productos) {
  print("\n--- LISTADO DE PRODUCTOS ---");
  if (productos.isEmpty) {
    print("No hay productos en el catálogo.");
    return;
  }

  for (int i = 0; i < productos.length; i++) {
    var producto = productos[i];
    print(
      "[$i] Nombre: ${producto['nombre']}, Precio: \$${producto['precio']}, Cantidad: ${producto['cantidad']}",
    );
  }
}

// Actualizar un producto existente.
void actualizarProducto(List<Map<String, dynamic>> productos) {
  if (productos.isEmpty) {
    print("\nNo hay productos para actualizar.");
    return;
  }

  print("\n--- ACTUALIZAR PRODUCTO ---");
  listarProductos(productos);
  stdout.write("\nIngrese el número del producto que desea actualizar: ");

  String? indexInput = stdin.readLineSync();
  int? index = int.tryParse(indexInput ?? '');

  if (index == null || index < 0 || index >= productos.length) {
    print("\n[ERROR] Número de producto no válido.");
    return;
  }

  var productoAActualizar = productos[index];
  print("Actualizando producto: '${productoAActualizar['nombre']}'");

  // Actualizar nombre
  stdout.write("Nuevo nombre (deje en blanco para no cambiar): ");
  String? nuevoNombre = stdin.readLineSync();
  if (nuevoNombre != null && nuevoNombre.isNotEmpty) {
    final RegExp soloLetras = RegExp(r'^[a-zA-Z\s]+$');
    if (soloLetras.hasMatch(nuevoNombre)) {
      productoAActualizar['nombre'] = nuevoNombre;
    } else {
      print(
        "[AVISO] Nombre no válido (solo letras y espacios), no se actualizó.",
      );
    }
  }

  // Actualizar precio
  stdout.write("Nuevo precio (deje en blanco para no cambiar): ");
  String? nuevoPrecioInput = stdin.readLineSync();
  if (nuevoPrecioInput != null && nuevoPrecioInput.isNotEmpty) {
    double? nuevoPrecio = double.tryParse(nuevoPrecioInput);
    if (nuevoPrecio != null && nuevoPrecio >= 0) {
      productoAActualizar['precio'] = nuevoPrecio;
    } else {
      print("[AVISO] Precio no válido, no se actualizó.");
    }
  }

  // Actualizar cantidad
  stdout.write("Nueva cantidad (deje en blanco para no cambiar): ");
  String? nuevaCantidadInput = stdin.readLineSync();
  if (nuevaCantidadInput != null && nuevaCantidadInput.isNotEmpty) {
    int? nuevaCantidad = int.tryParse(nuevaCantidadInput);
    if (nuevaCantidad != null && nuevaCantidad >= 0) {
      productoAActualizar['cantidad'] = nuevaCantidad;
    } else {
      print("[AVISO] Cantidad no válida, no se actualizó.");
    }
  }

  print("\n¡Producto actualizado con éxito!");
}

// Eliminar un producto de la lista.
void eliminarProducto(List<Map<String, dynamic>> productos) {
  if (productos.isEmpty) {
    print("\nNo hay productos para eliminar.");
    return;
  }

  print("\n--- ELIMINAR PRODUCTO ---");
  listarProductos(productos);
  stdout.write("\nIngrese el número del producto que desea eliminar: ");

  String? indexInput = stdin.readLineSync();
  int? index = int.tryParse(indexInput ?? '');

  if (index == null || index < 0 || index >= productos.length) {
    print("\n[ERROR] Número de producto no válido.");
    return;
  }

  var productoEliminado = productos.removeAt(index);
  print(
    "\n¡Producto '${productoEliminado['nombre']}' eliminado correctamente!",
  );
}
