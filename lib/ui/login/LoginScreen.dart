

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

  bool isVisible = false;
  final formKey = GlobalKey<FormState>();

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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 50, left: 16, right: 16),
            child: vm.isLoading == true ? LoadingWidget()
                :Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Welcome to AllWin',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                      fontSize: 30.0,
                    ),
                  ),
                ),
          
                const SizedBox(
                  height: 10,
                ),
          
                const SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Vui lòng nhập số điện thoại của bạn ',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF969696),
                      fontSize: 15.0,
                    ),
                  ),
                ),
          
                const SizedBox(
                  height: 30,
                ),
          
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        child: TextFormField(
                          onChanged: (value)=> vm.setPhoneNumber(value),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              hintText: 'Phone number',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(width: 1, color: Color(0xFF7EA567)),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                          ),
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16
                          ),

                          validator: (value) {
                            if(value!.isEmpty){
                              return "Please enter your phone number";
                            }
                            final RegExp phoneReg = RegExp(r'^(0[3|5|7|8|9])+([0-9]{8})$');
                            if(!phoneReg.hasMatch(value)){
                              return "Invalid phone number";
                            }
                            return null;
                          },
                        ),
                      ),

                      SizedBox(
                        height: 20,
                      ),

                      SizedBox(
                        child: TextFormField(
                          onChanged: (value)=> vm.setPassword(value),
                          obscureText: !isVisible,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            hintStyle: const TextStyle(
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(width: 1, color: Color(0xFF7EA567)),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isVisible = !isVisible;
                                  });
                                },
                                icon: Icon(isVisible? Icons.visibility_off : Icons.visibility)
                            ),
                          ),
                          style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16
                          ),
                          maxLines: 1,
                          validator: (value) {
                            if(value!.isEmpty){
                              return "password is required";
                            }
                            return null;
                          },
                        ),
                      ),
                    ]
                  ),
                ),

                SizedBox(height: 32.0),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      if(formKey.currentState!.validate()){
                        vm.loginUser();
                        print('Đăng nhập');
                      }

                    },
                    style: ElevatedButton.styleFrom(
                      onPrimary: Color(0xFFFFFFFF),
                      primary: Color(0xFF7EA567)
                    ),
                    child: const Text(
                      'Đăng nhập',
                      style: TextStyle(
                        fontSize: 16
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
