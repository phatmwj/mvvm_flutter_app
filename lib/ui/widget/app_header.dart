import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_flutter_app/res/app_context_extension.dart';
import 'package:mvvm_flutter_app/ui/widget/my_textview.dart';

class AppHeader extends StatelessWidget{
  final String? title;

  final VoidCallback? onPressed;

  final bool? hideIcon;

  AppHeader({this.title,this.onPressed, this.hideIcon = false});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          hideIcon! ? const SizedBox(height: 25.0,):
          IconButton(
              onPressed: (){
                onPressed != null ? onPressed?.call() :
                Navigator.pop(context, true);
                },
              icon: Icon(
                Icons.arrow_back,
                size: 25.0,
                color: context.resources.color.textColorMain,
              )),

          const SizedBox(width: 10),

          Container(
            alignment: Alignment.center,
            child: MyTextView(
              label: title!,
              fontSize: 18.0,
            ),
            ),
        ],
      ),
    );
  }


}