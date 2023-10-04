import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void ToastSucesso(String mensagem) {
  Fluttertoast.showToast(
      msg: mensagem,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 5,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0);
}
