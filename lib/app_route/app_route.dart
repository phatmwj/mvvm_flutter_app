import 'package:flutter/material.dart';
import 'package:mvvm_flutter_app/ui/login/login_screen.dart';
import 'package:mvvm_flutter_app/ui/splash/splash_screen.dart';

import '../ui/account/account_screen.dart';
import '../ui/history/detail/history_detail_screen.dart';
import '../ui/history/history_screen.dart';
import '../ui/home/home_screen.dart';
import '../ui/register/register_screen.dart';
import '../ui/service/service_screen.dart';

Route<dynamic>? Function(RouteSettings)? onGenerateRoute = (settings) {
  switch (settings.name) {
    case SplashScreen.id:
      return MaterialPageRoute(
        builder: (_) => const SplashScreen(),
        settings: const RouteSettings(name: SplashScreen.id),
      );
    case LoginScreen.id:
      return MaterialPageRoute(
        builder: (_) => const LoginScreen(),
        settings: const RouteSettings(name: LoginScreen.id),
      );
    case RegisterScreen.id:
      return MaterialPageRoute(
        builder: (_) => const RegisterScreen(),
        settings: const RouteSettings(name: RegisterScreen.id),
      );

    case HomeScreen.id:
      return MaterialPageRoute(
        builder: (_) => const HomeScreen(),
        settings: const RouteSettings(name: HomeScreen.id),
      );
    case AccountScreen.id:
      return MaterialPageRoute(
        builder: (_) => const AccountScreen(),
        settings: const RouteSettings(name: AccountScreen.id),
      );
    case HistoryScreen.id:
      return MaterialPageRoute(
        builder: (_) => const HistoryScreen(),
        settings: const RouteSettings(name: HistoryScreen.id),
      );
    case HistoryDetailScreen.id:
      final int historyId = settings.arguments as int;
      return MaterialPageRoute(
        builder: (_) => HistoryDetailScreen(historyId),
        settings: const RouteSettings(name: HistoryDetailScreen.id),
      );
    case ServiceScreen.id:
      return MaterialPageRoute(
        builder: (_) => const ServiceScreen(),
        settings: const RouteSettings(name: ServiceScreen.id),
      );
  }
  return null;
};
