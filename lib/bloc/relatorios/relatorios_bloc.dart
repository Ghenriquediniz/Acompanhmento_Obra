import 'package:flutter_bloc/flutter_bloc.dart';
import './relatorios_event.dart';
import 'relatorios_state.dart';
import '../../models/relatorio_model.dart';

class RelatorioBloc extends Bloc<RelatorioEvent, RelatorioState> {
  final List<Relatorio> _relatorios = [];

  RelatorioBloc() : super(RelatorioInicial()) {
    on<CarregarRelatorios>(_onCarregarRelatorios);
    on<AdicionarRelatorio>(_onAdicionarRelatorio);
  }

  void _onCarregarRelatorios(
    CarregarRelatorios event,
    Emitter<RelatorioState> emit,
  ) async {
    emit(RelatorioCarregando());
    try {
      // Aqui você pode buscar os relatórios de um repositório ou serviço
      // Por enquanto, vamos simular com uma lista vazia
      emit(RelatorioCarregado(_relatorios));
    } catch (e) {
      emit(RelatorioErro('Erro ao carregar relatórios'));
    }
  }

  void _onAdicionarRelatorio(
    AdicionarRelatorio event,
    Emitter<RelatorioState> emit,
  ) async {
    _relatorios.add(event.relatorio);
    emit(RelatorioCarregado(List.from(_relatorios)));
  }
}
