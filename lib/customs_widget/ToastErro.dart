import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void ToastErro(String mensagem) {
  Fluttertoast.showToast(
      msg: mensagem,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 3,
      textColor: Colors.black,
      fontSize: 22.0);
}
