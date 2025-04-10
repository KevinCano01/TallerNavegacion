class Establecimiento {
  // Representa los atributos de un establecimiento.
  final int id;
  final String nombre;
  final String nit;
  final String direccion;
  final String telefono;
  final String? logo;
  final String estado;

  // Constructor que inicializa todos los atributos del establecimiento.
  Establecimiento({
    required this.id,
    required this.nombre,
    required this.nit,
    required this.direccion,
    required this.telefono,
    required this.logo,
    required this.estado,
  });

  // Método para crear un objeto Establecimiento desde un mapa JSON.
  factory Establecimiento.fromJson(Map<String, dynamic> json) {
    return Establecimiento(
      id: json['id'],
      nombre: json['nombre'],
      nit: json['nit'],
      direccion: json['direccion'],
      telefono: json['telefono'],
      logo: json['logo'],
      estado: json['estado'],
    );
  }

  // Método para convertir un objeto Establecimiento en un mapa JSON.
  Map<String, String> toJson({String? logoBase64}) {
    return {
      'nombre': nombre,
      'nit': nit,
      'direccion': direccion,
      'telefono': telefono,
      if (logoBase64 != null) 'logo': logoBase64,
    };
  }
}
