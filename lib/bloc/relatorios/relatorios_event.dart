import 'package:equatable/equatable.dart';
import '../../models/relatorio_model.dart';

abstract class RelatorioEvent extends Equatable {
  const RelatorioEvent();

  @override
  List<Object?> get props => [];
}

class CarregarRelatorios extends RelatorioEvent {
  final String obraId;

  const CarregarRelatorios(this.obraId);

  @override
  List<Object?> get props => [obraId];
}

class AdicionarRelatorio extends RelatorioEvent {
  final Relatorio relatorio;

  const AdicionarRelatorio(this.relatorio);

  @override
  List<Object?> get props => [relatorio];
}
