class Obra {
  final String id;
  final String nome;
  final String status;
  final String cidade;
  final String bairro;
  final String? imagemPath;
  final List<String> fotosPaths;

  Obra({
    required this.id,
    required this.nome,
    required this.status,
    required this.cidade,
    required this.bairro,
    this.imagemPath,
    this.fotosPaths = const [],
  });

  // Para edição
  Obra copyWith({
    String? id,
    String? nome,
    String? status,
    String? cidade,
    String? bairro,
    String? imagemPath,
    List<String>? fotosPaths,
  }) {
    return Obra(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      status: status ?? this.status,
      cidade: cidade ?? this.cidade,
      bairro: bairro ?? this.bairro,
      imagemPath: imagemPath ?? this.imagemPath,
      fotosPaths: fotosPaths ?? this.fotosPaths,
    );
  }
}
