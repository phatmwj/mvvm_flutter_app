import 'package:flutter/material.dart';
import 'package:mvvm_flutter_app/ui/login/LoginScreen.dart';
import 'package:mvvm_flutter_app/ui/login/LoginViewModel.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => LoginViewModel())
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: LoginScreen.id,
          routes: {
            LoginScreen.id:(context) => LoginScreen()
          },
       ));
  }
}



