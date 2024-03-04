import 'package:flutter/material.dart';
import 'package:mvvm_flutter_app/ui/login/LoginScreen.dart';
import 'package:mvvm_flutter_app/ui/login/LoginViewModel.dart';
import 'package:mvvm_flutter_app/ui/register/register_screen.dart';
import 'package:mvvm_flutter_app/ui/register/register_view_model.dart';
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
          ChangeNotifierProvider(create: (_) => LoginViewModel()),
          ChangeNotifierProvider(create: (_) => RegisterViewModel())
        ],
        child: MaterialApp(
          theme: ThemeData(
            fontFamily: 'Roboto',
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          ),
          debugShowCheckedModeBanner: false,
          initialRoute: RegisterScreen.id,
          routes: {
            RegisterScreen.id:(context) => RegisterScreen()
          },
       ));
  }
}



