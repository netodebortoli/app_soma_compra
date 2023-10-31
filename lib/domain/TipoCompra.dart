enum TipoCompra {
  Supermercado('Supermercado'),
  Servicos('Serviços'),
  Saude('Saúde'),
  Lazer('Lazer'),
  Urgencia('Urgência'),
  Transporte('Transporte'),
  Outros('Outros');

  final String valor;

  const TipoCompra(this.valor);
}
