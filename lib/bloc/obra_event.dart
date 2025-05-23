import '../models/obra_model.dart';

abstract class ObraEvent {}

class CarregarObras extends ObraEvent {}

class AdicionarObra extends ObraEvent {
  final String nome;
  final String status;
  final String? imagemPath;
  final String cidade;
  final String bairro;

  AdicionarObra({
    required this.nome,
    required this.status,
    this.imagemPath,
    required this.bairro,
    required this.cidade,
  });
}

class AtualizarObra extends ObraEvent {
  final Obra obraAtualizada;

  AtualizarObra(this.obraAtualizada);
}
