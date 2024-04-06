import 'package:flutter/material.dart';
import 'package:mvvm_flutter_app/res/app_context_extension.dart';

class MyTextView extends StatelessWidget {
  final String label;
  final Color? color;
  final double fontSize;
  final FontWeight fontWeight;
  final TextAlign? textAlign;

  MyTextView({this.label = "", this.color, this.fontSize = 16, this.fontWeight = FontWeight.w500, this.textAlign});

  @override
  Widget build(BuildContext context) {
    return Text(label,
      textAlign: textAlign?? TextAlign.start,
      style: TextStyle(
        color: color ?? context.resources.color.textColorMain,
        fontSize: fontSize,
        fontFamily: 'Roboto',
        fontWeight: fontWeight,
          overflow: TextOverflow.ellipsis,
    ),);
  }
}
