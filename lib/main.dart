import 'package:flutter/material.dart';
import 'package:mvvm_flutter_app/ui/login/LoginScreen.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: LoginScreen.id,
    routes: {
      LoginScreen.id:(context) => LoginScreen()
    },
  ));
}


