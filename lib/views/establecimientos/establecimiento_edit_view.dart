import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hola_mundo/models/establecimiento.dart';
import 'package:hola_mundo/services/establecimiento_service.dart';
import 'package:image_picker/image_picker.dart';

class EstablecimientoEditView extends StatefulWidget {
  final int id;

  const EstablecimientoEditView({super.key, required this.id});

  @override
  State<EstablecimientoEditView> createState() =>
      _EstablecimientoEditViewState();
}

class _EstablecimientoEditViewState extends State<EstablecimientoEditView> {
  // Clave global para el formulario
  final _formKey = GlobalKey<FormState>();

  // Servicio para obtener y actualizar los datos del establecimiento
  final _service = EstablecimientoService();

  // Controladores de texto para cada campo del formulario
  late TextEditingController _nombreController;
  late TextEditingController _nitController;
  late TextEditingController _direccionController;
  late TextEditingController _telefonoController;

  // Variables para manejar el logo del establecimiento y su carga
  File? _logoFile;
  String? _logoUrl;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadEstablecimiento();
  }

  // Método para cargar los datos del establecimiento desde la API
  Future<void> _loadEstablecimiento() async {
    try {
      final est = await _service.getEstablecimiento(widget.id);
      if (!mounted) return;

      setState(() {
        _nombreController = TextEditingController(text: est.nombre);
        _nitController = TextEditingController(text: est.nit);
        _direccionController = TextEditingController(text: est.direccion);
        _telefonoController = TextEditingController(text: est.telefono);
        _logoUrl = est.logo;
        _loading = false;
      });
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error cargando datos')));
      context.pop();
    }
  }

  // Método para seleccionar una imagen desde la galería
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (pickedFile != null) {
      setState(() {
        _logoFile = File(pickedFile.path);
      });
    }
  }

  // Método para enviar los datos del formulario y actualizar el establecimiento
  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      final est = Establecimiento(
        id: widget.id,
        nombre: _nombreController.text,
        nit: _nitController.text,
        direccion: _direccionController.text,
        telefono: _telefonoController.text,
        logo: _logoUrl ?? '',
        estado: 'A',
      );

      final ok = await _service.updateEstablecimiento(est, logoFile: _logoFile);

      if (!mounted) return;

      if (ok) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Establecimiento actualizado')));
        context.pop(true); // Regresar y actualizar la lista
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error actualizando')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) return const Center(child: CircularProgressIndicator());

    return Scaffold(
      appBar: AppBar(title: const Text('Editar Establecimiento')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Campo para ingresar el nombre del establecimiento
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator:
                    (value) => value!.isEmpty ? 'Campo obligatorio' : null,
              ),
              // Campo para ingresar el NIT del establecimiento
              TextFormField(
                controller: _nitController,
                decoration: const InputDecoration(labelText: 'NIT'),
                validator:
                    (value) => value!.isEmpty ? 'Campo obligatorio' : null,
              ),
              // Campo para ingresar la dirección del establecimiento
              TextFormField(
                controller: _direccionController,
                decoration: const InputDecoration(labelText: 'Dirección'),
                validator:
                    (value) => value!.isEmpty ? 'Campo obligatorio' : null,
              ),
              // Campo para ingresar el teléfono del establecimiento
              TextFormField(
                controller: _telefonoController,
                decoration: const InputDecoration(labelText: 'Teléfono'),
                validator:
                    (value) => value!.isEmpty ? 'Campo obligatorio' : null,
              ),
              const SizedBox(height: 16),
              // Mostrar el logo actual o permitir cambiarlo
              const Text('Logo actual:'),
              const SizedBox(height: 8),
              _logoFile != null
                  ? Image.file(_logoFile!, height: 120)
                  : _logoUrl != null
                  ? Image.network(
                    '${_service.baseUrlImg}$_logoUrl',
                    height: 120,
                  )
                  : const Text('No tiene logo'),
              TextButton.icon(
                onPressed: _pickImage,
                icon: const Icon(Icons.image),
                label: const Text('Cambiar logo'),
              ),
              const SizedBox(height: 20),
              // Botón para guardar los cambios
              ElevatedButton(
                onPressed: _submit,
                child: const Text('Guardar Cambios'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
