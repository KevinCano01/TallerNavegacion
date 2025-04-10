import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hola_mundo/models/establecimiento.dart';
import 'package:hola_mundo/services/establecimiento_service.dart';
import 'package:image_picker/image_picker.dart';

class EstablecimientoCreateView extends StatefulWidget {
  const EstablecimientoCreateView({super.key});

  @override
  State<EstablecimientoCreateView> createState() =>
      _EstablecimientoCreateViewState();
}

class _EstablecimientoCreateViewState extends State<EstablecimientoCreateView> {
  // Clave global para el formulario
  final _formKey = GlobalKey<FormState>();
  // Servicio para interactuar con la API de establecimientos
  final _service = EstablecimientoService();

  // Controladores para los campos del formulario
  final _nombreController = TextEditingController();
  final _nitController = TextEditingController();
  final _direccionController = TextEditingController();
  final _telefonoController = TextEditingController();

  // Variable para manejar el logo del establecimiento
  File? _logoFile;

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

  // Método para enviar los datos del formulario y crear el establecimiento
  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      // Crear el objeto Establecimiento con los datos del formulario
      final est = Establecimiento(
        id: 0, // No se usa para creación
        nombre: _nombreController.text,
        nit: _nitController.text,
        direccion: _direccionController.text,
        telefono: _telefonoController.text,
        logo: '',
        estado: 'A',
      );

      // Llamada al servicio para crear el establecimiento
      final ok = await _service.createEstablecimiento(est, logoFile: _logoFile);

      if (!mounted) return;

      // Verificar si la creación fue exitosa
      if (ok) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Establecimiento creado')));
        context.pop(true); // Regresar y actualizar la lista
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al crear establecimiento')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nuevo Establecimiento')),
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
              // Opción para seleccionar el logo (opcional)
              const Text('Logo (opcional):'),
              const SizedBox(height: 8),
              _logoFile != null
                  ? Image.file(
                    _logoFile!,
                    height: 120,
                  ) // Mostrar la imagen seleccionada
                  : const Text('No hay imagen seleccionada'),
              TextButton.icon(
                onPressed: _pickImage,
                icon: const Icon(Icons.image),
                label: const Text('Seleccionar logo'),
              ),
              const SizedBox(height: 20),
              // Botón para enviar el formulario y crear el establecimiento
              ElevatedButton(
                onPressed: _submit,
                child: const Text('Crear Establecimiento'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
