import 'package:flutter/material.dart';
import 'package:mvvm_flutter_app/ui/register/register_view_model.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  static const String id = "register_screen";

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  bool isPWVisible = false;
  bool isCPWVisible = false;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<RegisterViewModel>(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 50, left: 16, right: 16),
            child: Column(
              children: [
                const SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Đăng ký',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                      fontSize: 30.0,
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
                            onChanged: (value)=> vm.setFullName(value),
                            decoration: InputDecoration(
                              counterText: '',
                              hintText: 'Họ và tên',
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
                                return "Vui lòng nhập họ và tên";
                              }

                              return null;
                            },
                            maxLength: 50,
                            maxLines: 1,
                          ),
                        ),

                        SizedBox(
                          height: 20,
                        ),

                        SizedBox(
                          child: TextFormField(
                            onChanged: (value)=> vm.setPhoneNumber(value),
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              counterText: '',
                              hintText: 'Số điện thoại',
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
                            maxLength: 10,
                            maxLines: 1,
                            validator: (value) {
                              if(value!.isEmpty){
                                return "Vui lòng nhập đầy đủ số điện thoại";
                              }
                              final RegExp phoneReg = RegExp(r'^(0[3|5|7|8|9])+([0-9]{8})$');
                              if(!phoneReg.hasMatch(value)){
                                return "Số điện thoại không hợp lệ";
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
                            obscureText: !isPWVisible,
                            decoration: InputDecoration(
                              hintText: 'Mật khẩu',
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
                                      isPWVisible = !isPWVisible;
                                    });
                                  },
                                  icon: Icon(isPWVisible? Icons.visibility_off : Icons.visibility)
                              ),
                            ),
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16
                            ),
                            maxLines: 1,
                            validator: (value) {
                              if(value!.isEmpty){
                                return "Vui lòng nhập mật khẩu";
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
                            onChanged: (value)=> vm.setConfirmPassword(value),
                            obscureText: !isCPWVisible,
                            decoration: InputDecoration(
                              hintText: 'Xác nhận mật khẩu',
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
                                      isCPWVisible = !isCPWVisible;
                                    });
                                  },
                                  icon: Icon(isCPWVisible? Icons.visibility_off : Icons.visibility)
                              ),
                            ),
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16
                            ),
                            maxLines: 1,
                            validator: (value) {
                              if(value!.isEmpty){
                                return "Vui lòng nhập mật khẩu";
                              }

                              if(value.compareTo(vm.password) != 0){
                                return "Mật khẩu không trùng khớp";
                              }

                              return null;
                            },
                          ),
                        ),
                      ]
                  ),
                ),

                const SizedBox(
                    height: 32.0
                ),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      if(formKey.currentState!.validate()){
                        vm.register(context);
                      }

                    },
                    style: ElevatedButton.styleFrom(
                        onPrimary: Color(0xFFFFFFFF),
                        primary: Color(0xFF7EA567)
                    ),
                    child: const Text(
                      'Đăng ký',
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
