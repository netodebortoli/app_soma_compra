import 'package:app_soma_conta/domain/Objeto.dart';

class Grupo extends Objeto {
  String descricao;
  double? valorTotal = 0;

  Grupo({required this.descricao, this.valorTotal});
}
