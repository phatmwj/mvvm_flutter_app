import 'package:flutter/material.dart';
import 'package:mvvm_flutter_app/res/app_context_extension.dart';
import 'package:mvvm_flutter_app/ui/widget/my_textview.dart';

class NetworkError extends StatelessWidget {

  NetworkError();

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          children: [
            Icon(Icons.error, size: 40, color: context.resources.color.textColorMain,),
            MyTextView(
              label: "Không có kết nối internet!",
              color: context.resources.color.cancelColor,
            ),
          ],
        ));
  }
}