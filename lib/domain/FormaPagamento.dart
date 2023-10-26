enum TipoPagamento {
  Credito('Crédito'),
  Debito('Débito'),
  Pix('Pix'),
  Dinheiro('Dinheiro'),
  Outros('Outros');

  final String valor;

  const TipoPagamento(this.valor);
}
