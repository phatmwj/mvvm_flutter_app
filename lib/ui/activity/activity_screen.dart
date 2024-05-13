
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mvvm_flutter_app/data/model/api/response/activity_rate.dart';
import 'package:mvvm_flutter_app/ui/widget/my_textview.dart';
import 'package:mvvm_flutter_app/utils/utils.dart';
import 'package:provider/provider.dart';

import '../../data/model/api/api_status.dart';
import '../../utils/number_utils.dart';
import '../widget/app_header.dart';
import '../widget/my_error_widget.dart';
import 'activity_viewmodel.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen>{

  late ActivityViewModel vm;

  @override
  void initState() {
    // TODO: implement initState
    vm = Provider.of<ActivityViewModel>(context, listen: false);
    vm.statisticActivity(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Stack( // Wrap with Stack
          children: [
            Column(
              children: [
                AppHeader(title: "Chi tiết chuyến đi",),

                const SizedBox(height: 15),

                Consumer<ActivityViewModel>(builder: (context, viewModel, _) {
                  switch (vm.activityRes.status) {
                    case ApiStatus.LOADING:
                      Utils.showLoading();
                    case ApiStatus.ERROR:
                      return MyErrorWidget(vm.activityRes.message ?? "NA");
                    case ApiStatus.COMPLETED:
                      log("ActivityUI");
                      return _ActivityUI(vm.activityRes!.data!);
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

  Widget _ActivityUI(ActivityRate rate){
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
                      vm.setActivityTime(context, 0);
                    },
                    child: Text(
                      'Ngày',
                      style: TextStyle(
                          fontSize: 16,
                          color: vm.ActivityTime == 0 ? Color(0xFF7EA567) : Color(0xFF424242),
                          fontWeight: FontWeight.w500),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  TextButton(
                    onPressed: () {
                      vm.setActivityTime(context, 1);
                    },
                    child: Text(
                      'Tuần',
                      style: TextStyle(
                          fontSize: 16,
                          color: vm.ActivityTime == 1 ? Color(0xFF7EA567) : Color(0xFF424242),
                          fontWeight: FontWeight.w500),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  TextButton(
                    onPressed: () {
                      vm.setActivityTime(context, 2);
                    },
                    child: Text(
                      'Tháng',
                      style: TextStyle(
                          fontSize: 16,
                          color: vm.ActivityTime == 2 ? Color(0xFF7EA567) : Color(0xFF424242),
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

                    Expanded(child: Column(
                      children: [
                        MyTextView(
                          label: "Tỉ lệ nhận chuyến",
                        ),
                        Text(
                            rate.totalBookingAccept + rate.totalBookingCancel > 0?"${double.parse(((rate.totalBookingAccept/(rate.totalBookingAccept + rate.totalBookingCancel))*100).toStringAsFixed(0))} %":"0 %",
                            style: const TextStyle(
                                fontSize: 25,
                                color: Color(0xFF424242),
                                fontWeight: FontWeight.w700),
                            overflow: TextOverflow.ellipsis,
                        ),
                        const Divider(
                          color: Color(0xFFC0C0C0),
                        ),

                        MyTextView(
                          label: "Tỉ lệ hủy chuyến",
                        ),
                        Text(
                          rate.totalBookingAccept + rate.totalBookingCancel > 0?"${double.parse(((rate.totalBookingCancel/(rate.totalBookingAccept + rate.totalBookingCancel))*100).toStringAsFixed(0))} %":"0 %",
                            style: const TextStyle(
                                fontSize: 25,
                                color: Colors.red,
                                fontWeight: FontWeight.w700),
                            overflow: TextOverflow.ellipsis,
                          ),
                        const Divider(
                          color: Color(0xFFC0C0C0),
                        ),
                        MyTextView(
                          label: "Tỉ lệ hoàn thành chuyến",
                        ),
                        Text(
                          rate.totalBookingAccept + rate.totalBookingCancel > 0?"${double.parse(((rate.totalBookingSuccess/rate.totalBookingAccept)*100).toStringAsFixed(0))} %":"0 %",
                          style: const TextStyle(
                              fontSize: 25,
                              color: Color(0xFF7EA567),
                              fontWeight: FontWeight.w700),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    )),
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
                ],
              ),
            ),
          ],
        ));

  }

}

