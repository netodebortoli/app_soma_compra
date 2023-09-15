import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CampoForm extends StatelessWidget {
  String label;
  String hint;
  bool password;
  TextInputType typeInput;
  TextEditingController? controller;
  FormFieldValidator<String>? validator;

  String? validarCampoEdicao(String? text) {
    if ((text == null) || (text.isEmpty)) {
      return "O campo '$label' é obrigatório";
    }
    return null;
  }

  CampoForm(this.label, this.controller,
      {this.hint = "",
      this.password = false,
      this.typeInput = TextInputType.text,
      this.validator}) {
    validator ??= validarCampoEdicao;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        style: const TextStyle(fontSize: 25, color: Colors.black),
        validator: validator,
        controller: controller,
        obscureText: password,
        keyboardType: typeInput,
        decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            labelText: label,
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.green, fontSize: 10),
            labelStyle: const TextStyle(color: Colors.grey, fontSize: 20)));
  }
}
