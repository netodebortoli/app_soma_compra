import 'package:flutter/material.dart';

import 'CampoForm.dart';

class CampoFormMaiorQueZero extends CampoForm {
  CampoFormMaiorQueZero(String label, TextEditingController controller,
      {String hint = "",
      int minLenght = 0,
      int maxLength = 100,
      bool password = false,
      bool formEnable = true,
      bool isFormRequired = true,
      FocusNode? marcadorFoco,
      FocusNode? passarFocoPara,
      FormFieldValidator<String>? validator})
      : super(label, controller,
            hint: hint,
            minLength: minLenght,
            maxLength: maxLength,
            password: password,
            formEnable: formEnable,
            isFormRequired: isFormRequired,
            marcadorFoco: marcadorFoco,
            passarFocoPara: passarFocoPara,
            validator: validator) {
    typeInput = TextInputType.number;
  }

  @override
  String? validarCampoEdicao(String? text) {
    if (isFormRequired == true) {
      if ((text == null) || (text.isEmpty)) {
        return "O campo \"$label\" é obrigatório";
      }
    }
    if (text!.length < minLength) {
      return "Quantidade mínima é $minLength de caracteres";
    }
    if (text.length > maxLength) {
      return "Quantidade máxima é $maxLength de caracteres";
    }
    try {
      int valor = int.parse(text);
      if (valor <= 0) {
        return "O valor digitado deve ser maior que 0";
      }
    } on Exception {
      return "O valor DEVE ser um número inteiro";
    }
    return null;
  }
}
