import 'package:flutter_bloc/flutter_bloc.dart';
import '../relatorios/relatorios_event.dart';
import '../relatorios/relatorios_state.dart';
import '../../models/relatorio_model.dart';

class RelatorioBloc extends Bloc<RelatorioEvent, RelatorioState> {
  final List<Relatorio> _relatorios = [];

  RelatorioBloc() : super(RelatorioInicial()) {
    on<CarregarRelatorios>((event, emit) {
      emit(RelatorioCarregando());
      final rels = _relatorios.where((r) => r.obraId == event.obraId).toList();
      emit(RelatorioCarregado(rels));
    });

    on<AdicionarRelatorio>((event, emit) {
      _relatorios.add(event.relatorio);
      final rels =
          _relatorios.where((r) => r.obraId == event.relatorio.obraId).toList();
      emit(RelatorioCarregado(rels));
    });
    on<EditarRelatorio>((event, emit) {
      final index = _relatorios.indexWhere(
        (r) => r.id == event.relatorioEditado.id,
      );
      if (index != -1) {
        _relatorios[index] = event.relatorioEditado;
        emit(RelatorioCarregado(List.from(_relatorios)));
      }
    });
  }
}
