import 'package:flutter/material.dart';
import 'package:hola_mundo/models/establecimiento.dart';
import 'package:hola_mundo/services/establecimiento_service.dart';
import 'package:go_router/go_router.dart';
import 'package:hola_mundo/views/base_view.dart';

class EstablecimientosListView extends StatefulWidget {
  const EstablecimientosListView({super.key});

  @override
  EstablecimientosListViewState createState() =>
      EstablecimientosListViewState();
}

class EstablecimientosListViewState extends State<EstablecimientosListView> {
  // Servicio que maneja la obtención, creación, actualización y eliminación de establecimientos
  final EstablecimientoService _service = EstablecimientoService();

  // Variable para almacenar la lista de establecimientos que se obtiene de la API
  late Future<List<Establecimiento>> _future;

  @override
  void initState() {
    super.initState();
    // Cargar la lista de establecimientos cuando la vista se inicializa
    _future = _service.getEstablecimientos();
  }

  // Método para navegar a la pantalla de edición de un establecimiento
  Future<void> _goToEdit(int id) async {
    final result = await context.push('/establecimientos/edit/$id');
    if (!mounted) return;
    if (result == true) {
      setState(() {
        _future =
            _service
                .getEstablecimientos(); // Recarga la lista de establecimientos
      });
    }
  }

  // Método para eliminar un establecimiento de la lista
  Future<void> _deleteEstablecimiento(int id) async {
    bool eliminado = await _service.deleteEstablecimiento(id);
    if (eliminado) {
      // Mostrar mensaje de éxito
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Establecimiento eliminado correctamente')),
      );
      setState(() {
        _future =
            _service
                .getEstablecimientos(); // Recargar la lista después de la eliminación
      });
    } else {
      // Mostrar mensaje de error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al eliminar el establecimiento')),
      );
    }
  }

  // Método para navegar a la pantalla de creación de un nuevo establecimiento
  Future<void> _goToCreate() async {
    final result = await context.push('/establecimientos/create');
    if (!mounted) return;
    if (result == true) {
      setState(() {
        _future =
            _service
                .getEstablecimientos(); // Recargar la lista después de la creación
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      title: 'Establecimientos', // Título de la vista
      initialIndex: 0,
      length: 1,
      body: FutureBuilder<List<Establecimiento>>(
        future: _future, // Cargar los establecimientos
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            ); // Mostrar cargando
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            ); // Manejo de error
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text('No hay establecimientos disponibles'),
            ); // Si no hay datos
          }

          return ListView.builder(
            itemCount: snapshot.data!.length, // Contar los establecimientos
            itemBuilder: (context, index) {
              final establecimiento = snapshot.data![index];
              return Card(
                margin: EdgeInsets.all(12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Mostrar logo del establecimiento
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child:
                            establecimiento.logo?.isNotEmpty ?? false
                                ? Image.network(
                                  '${_service.baseUrlImg}${establecimiento.logo}',
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                )
                                : Icon(Icons.image_not_supported, size: 80),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Nombre del establecimiento
                            Text(
                              establecimiento.nombre,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            // Mostrar NIT, Dirección y Teléfono
                            Text('NIT: ${establecimiento.nit}'),
                            Text('Dirección: ${establecimiento.direccion}'),
                            Text('Teléfono: ${establecimiento.telefono}'),
                          ],
                        ),
                      ),
                      // Botón para editar el establecimiento
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.blue),
                        onPressed: () => _goToEdit(establecimiento.id),
                      ),
                      // Botón para eliminar el establecimiento
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed:
                            () => _deleteEstablecimiento(establecimiento.id),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      // Botón flotante para crear un nuevo establecimiento
      floatingActionButton: FloatingActionButton(
        onPressed: _goToCreate,
        child: Icon(Icons.add),
      ),
    );
  }
}
