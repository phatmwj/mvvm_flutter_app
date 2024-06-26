
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mvvm_flutter_app/di/locator.dart';
import 'package:mvvm_flutter_app/repo/notification_api.dart';
import 'package:mvvm_flutter_app/socket/web_socket_viewmodel.dart';
import 'package:mvvm_flutter_app/ui/account/account_screen.dart';
import 'package:mvvm_flutter_app/ui/account/account_viewmodel.dart';
import 'package:mvvm_flutter_app/ui/activity/activity_viewmodel.dart';
import 'package:mvvm_flutter_app/ui/chat/chat_viewmodel.dart';
import 'package:mvvm_flutter_app/ui/history/detail/history_detail_screen.dart';
import 'package:mvvm_flutter_app/ui/history/detail/history_detail_viewmodel.dart';
import 'package:mvvm_flutter_app/ui/history/history_screen.dart';
import 'package:mvvm_flutter_app/ui/history/history_viewmodel.dart';
import 'package:mvvm_flutter_app/ui/home/home_screen.dart';
import 'package:mvvm_flutter_app/ui/home/home_viewmodel.dart';
import 'package:mvvm_flutter_app/ui/income_details/income_details_viewmodel.dart';
import 'package:mvvm_flutter_app/ui/login/login_screen.dart';
import 'package:mvvm_flutter_app/ui/login/login_viewmodel.dart';
import 'package:mvvm_flutter_app/ui/navpages/account_page_viewmodel.dart';
import 'package:mvvm_flutter_app/ui/navpages/home_page_viewmodel.dart';
import 'package:mvvm_flutter_app/ui/navpages/income_viewmodel.dart';
import 'package:mvvm_flutter_app/ui/register/register_screen.dart';
import 'package:mvvm_flutter_app/ui/register/register_viewmodel.dart';
import 'package:mvvm_flutter_app/ui/service/service_screen.dart';
import 'package:mvvm_flutter_app/ui/service/service_viewmodel.dart';
import 'package:mvvm_flutter_app/ui/splash/splash_screen.dart';
import 'package:mvvm_flutter_app/ui/welcome/welcome_screen.dart';
import 'package:mvvm_flutter_app/ui/welcome/welcome_viewmodel.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationApi().initNotification();
  setupLocator();
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
          ChangeNotifierProvider(create: (_) => AccountPageViewModel()),
          ChangeNotifierProvider(create: (_) => ServiceViewModel()),
          ChangeNotifierProvider(create: (_) => AccountViewModel()),
          ChangeNotifierProvider(create: (_) => IncomeViewModel()),
          ChangeNotifierProvider(create: (_) => HistoryDetailViewModel()),
          ChangeNotifierProvider(create: (_) => ChatViewModel()),
          ChangeNotifierProvider(create: (_) => ActivityViewModel()),
          ChangeNotifierProvider(create: (_) => IncomeDetailsViewModel()),
        ],
        child: MaterialApp(
          theme: ThemeData(
            fontFamily: 'Roboto',
            useMaterial3: true,
            cardTheme: const CardTheme(
              color: Colors.white,
            ),
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.white).copyWith(background: Colors.white),
          ),
          debugShowCheckedModeBanner: false,
          initialRoute: SplashScreen.id,
          routes: {
            SplashScreen.id:(context) => const SplashScreen(),
            LoginScreen.id:(context)=> const LoginScreen(),
            RegisterScreen.id: (context) => const RegisterScreen(),
            HomeScreen.id: (context)=> const HomeScreen(),
            AccountScreen.id: (context) => const AccountScreen(),
            HistoryScreen.id:(context) => const HistoryScreen(),
            // HistoryDetailScreen.id:(context) =>  HistoryDetailScreen(),
            ServiceScreen.id : (context) => const ServiceScreen(),
            WelcomeScreen.id : (context) => const WelcomeScreen(),

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



