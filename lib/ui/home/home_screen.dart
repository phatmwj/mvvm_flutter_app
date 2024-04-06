
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_flutter_app/res/app_context_extension.dart';
import 'package:mvvm_flutter_app/socket/web_socket_viewmodel.dart';
import 'package:mvvm_flutter_app/ui/navpages/home_page.dart';
import 'package:mvvm_flutter_app/ui/navpages/account_page.dart';
import 'package:mvvm_flutter_app/ui/navpages/income_page.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget{
  static const String id = "home_screen";

  const HomeScreen({super.key});

  @override
    // TODO: implement createState
    _HomeScreenState createState()=> _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen>{

  PageController _pageController = PageController();

  int _selectedIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    // _pageController.jumpToPage(_selectedIndex);
    super.initState();
  }
  void _onItemTapped(int index) {
    _pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return
        Scaffold(
          body: Center(
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _pageController,
              allowImplicitScrolling: true,
              onPageChanged: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              children:const [
                HomePage(),
                IncomePage(),
                AccountPage(),
              ],
            ),
          ),

          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Trang chủ',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.bar_chart),
                label: 'Thu nhập',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Tài khoản',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: context.resources.color.appColorMain,
            onTap: _onItemTapped,
            selectedLabelStyle: const TextStyle(
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w600,
              fontSize: 14.0,
            ),
            unselectedLabelStyle:const TextStyle(
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w500,
              fontSize: 13.0,
            ),
          ),
        );
  }

}