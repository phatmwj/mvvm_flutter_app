

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_flutter_app/data/model/api/ApiStatus.dart';
import 'package:mvvm_flutter_app/res/colors/AppColors.dart';
import 'package:mvvm_flutter_app/res/colors/BaseColors.dart';
import 'package:mvvm_flutter_app/ui/login/LoginViewModel.dart';
import 'package:mvvm_flutter_app/ui/widget/LoadingWidget.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget{
  static const String id = "login_screen";
  const LoginScreen({super.key});
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>{

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    final vm = Provider.of<LoginViewModel>(context);

    // TODO: implement build
    return Scaffold(
      body:
      SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: vm.isLoading == true ? LoadingWidget()
              :Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                'Welcome to AllWin',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30.0,
                ),
              ),

              SizedBox(
                height: 10,
              ),

              const Text(
                'Vui lòng nhập số điện thoại của bạn ',
                style: TextStyle(
                  color: Color(0xFF969696),
                  fontSize: 15.0,
                ),
              ),

              TextField(
                onChanged: (value)=> vm.setPhoneNumber(value),
                decoration: InputDecoration(labelText: 'PhoneNumber'),
              ),
              SizedBox(height: 16.0),
              TextField(
                onChanged: (value)=> vm.setPassword(value),
                obscureText: true,
                decoration: InputDecoration(labelText: 'Password'),
              ),
              SizedBox(height: 32.0),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    vm.loginUser();
                    print('Đăng nhập');
                  },
                  style: ElevatedButton.styleFrom(
                    onPrimary: Color(0xFFFFFFFF),
                    primary: Color(0xFF7EA567)
                  ),
                  child: Text('Đăng nhập'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
