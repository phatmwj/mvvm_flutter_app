import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_flutter_app/ui/home/home_screen.dart';
import 'package:location/location.dart';
import 'package:mvvm_flutter_app/data/local/prefs/prefereces_service_impl.dart';
import 'package:mvvm_flutter_app/data/local/prefs/preferences_service.dart';
import 'package:mvvm_flutter_app/ui/login/login_screen.dart';
import 'package:mvvm_flutter_app/ui/register/register_screen.dart';
import 'package:mvvm_flutter_app/ui/welcome/welcome_screen.dart';

import '../home/home_screen.dart';

class SplashScreen extends StatefulWidget{
    static const String id = 'splash_screen';
    const SplashScreen({super.key});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SplashScreenState();
  }

}

class _SplashScreenState extends State<SplashScreen>{

  PreferencesService _pref = PreferencesServiceImpl();
  Location location = Location();
  late PermissionStatus _permission;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 2), () async {
      _permission = await location.hasPermission();
      String? token = await _pref.getToken();
      if(_permission != PermissionStatus.denied){
        if(token != null){
          Navigator.pushReplacementNamed(context, HomeScreen.id);
          // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
        }else{
          Navigator.pushReplacementNamed(context, LoginScreen.id);
          // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
        }
      }else{
        Navigator.pushReplacementNamed(context, WelcomeScreen.id);
        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const WelcomeScreen()));
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return const Scaffold(
      body: Center(
        child: Image(
          image: AssetImage('assets/images/logo_app.png'),
          fit: BoxFit.fitWidth,
          width: 230,
        ),
      ),
    );
  }

}