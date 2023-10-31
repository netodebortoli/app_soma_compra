enum TipoPagamento {
  Dinheiro('Dinheiro'),
  Credito('Crédito'),
  Debito('Débito'),
  Pix('Pix'),
  Outros('Outros');

  final String valor;

  const TipoPagamento(this.valor);
}
