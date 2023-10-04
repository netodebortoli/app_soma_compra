import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void ToastErro(String mensagem) {
  Fluttertoast.showToast(
      msg: mensagem,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 5,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 22.0);
}
