
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mvvm_flutter_app/data/model/api/response/income_response.dart';
import 'package:mvvm_flutter_app/res/app_context_extension.dart';
import 'package:mvvm_flutter_app/ui/income_details/income_details_screen.dart';
import 'package:mvvm_flutter_app/ui/navpages/income_viewmodel.dart';
import 'package:mvvm_flutter_app/ui/widget/my_textview.dart';
import 'package:mvvm_flutter_app/utils/utils.dart';
import 'package:provider/provider.dart';

import '../../data/model/api/api_status.dart';
import '../../utils/number_utils.dart';
import '../widget/my_error_widget.dart';

class IncomePage extends StatefulWidget {
  const IncomePage({super.key});

  @override
  State<IncomePage> createState() => _IncomePageState();
}

class _IncomePageState extends State<IncomePage> with AutomaticKeepAliveClientMixin{

  late IncomeViewModel vm;

  @override
  void initState() {
    // TODO: implement initState
    vm = Provider.of<IncomeViewModel>(context, listen: false);
    vm.statisticIncome(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      body: SafeArea(
        child: Stack( // Wrap with Stack
          children: [
            Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(top: 20.0),
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Stack(
                    children: [
                      const SizedBox(width: 10),
                      Container(
                        alignment: Alignment.center,
                        child: const Text(
                          'Thống kê thu nhập',
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
                const SizedBox(height: 15),

                Consumer<IncomeViewModel>(builder: (context, viewModel, _) {
                  switch (vm.incomeRes.status) {
                    case ApiStatus.LOADING:
                      Utils.showLoading();
                    case ApiStatus.ERROR:
                      return MyErrorWidget(vm.incomeRes.message ?? "NA");
                    case ApiStatus.COMPLETED:
                      log("incomeUI");
                      return _incomeUI(vm.incomeRes!.data!);
                    default:
                  }
                  Utils.dismissLoading();
                  return Container();
                }),
              ],
            ),
          ],
        ),
      ),
    );

  }

  Widget _incomeUI(IncomeResponse income){
    return Padding(padding: const EdgeInsets.only(left: 16.0,right: 16.0),
    child: Column(
      children: [
        Card(
          surfaceTintColor: Colors.white,
          color: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            ),
          ),
          elevation: 4.0,
          child: Row(
            children: [
              const SizedBox(width: 20,),
              TextButton(
                onPressed: () {
                  vm.setIncomeTime(context, 0);
                },
                child: Text(
                  'Ngày',
                  style: TextStyle(
                      fontSize: 16,
                      color: vm.incomeTime == 0 ? Color(0xFF7EA567) : Color(0xFF424242),
                      fontWeight: FontWeight.w500),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Expanded(child: SizedBox()),
              TextButton(
                onPressed: () {
                  vm.setIncomeTime(context, 1);
                },
                child: Text(
                  'Tuần',
                  style: TextStyle(
                      fontSize: 16,
                      color: vm.incomeTime == 1 ? Color(0xFF7EA567) : Color(0xFF424242),
                      fontWeight: FontWeight.w500),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Expanded(child: SizedBox()),
              TextButton(
                onPressed: () {
                  vm.setIncomeTime(context, 2);
                },
                child: Text(
                  'Tháng',
                  style: TextStyle(
                      fontSize: 16,
                      color: vm.incomeTime == 2 ? Color(0xFF7EA567) : Color(0xFF424242),
                      fontWeight: FontWeight.w500),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 20,),
            ],
          ),
        ),
        const SizedBox(height: 5,),
        Card(
          surfaceTintColor: Colors.white,
          color: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10.0),
              bottomRight: Radius.circular(10.0),
            ),
          ),
          elevation: 4.0,
          child: Column(
            children: [
              const SizedBox(height: 10,),
              Card(
                surfaceTintColor: Colors.white,
                color: const Color(0xBFE9E9E9),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15.0),
                    bottomRight: Radius.circular(15.0),
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0),
                  ),
                ),
                elevation: 0.0,
                child:Padding(padding: EdgeInsets.only(top: 5, bottom: 5,left: 15,right: 15),
                  child: Text(
                    vm.timeString ?? "datetime",
                    style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xFF424242),
                        fontWeight: FontWeight.w500),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              const SizedBox(height: 5,),
              Row(children: [
                IconButton(
                  onPressed: () {
                    vm.doBeforeTime(context);
                  },
                  icon: const Icon(
                    Icons.navigate_before, // Icon to display
                    color: Color(0xFF424242), // Icon color
                    size: 30, // Icon size
                  ),
                ),

                Expanded(child: TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => IncomeDetailsScreen(vm.startD, vm.endD)));
                  },
                  child: Text(
                    "${NumberUtils.formatMoneyToString(double.parse(income.totalMoney.toStringAsFixed(0)))} đ",
                    style: const TextStyle(
                        fontSize: 25,
                        color: Colors.red,
                        fontWeight: FontWeight.w700),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),),
                IconButton(
                  onPressed: () {
                    vm.doNextTime(context);
                  },
                  icon: const Icon(
                    Icons.navigate_next, // Icon to display
                    color: Color(0xFF424242), // Icon color
                    size: 30, // Icon size
                  ),
                ),
              ],),
              const SizedBox(height: 10,),
              const Text(
                '(Thu nhập từ chuyến đi và các khoản thanh toán khác)',
                style: TextStyle(
                    fontSize: 10,
                    color: Color(0xFFC0C0C0),
                    fontWeight: FontWeight.w500),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 10,),
              const Divider(
                color: Color(0xFFC0C0C0),
              ),
              const SizedBox(height: 5,),
              Text(
                'Hoàn thành ${income.totalBookingCancel} chuyến đi',
                style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFF424242),
                    fontWeight: FontWeight.w500),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 10,),
            ],
          ),
        ),

        const SizedBox(height: 10,),

        Row(
          children: [

            Expanded(child: Card(
                surfaceTintColor: Colors.white,
                color: Colors.white,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                    bottomLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0),
                  ),
                ),
                elevation: 4.0,
                child: Padding(padding: EdgeInsets.only(top: 10, bottom: 10,left: 15,right: 15),
                  child: Column(
                    children: [
                      MyTextView(
                        label: "Tổng tiền chuyến đi",
                      ),
                      const SizedBox(height: 7,),
                      Text(
                        "${NumberUtils.formatMoneyToString(double.parse(income.totalBookingMoney.toStringAsFixed(0)))} đ",
                        style: const TextStyle(
                            fontSize: 18,
                            color: Color(0xFF424242),
                            fontWeight: FontWeight.w700),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),)
            ),),


            Expanded(child:Card(
                surfaceTintColor: Colors.white,
                color: Colors.white,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                    bottomLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0),
                  ),
                ),
                elevation: 4.0,
                child: Padding(padding: EdgeInsets.only(top: 10, bottom: 10,left: 15,right: 15),
                  child: Column(
                    children: [
                      MyTextView(
                        label: "Thu nhập",
                      ),
                      const SizedBox(height: 7,),
                      Text(
                        "${NumberUtils.formatMoneyToString(double.parse(income.totalMoney.toStringAsFixed(0)))} đ",
                        style: const TextStyle(
                            fontSize: 18,
                            color: Color(0xFF7EA567),
                            fontWeight: FontWeight.w700),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),)
            ),),

          ],
        ),

        const SizedBox(height: 10,),

        Row(
          children: [

            Expanded(child: Card(
                surfaceTintColor: Colors.white,
                color: Colors.white,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                    bottomLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0),
                  ),
                ),
                elevation: 4.0,
                child: Padding(padding: EdgeInsets.only(top: 10, bottom: 10,left: 15,right: 15),
                  child: Column(
                    children: [
                      MyTextView(
                        label: "Tiền phải trả",
                      ),
                      const SizedBox(height: 7,),
                      Text(
                        "${NumberUtils.formatMoneyToString(double.parse((income.totalBookingMoney - income.totalMoney).toStringAsFixed(0)))} đ",
                        style: const TextStyle(
                            fontSize: 18,
                            color: Color(0xFF424242),
                            fontWeight: FontWeight.w700),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),)
            ),),


            Expanded(child:Card(
                surfaceTintColor: Colors.white,
                color: Colors.white,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                    bottomLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0),
                  ),
                ),
                elevation: 4.0,
                child: Padding(padding: EdgeInsets.only(top: 10, bottom: 10,left: 15,right: 15),
                  child: Column(
                    children: [
                      MyTextView(
                        label: "Thuế",
                      ),
                      const SizedBox(height: 7,),
                      Text(
                        income.totalBookingCancel > 0?"${double.parse((((income.totalBookingMoney-income.totalMoney)/income.totalBookingMoney)*100).toStringAsFixed(2))} %":"0 %",
                        style: const TextStyle(
                            fontSize: 18,
                            color: Colors.red,
                            fontWeight: FontWeight.w700),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),)
            ),),

          ],
        )
      ],
    ));

  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}

