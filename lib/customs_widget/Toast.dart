import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void ToastSucesso(String mensagem, BuildContext context){
  CherryToast.success(
    toastPosition: Position.bottom,
      title: Text(mensagem, style: const TextStyle(color: Colors.black)),
  ).show(context);
}

void ToastAlerta(String mensagem, BuildContext context){
  CherryToast.warning(
    toastPosition: Position.bottom,
    title: const Text(""),
    displayTitle: false,
    description: Text(mensagem, style: const TextStyle(color: Colors.black)),
  ).show(context);
}

void ToastErro(String mensagem, BuildContext context){
  CherryToast.error(
    toastPosition: Position.bottom,
      title: const Text(""),
      displayTitle: false,
      description: Text(mensagem, style: const TextStyle(color: Colors.black)),
      animationType: AnimationType.fromRight,
      animationDuration: const Duration(milliseconds: 1000),
      autoDismiss: true,
  ).show(context);
}

void ToastErroSimples(String mensagem) {
  Fluttertoast.showToast(
      msg: mensagem,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 3,
      textColor: Colors.black,
      fontSize: 22.0);
}