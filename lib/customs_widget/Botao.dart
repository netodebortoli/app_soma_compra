import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Botao extends StatelessWidget {
  final VoidCallback? onClick;
  final String label;
  final double fontSize;
  final Color fontColor;

  Botao(this.label,
      {this.fontSize = 18,
      this.fontColor = Colors.white,
      required this.onClick});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onClick,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
        child: Text(label,
            style: TextStyle(
                fontSize: fontSize,
                color: fontColor)));
  }
}
