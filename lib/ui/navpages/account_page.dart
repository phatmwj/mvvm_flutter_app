import 'package:flutter/material.dart';
import 'package:mvvm_flutter_app/data/local/prefs/prefereces_service_impl.dart';
import 'package:mvvm_flutter_app/res/colors/app_color.dart';
import 'package:mvvm_flutter_app/ui/history/history_screen.dart';
import 'package:mvvm_flutter_app/ui/home/home_screen.dart';
import 'package:mvvm_flutter_app/ui/login/login_screen.dart';
import 'package:mvvm_flutter_app/ui/navpages/account_page_viewmodel.dart';
import 'package:mvvm_flutter_app/ui/widget/my_oval_avartar.dart';
import 'package:provider/provider.dart';

import '../../constant/Constant.dart';
import '../../data/local/prefs/preferences_service.dart';
import '../account/account_screen.dart';
import '../service/service_screen.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> with AutomaticKeepAliveClientMixin{

  late AccountPageViewModel vm;

  @override
  void initState() {
    // TODO: implement initState
    vm = Provider.of<AccountPageViewModel>(context, listen: false);
    vm.getProfile(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body:Consumer<AccountPageViewModel>(
        builder: (context,value,_){
          return SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 40, left: 16, right: 16),
                child: Column(
                  children: [
                    const SizedBox(
                      width: double.infinity,
                      child: Text(
                        'Cài đặt',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF424242),
                          fontSize: 36.0,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Card(
                      surfaceTintColor: Colors.white,
                      shadowColor: null,
                      elevation: 4.0,
                      child: InkWell(
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                  const AccountScreen()));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              MyOvalAvatar(avatar: vm.profileRes?.data?.avatar??'',),
                              const SizedBox(
                                width: 30,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      vm.profileRes?.data?.fullName ?? "username",
                                      style: const TextStyle(
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18.0),
                                    ),
                                    Row(
                                      children: [
                                        const Image(
                                          image: AssetImage(
                                              'assets/images/icon_star.png'),
                                          width: 15.0,
                                          height: 15.0,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          vm.profileRes?.data?.averageRating != null ? vm.profileRes.data!.averageRating!.toStringAsFixed(1): "0.0",
                                          style:
                                          const TextStyle(fontWeight: FontWeight.w400,
                                              fontFamily: 'Roboto'),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const Image(
                                image: AssetImage('assets/images/icon_arrow.png'),
                                width: 50.0,
                                height: 50.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Card(
                      surfaceTintColor: Colors.white,
                      shadowColor: null,
                      elevation: 4.0,
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                        const ServiceScreen()));
                              },
                              child: const Row(
                                children: [
                                  SizedBox(width: 50.0,
                                    height: 50.0,
                                    child: Icon(Icons.miscellaneous_services,color: Color(0xFF424242),),),
                                  Expanded(
                                      child: Text(
                                        'Cấu hình dịch vụ',
                                        style: TextStyle(
                                            fontFamily: 'Roboto',
                                            color: Color(0xFF424242),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16.0),
                                      )),
                                  Image(
                                    image:
                                    AssetImage('assets/images/icon_arrow.png'),
                                    width: 50.0,
                                    height: 50.0,
                                  ),
                                ],
                              ),
                            ),
                            const Divider(
                              color: Color(0xFFC0C0C0),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                        const HistoryScreen()));
                              },
                              child: const Row(
                                children: [
                                  SizedBox(width: 50.0,
                                    height: 50.0,
                                    child: Icon(Icons.history,color: Color(0xFF424242),),),
                                  Expanded(
                                      child: Text(
                                        'Lịch sử',
                                        style: TextStyle(
                                            fontFamily: 'Roboto',
                                            color: Color(0xFF424242),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16.0),
                                      )),
                                  Image(
                                    image:
                                    AssetImage('assets/images/icon_arrow.png'),
                                    width: 50.0,
                                    height: 50.0,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    Card(
                        surfaceTintColor: Colors.white,
                        shadowColor: null,
                        elevation: 4.0,
                        child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Column(children: [
                              InkWell(
                                onTap: (){
                                  openAlert(context);
                                },
                                child: const Row(
                                  children: [
                                    SizedBox(width: 50.0,
                                      height: 50.0,
                                    child: Icon(Icons.logout,color: Colors.red,),),
                                    // Image(
                                    //   image: AssetImage('assets/images/icon_config.png'),
                                    //   width: 50.0,
                                    //   height: 50.0,
                                    // ),


                                    Expanded(child: Text(
                                      'Đăng xuất',
                                      style: TextStyle(
                                          fontFamily: 'Roboto',
                                          color: Color(0xFF424242),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16.0
                                      ),
                                    )),

                                  ],
                                ),
                              ),

                            ])))
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }

  openAlert(BuildContext context) {
    final dialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      surfaceTintColor: Colors.white,
      //this right here
      child: Container(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Bạn có muốn đăng xuất?',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12, right: 6),
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          primary: Colors.green,
                          side: const BorderSide(color: Color(0xFF7EA567)),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                        "Hủy",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      ),


                      ),
                      )
                    ),

                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 6, right: 12),
                      child: ElevatedButton(
                        onPressed: () {
                          PreferencesServiceImpl()
                              .remove(PreferencesService.KEY_BEARER_TOKEN);
                          Navigator.pushNamedAndRemoveUntil(context, LoginScreen.id, (route) => false);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: AppColor.mainColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                        ),
                        child: const Text(
                          "Đăng xuất",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),

                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
    showDialog(context: context, builder: (BuildContext context) => dialog);
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
