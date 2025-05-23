class Obra {
  final String id;
  final String nome;
  final String status;
  final String cidade;
  final String bairro;
  final String? imagemPath;

  Obra({
    required this.id,
    required this.nome,
    required this.status,
    required this.cidade,
    required this.bairro,
    this.imagemPath,
  });

  // Para edição
  Obra copyWith({
    String? id,
    String? nome,
    String? status,
    String? cidade,
    String? bairro,
    String? imagemPath,
  }) {
    return Obra(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      status: status ?? this.status,
      cidade: cidade ?? this.cidade,
      bairro: bairro ?? this.bairro,
      imagemPath: imagemPath ?? this.imagemPath,
    );
  }
}
