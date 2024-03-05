import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_flutter_app/ui/home/home_screen.dart';
import 'package:mvvm_flutter_app/ui/login/LoginScreen.dart';
import 'package:mvvm_flutter_app/ui/register/register_screen.dart';

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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
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
          width: 250,
        ),
      ),
    );
  }

}