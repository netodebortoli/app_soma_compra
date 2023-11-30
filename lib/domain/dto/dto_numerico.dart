class DtoNumerico {

  late int chave;
  late double valor;

  DtoNumerico(this.chave, this.valor);

  DtoNumerico.fromMapToDtoNumerico(Map<String, dynamic> map) {
    chave = int.parse(map["chave"]);
    valor = map["valor"];
  }
}
