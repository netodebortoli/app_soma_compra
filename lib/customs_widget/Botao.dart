import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Botao extends StatelessWidget {
  final VoidCallback? onClick;
  final String label;
  final double fontSize;
  final Color fontColor;
  final Color backgroundColor;
  FocusNode? marcadorFoco;

  Botao(this.label,
      {this.fontSize = 18,
      this.fontColor = Colors.white,
      this.marcadorFoco,
      this.backgroundColor = Colors.blueAccent,
      required this.onClick});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        focusNode: marcadorFoco,
        onPressed: onClick,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
        child: Text(label,
            style: TextStyle(fontSize: fontSize, color: fontColor)));
  }
}
