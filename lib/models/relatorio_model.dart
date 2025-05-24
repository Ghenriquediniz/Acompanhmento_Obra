class Relatorio {
  final String id;
  final String obraId;
  final DateTime data;
  final String tipoMaoDeObra;
  final String comentario;
  final List<String> fotos;
  final String? videoUrl;

  Relatorio({
    required this.id,
    required this.obraId,
    required this.data,
    required this.tipoMaoDeObra,
    required this.comentario,
    required this.fotos,
    this.videoUrl,
  });

  // Para usar no Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'obraId': obraId,
      'data': data.toIso8601String(),
      'tipoMaoDeObra': tipoMaoDeObra,
      'comentario': comentario,
      'fotos': fotos,
      'videoUrl': videoUrl,
    };
  }

  factory Relatorio.fromMap(Map<String, dynamic> map) {
    return Relatorio(
      id: map['id'],
      obraId: map['obraId'],
      data: DateTime.parse(map['data']),
      tipoMaoDeObra: map['tipoMaoDeObra'],
      comentario: map['comentario'],
      fotos: List<String>.from(map['fotos'] ?? []),
      videoUrl: map['videoUrl'],
    );
  }
}
