import 'package:app_soma_conta/domain/Objeto.dart';

class Grupo extends Objeto {
  late String descricao;
  double? valor_total = 0;

  Grupo({required this.descricao, this.valor_total});

  Grupo.fromMapToEntity(Map<String, dynamic> map) : super.fromMapToEntity(map) {
    descricao = map["descricao"];
    valor_total = map["valor_total"];
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Grupo &&
          runtimeType == other.runtimeType &&
          descricao == other.descricao;

  @override
  int get hashCode => descricao.hashCode;
}
