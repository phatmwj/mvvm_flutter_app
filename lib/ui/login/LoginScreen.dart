

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_flutter_app/data/model/api/ApiStatus.dart';
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

  LoginViewModel vm = LoginViewModel();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body:
      Padding(
        padding: EdgeInsets.all(16.0),
        child: vm.isLoading == true ? LoadingWidget()
            :Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
            ElevatedButton(
              onPressed: () {
                vm.loginUser();
                print('Đăng nhập');
              },
              child: Text('Đăng nhập'),
            ),
          ],
        ),
      ),
    );
  }
}
