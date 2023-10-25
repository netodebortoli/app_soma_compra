class ItemCompra {
  late double valor;
  late String descricao;
  DateTime? dataCompra;
  String? tipoCompra; //enum do tipo, exemplo: tipoCompra.serviço, tipoCompra.alimentação, etc...
  //atributo que será a imagem

  ItemCompra(this.descricao, this.valor, {this.dataCompra, this.tipoCompra});
}