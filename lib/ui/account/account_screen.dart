
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mvvm_flutter_app/constant/Constant.dart';
import 'package:mvvm_flutter_app/utils/Utils.dart';
import 'package:provider/provider.dart';

import '../../data/model/api/api_status.dart';
import '../../res/colors/app_color.dart';
import 'account_viewmodel.dart';

class AccountScreen extends StatefulWidget {
  static const String id = 'account_screen';
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  late AccountViewModel vm;
  final TextEditingController _textNameController = TextEditingController(text: '');
  final TextEditingController _textPhoneController = TextEditingController(text: '');
  final TextEditingController _textPasswordController = TextEditingController(text: '');
  final TextEditingController _textAdController = TextEditingController(text: '');

  bool isVisible = false;

  @override
  void initState() {
    // TODO: implement initState
    vm = Provider.of<AccountViewModel>(context, listen: false);
    vm.getProfile();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _textNameController.dispose();
    _textPhoneController.dispose();
    _textPasswordController.dispose();
    _textAdController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _refresh,
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(top: 20.0),
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Stack(
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.pop(context, true);
                      },
                      child: const Image(
                        image: AssetImage('assets/images/icon_back.png'),
                        width: 20,
                        height: 20,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      alignment: Alignment.center,
                      child: const Text(
                        'Thông tin cá nhân',
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w500,
                            fontSize: 20.0
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.7,
                  padding: const EdgeInsets.only(top: 20, left: 16, right: 16),
                  child: Consumer<AccountViewModel>(
                    builder: (context, value, _){
                      switch(value.res.status){
                        case ApiStatus.LOADING:
                          return const Center(
                            child: SpinKitThreeBounce(
                              color: AppColor.mainColor,
                              size: 30.0,
                            ),
                          );
                        case ApiStatus.ERROR:
                          return RefreshIndicator(
                            onRefresh: _refresh,
                            child: SingleChildScrollView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              child: SizedBox(
                                height: MediaQuery.of(context).size.height,
                                child: const Center(
                                  child: Text('Lỗi kết nối, vui lòng thử lại!'),
                                ),
                              ),
                            ),
                          );
                        case ApiStatus.COMPLETED:
                          return _ui(vm);
                        default:
                          return Container();
                      }
                      Utils.dismissLoading();
                      return Container();
                    },
                  ),

                ),
              ),
            ],
          )

        )
      ),
    );
  }

  Future<void> _refresh() async{
    vm.getProfile();
  }

  _ui(AccountViewModel viewModel){
    _textNameController.text = viewModel.res.data?.fullName ?? '';
    _textPhoneController.text = viewModel.res.data?.phone ?? '';
    _textAdController.text = viewModel.res.data?.address ?? '';

    return Column(
      children: [
        Expanded(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),

              ClipOval(
                  child: viewModel.res.data?.avatar != null ?
                  Image.network(
                      '${Constant.MEDIA_URL}/v1/file/download${viewModel.res.data?.avatar!}',
                      height:120.0,
                      width: 120.0,
                      fit: BoxFit.cover
                  )
                      :
                  const Image(
                      image: AssetImage('assets/images/user_avatar.png'),
                      width: 120.0,
                      height: 120.0),
              ),

              const SizedBox(
                height: 10,
              ),
              Text(
                vm.res.data!.fullName!,
                style: const TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w600,
                    fontSize: 18.0,
                    color: Color(0xFF424242)
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                RatingBar(
                    ignoreGestures: true,
                    initialRating: double.parse(vm.res.data!.averageRating!.toStringAsFixed(1)),
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    itemSize: 20,
                    minRating: 0.1,
                    glow: false,
                    itemPadding: EdgeInsets.all(3.0),
                    ratingWidget: RatingWidget(
                        full: const Icon(Icons.star, color: Colors.yellow),
                        half: const Icon(
                          Icons.star_half,
                          color: Colors.yellow,
                        ),
                        empty: const Icon(
                          Icons.star_outline,
                          color: Colors.yellow,
                        )),
                    onRatingUpdate: (value) {}),
                Text(
                  vm.res.data!.averageRating!.toStringAsFixed(1),
                  style: const TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0,
                      color: Color(0xFF424242)
                  ),
                ),
              ],),
              const SizedBox(
                height: 20,
              ),

              TextFormField(
                controller: _textNameController,
                readOnly: true,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16.0,
                    color: Color(0xFF424242)
                ),
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelText: 'Họ và tên',
                  labelStyle: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20.0,
                      color: Colors.grey
                  ),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(width: 1, color: Color(0xFFC0C0C0)),
                  ),


                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(width: 1, color: Color(0xFFC0C0C0)), // Thiết lập màu của border
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(width: 1, color: Color(0xFFC0C0C0)), // Thiết lập màu của border
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 12),
                ),

              ),

              const SizedBox(
                height: 20,
              ),

              TextFormField(
                controller: _textPhoneController,
                readOnly: true,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16.0,
                  color: Color(0xFF424242),
                ),
                decoration: InputDecoration(
                  // contentPadding: EdgeInsets.symmetric(vertical: 20.0),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelText: 'Số điện thoại',
                  labelStyle: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20.0,
                      color: Colors.grey
                  ),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(width: 1, color: Color(0xFFC0C0C0)),
                  ),


                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(width: 1, color: Color(0xFFC0C0C0)), // Thiết lập màu của border
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(width: 1, color: Color(0xFFC0C0C0)), // Thiết lập màu của border
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 12),
                ),

              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _textAdController,
                readOnly: true,
                style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16.0,
                    color: Color(0xFF424242)
                ),
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelText: 'Địa chỉ',
                  labelStyle: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20.0,
                      color: Colors.grey
                  ),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(width: 1, color: Color(0xFFC0C0C0)),
                  ),


                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(width: 1, color: Color(0xFFC0C0C0)), // Thiết lập màu của border
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(width: 1, color: Color(0xFFC0C0C0)), // Thiết lập màu của border
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 12),

                ),

              ),
            ],
          ),
        ),
      ],
    );
  }

}
