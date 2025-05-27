class Relatorio {
  final String id;
  final String obraId;
  final DateTime data;
  final String tipoMaoDeObra;
  final String comentario;
  final String relatorioN;
  final List<String> fotos;
  final String? videoUrl;

  Relatorio({
    required this.id,
    required this.obraId,
    required this.data,
    required this.tipoMaoDeObra,
    required this.comentario,
    required this.relatorioN,
    required this.fotos,
    this.videoUrl,
  });

  // Método de cópia para edição
  Relatorio copyWith({
    String? id,
    String? obraId,
    DateTime? data,
    String? tipoMaoDeObra,
    String? comentario,
    String? relatorioN,
    List<String>? fotos,
    String? videoUrl,
  }) {
    return Relatorio(
      id: id ?? this.id,
      obraId: obraId ?? this.obraId,
      data: data ?? this.data,
      tipoMaoDeObra: tipoMaoDeObra ?? this.tipoMaoDeObra,
      comentario: comentario ?? this.comentario,
      relatorioN: relatorioN ?? this.relatorioN,
      fotos: fotos ?? this.fotos,
      videoUrl: videoUrl ?? this.videoUrl,
    );
  }
}
