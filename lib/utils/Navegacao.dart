import 'package:flutter/material.dart';

Future push(BuildContext context, Widget pagina, {bool replace = false}) {
  if (replace) {
    return Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return pagina;
    }));
  }
  return Navigator.push(context,
      MaterialPageRoute(builder: (BuildContext context) {
    return pagina;
  }));
}

void pop(BuildContext context, {String? mensagem = null}) {
  if (mensagem == null) {
    Navigator.of(context).pop();
  } else {
    Navigator.pop(context, mensagem);
  }
}
