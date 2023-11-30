class DtoOrdinal {

  late String chave;
  late double valor;

  DtoOrdinal(this.chave, this.valor);

  DtoOrdinal.fromMapToDtoOrdinal(Map<String, dynamic> map) {
      chave = map["chave"];
      valor = map["valor"];
  }
}
