import '../../models/obra_model.dart';

abstract class ObraState {}

class ObraInicial extends ObraState {}

class ObrasCarregando extends ObraState {}

class ObrasCarregadas extends ObraState {
  final List<Obra> obras;

  ObrasCarregadas(this.obras);
}

class ObraErro extends ObraState {
  final String mensagem;

  ObraErro(this.mensagem);
}
