import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mvvm_flutter_app/data/local/prefs/AppPreferecesService.dart';
import 'package:mvvm_flutter_app/data/local/prefs/PreferencesService.dart';
import 'package:mvvm_flutter_app/socket/booking.dart';
import 'package:mvvm_flutter_app/socket/command.dart';
import 'package:mvvm_flutter_app/socket/message.dart';
import 'package:mvvm_flutter_app/socket/web_socket_viewmodel.dart';
import 'package:mvvm_flutter_app/ui/history/history_view_model.dart';
import 'package:mvvm_flutter_app/ui/home/home_screen.dart';
import 'package:mvvm_flutter_app/ui/home/home_viewmodel.dart';
import 'package:mvvm_flutter_app/ui/login/LoginScreen.dart';
import 'package:mvvm_flutter_app/ui/login/LoginViewModel.dart';
import 'package:mvvm_flutter_app/ui/navpages/home_page_viewmodel.dart';
import 'package:mvvm_flutter_app/ui/register/register_screen.dart';
import 'package:mvvm_flutter_app/ui/register/register_view_model.dart';
import 'package:mvvm_flutter_app/ui/splash/splash_screen.dart';
import 'package:mvvm_flutter_app/ui/welcome/welcome_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
  configLoading();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => LoginViewModel()),
          ChangeNotifierProvider(create: (_) => RegisterViewModel()),
          ChangeNotifierProvider(create: (_) => WelcomeViewModel()),
          ChangeNotifierProvider(create: (_) => HomeViewModel()),
          ChangeNotifierProvider(create: (_) => HistoryViewModel()),
          ChangeNotifierProvider(create: (_) => WebSocketViewModel()),
          ChangeNotifierProvider(create: (_) => HomePageViewModel()),
        ],
        child: MaterialApp(
          theme: ThemeData(
            fontFamily: 'Roboto',
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
            cardTheme: const CardTheme(
              color: Colors.white,
            ),
          ),
          debugShowCheckedModeBanner: false,
          initialRoute: SplashScreen.id,
          routes: {
            SplashScreen.id:(context) => SplashScreen()
          },
          builder: EasyLoading.init(),
       ));
  }

}

void configLoading() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.light
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.white
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.black
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
}



