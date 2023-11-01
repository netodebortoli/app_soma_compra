import 'package:app_soma_conta/domain/Objeto.dart';

class Grupo extends Objeto {
  late String descricao;
  double? valorTotal = 0;

  Grupo({required this.descricao, this.valorTotal});

  Grupo.fromMapToEntity(Map<String, dynamic> map) : super.fromMapToEntity(map) {
    descricao = map["descricao"];
    valorTotal = map["valorTotal"];
  }
}
