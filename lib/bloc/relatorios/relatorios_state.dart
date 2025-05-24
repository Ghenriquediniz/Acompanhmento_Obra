import 'package:equatable/equatable.dart';
import '../../models/relatorio_model.dart';

abstract class RelatorioState extends Equatable {
  const RelatorioState();

  @override
  List<Object?> get props => [];
}

class RelatorioInicial extends RelatorioState {}

class RelatorioCarregando extends RelatorioState {}

class RelatorioCarregado extends RelatorioState {
  final List<Relatorio> relatorios;

  const RelatorioCarregado(this.relatorios);

  @override
  List<Object?> get props => [relatorios];
}

class RelatorioErro extends RelatorioState {
  final String mensagem;

  const RelatorioErro(this.mensagem);

  @override
  List<Object?> get props => [mensagem];
}
