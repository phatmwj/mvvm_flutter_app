import 'package:flutter/material.dart';
import 'package:mvvm_flutter_app/res/app_context_extension.dart';

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(
            height: 8,
          ),
          Text(
            context.resources.strings.labelLoading,
          )
        ],
      ),
    ));
  }
}
