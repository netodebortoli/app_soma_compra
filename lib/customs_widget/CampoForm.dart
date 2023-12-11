import 'package:flutter/material.dart';

class CampoForm extends StatelessWidget {
  String label;
  String hint;
  bool password;
  TextInputType typeInput;
  TextEditingController? controller;
  FormFieldValidator<String>? validator;
  num minLength;
  num maxLength;
  bool formEnable;
  bool isFormRequired;
  FocusNode? marcadorFoco;
  FocusNode? passarFocoPara;

  String? validarCampoEdicao(String? text) {
    if (isFormRequired == true) {
      if ((text == null) || (text.isEmpty)) {
        return "O campo \"$label\" é obrigatório";
      }
    }
    if (text!.length < minLength) {
      return "Quantidade mínima é $minLength de caracteres";
    }
    if (text!.length > maxLength) {
      return "Quantidade máxima é $maxLength de caracteres";
    }
    return null;
  }

  CampoForm(this.label, this.controller,
      {this.hint = "",
      this.minLength = 0,
      this.maxLength = 100,
      this.password = false,
      this.formEnable = true,
      this.isFormRequired = true,
      this.typeInput = TextInputType.text,
      this.validator,
      this.marcadorFoco,
      this.passarFocoPara}) {
    validator ??= validarCampoEdicao;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        style: const TextStyle(fontSize: 15, color: Colors.black),
        validator: validator,
        controller: controller,
        obscureText: password,
        keyboardType: typeInput,
        enabled: formEnable,
        focusNode: marcadorFoco,
        onFieldSubmitted: (String text) {
          FocusScope.of(context).requestFocus(passarFocoPara);
        },
        decoration: InputDecoration(
            labelText: label,
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.grey, fontSize: 15),
            labelStyle: const TextStyle(color: Colors.grey, fontSize: 20)));
  }
}
