import 'package:flutter/material.dart';
import 'package:mvvm_flutter_app/res/app_context_extension.dart';

class MyOutlinedButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final Color? color;
  final double? fontSize;

  MyOutlinedButton({this.label = "", this.onPressed, this.color, this.fontSize});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        primary: color ?? context.resources.color.appColorMain,
        side: BorderSide(color: color ?? context.resources.color.appColorMain),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.0)),
      ),
      onPressed: () {
        onPressed?.call();
      },
      child: Text(
        label,
        style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: fontSize ?? 16,
            color: color ?? context.resources.color.appColorMain,
            fontWeight: FontWeight.w500),
      ),
    );
  }
}
