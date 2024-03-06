import 'package:flutter/material.dart';
import 'package:mvvm_flutter_app/data/local/prefs/AppPreferecesService.dart';
import 'package:mvvm_flutter_app/ui/history/history_screen.dart';
import 'package:mvvm_flutter_app/ui/login/LoginScreen.dart';

import '../../data/local/prefs/PreferencesService.dart';
class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 40, left: 16, right: 16),
            child: Column(
              children: [
                const SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Cài đặt',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                      fontSize: 36.0,
                    ),
                  ),
                ),

                Card(
                  surfaceTintColor: Colors.white,
                  shadowColor: Colors.lightGreenAccent,
                  elevation: 4.0,
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Image(
                          image: AssetImage('assets/images/user_avatar.png'),
                          width: 50.0,
                          height: 50.0,
                        ),

                        SizedBox(
                          width: 30,
                        ),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Text(
                                'Nguyen Van An',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18.0
                                ),
                              ),
                          
                              Row(
                                children: [
                                  Image(
                                    image: AssetImage('assets/images/icon_star.png'),
                                    width: 15.0,
                                    height: 15.0,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),

                                  Text(
                                    '5.0',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        Image(
                          image: AssetImage('assets/images/icon_arrow.png'),
                          width: 50.0,
                          height: 50.0,
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(
                  height: 30,
                ),

                Card(
                  surfaceTintColor: Colors.white,
                  shadowColor: Colors.lightGreenAccent,
                  elevation: 4.0,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: (){
                            print('hello');
                          },
                          child: Row(
                            children: [
                              Image(
                                image: AssetImage('assets/images/icon_config.png'),
                                width: 50.0,
                                height: 50.0,
                              ),


                              Expanded(child: Text(
                                'Cấu hình dịch vụ',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18.0
                                ),)),

                              Image(
                                image: AssetImage('assets/images/icon_arrow.png'),
                                width: 50.0,
                                height: 50.0,
                              ),
                            ],
                          ),
                        ),

                        Divider(
                          color: Color(0xFFC0C0C0),
                        ),

                        InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const HistoryScreen()));
                          },
                          child: Row(
                            children: [
                              Image(
                                image: AssetImage('assets/images/icon_config.png'),
                                width: 50.0,
                                height: 50.0,
                              ),


                              Expanded(child: Text(
                                'Lịch sử',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18.0
                                ),
                              )),

                              Image(
                                image: AssetImage('assets/images/icon_arrow.png'),
                                width: 50.0,
                                height: 50.0,
                              ),
                            ],
                          ),
                        ),

                        Divider(
                          color: Color(0xFFC0C0C0),
                        ),

                        InkWell(
                          onTap: (){
                            AppPreferencesService().remove(PreferencesService.KEY_BEARER_TOKEN);
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                          },
                          child: Row(
                            children: [
                              Image(
                                image: AssetImage('assets/images/icon_config.png'),
                                width: 50.0,
                                height: 50.0,
                              ),


                              Expanded(child: Text(
                                'Đăng xuất',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18.0
                                ),
                              )),

                              Image(
                                image: AssetImage('assets/images/icon_arrow.png'),
                                width: 50.0,
                                height: 50.0,
                              ),
                            ],
                          ),
                        ),


                      ],
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
