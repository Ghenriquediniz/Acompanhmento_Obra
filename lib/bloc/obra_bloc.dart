import 'package:flutter_bloc/flutter_bloc.dart';
import 'obra_event.dart';
import 'obra_state.dart';
import '../models/obra_model.dart';
import 'package:uuid/uuid.dart'; // para gerar ID único

class ObraBloc extends Bloc<ObraEvent, ObraState> {
  final List<Obra> _obras = [];

  ObraBloc() : super(ObraInicial()) {
    on<CarregarObras>((event, emit) {
      emit(ObrasCarregadas(List.from(_obras)));
    });

    on<AdicionarObra>((event, emit) {
      final novaObra = Obra(
        id: const Uuid().v4(), // gera ID único
        nome: event.nome,
        cidade: event.cidade,
        bairro: event.bairro,
        status: event.status,
        imagemPath: event.imagemPath,
      );
      _obras.add(novaObra);
      emit(ObrasCarregadas(List.from(_obras)));
    });

    on<AtualizarObra>((event, emit) {
      final index = _obras.indexWhere(
        (obra) => obra.id == event.obraAtualizada.id,
      );
      if (index != -1) {
        _obras[index] = event.obraAtualizada;
        emit(ObrasCarregadas(List.from(_obras)));
      }
    });
  }
}
