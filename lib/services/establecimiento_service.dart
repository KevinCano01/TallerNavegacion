import 'dart:convert';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:hola_mundo/models/establecimiento.dart';

class EstablecimientoService {
  // Carga las variables de entorno desde el archivo .env
  final String baseUrl = dotenv.env['URL_API']!;
  final String baseUrlImg = dotenv.env['URL_API_IMG']!;

  // Método para obtener la lista de establecimientos desde la API
  Future<List<Establecimiento>> getEstablecimientos() async {
    final response = await http.get(Uri.parse('${baseUrl}establecimientos'));
    if (response.statusCode == 200) {
      // Convierte la respuesta JSON a objetos Establecimiento
      final data = jsonDecode(response.body)['data'];
      return List<Establecimiento>.from(
        data.map((item) => Establecimiento.fromJson(item)),
      );
    } else {
      throw Exception('Error al cargar establecimientos');
    }
  }

  // Método para obtener un establecimiento específico por su ID
  Future<Establecimiento> getEstablecimiento(int id) async {
    final response = await http.get(
      Uri.parse('${baseUrl}establecimientos/$id'),
    );
    if (response.statusCode == 200) {
      // Convierte la respuesta JSON a un objeto Establecimiento
      final json = jsonDecode(response.body);
      return Establecimiento.fromJson(json['data']);
    } else {
      throw Exception('Error al obtener el establecimiento');
    }
  }

  // Método para eliminar un establecimiento a través de su ID
  Future<bool> deleteEstablecimiento(int id) async {
    try {
      final response = await http.delete(
        Uri.parse('${baseUrl}establecimientos/$id'),
      );
      return response.statusCode == 200;
    } catch (e) {
      throw Exception('Error al eliminar establecimiento: $e');
    }
  }

  // Método para crear un nuevo establecimiento en la API
  Future<bool> createEstablecimiento(
    Establecimiento est, {
    File? logoFile,
  }) async {
    try {
      final uri = Uri.parse('${baseUrl}establecimientos');

      // Si se selecciona una imagen, se codifica en base64
      String? base64Image;
      if (logoFile != null) {
        final imageBytes = await logoFile.readAsBytes();
        base64Image = base64Encode(imageBytes);
      }

      final body = jsonEncode(est.toJson(logoBase64: base64Image));
      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );
      return response.statusCode == 201;
    } catch (e) {
      throw Exception('Error al crear establecimiento: $e');
    }
  }

  // Método para actualizar un establecimiento existente en la API
  Future<bool> updateEstablecimiento(
    Establecimiento est, {
    File? logoFile,
  }) async {
    try {
      final uri = Uri.parse('${baseUrl}establecimiento-update/${est.id}');

      // Si se selecciona una imagen, se codifica en base64
      String? base64Image;
      if (logoFile != null) {
        final imageBytes = await logoFile.readAsBytes();
        base64Image = base64Encode(imageBytes);
      }

      final body = jsonEncode(est.toJson(logoBase64: base64Image));
      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      return response.statusCode == 200;
    } catch (e) {
      throw Exception('Error al actualizar establecimiento: $e');
    }
  }
}
