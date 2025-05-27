import '../../models/relatorio_model.dart';

abstract class RelatorioState {}

class RelatorioInicial extends RelatorioState {}

class RelatorioCarregando extends RelatorioState {}

class RelatorioCarregado extends RelatorioState {
  final List<Relatorio> relatorios;
  RelatorioCarregado(this.relatorios);
}

class RelatorioErro extends RelatorioState {
  final String mensagem;
  RelatorioErro(this.mensagem);
}
