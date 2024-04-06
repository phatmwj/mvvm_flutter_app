import 'package:flutter/material.dart';
import 'package:mvvm_flutter_app/res/app_context_extension.dart';

class MyElevatedButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final Color? color;
  final double? fontSize;

  MyElevatedButton({this.label = "", this.onPressed, this.color, this.fontSize});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onPressed?.call();
      },
      style: ElevatedButton.styleFrom(
        primary: color ?? context.resources.color.appColorMain,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.0)),
      ),
      child: Text(
        label,
        style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: fontSize ?? 16.0,
            color: Colors.white,
            fontWeight: FontWeight.w500),
      ),

    );
  }
}
