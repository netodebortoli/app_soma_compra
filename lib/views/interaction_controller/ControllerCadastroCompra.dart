import 'package:flutter/material.dart';

class ControllerCadastroCompra{

  final formkey = GlobalKey<FormState>();
  final controleData = TextEditingController();
  final controleValorTotal = TextEditingController();
  final controleDescricao = TextEditingController();
  final controleTipoPagamento = TextEditingController();
  final controleTipoCompra = TextEditingController();
  final List<TextEditingController> controleItensCompra = [];
}