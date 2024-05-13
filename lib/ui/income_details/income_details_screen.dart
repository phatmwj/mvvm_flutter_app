import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mvvm_flutter_app/data/model/api/api_status.dart';
import 'package:mvvm_flutter_app/data/model/api/response/history_response.dart';
import 'package:mvvm_flutter_app/res/app_context_extension.dart';
import 'package:mvvm_flutter_app/ui/history/history_viewmodel.dart';
import 'package:mvvm_flutter_app/ui/home/home_viewmodel.dart';
import 'package:mvvm_flutter_app/ui/widget/app_header.dart';
import 'package:mvvm_flutter_app/ui/widget/my_textview.dart';
import 'package:mvvm_flutter_app/ui/widget/network_error.dart';
import 'package:mvvm_flutter_app/utils/utils.dart';
import 'package:mvvm_flutter_app/utils/number_utils.dart';
import 'package:provider/provider.dart';

import 'income_details_viewmodel.dart';

class IncomeDetailsScreen extends StatefulWidget {
  static const String id = 'income_details_screen';
  String? startD;
  String? endD;
  IncomeDetailsScreen(this.startD,this.endD, {super.key});

  @override
  State<IncomeDetailsScreen> createState() => _IncomeDetailsScreenState();
}

class _IncomeDetailsScreenState extends State<IncomeDetailsScreen> {

  late ScrollController scrollController ;

  bool _showBackToTopButton = false;

  late IncomeDetailsViewModel vm;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    vm = Provider.of<IncomeDetailsViewModel>(context, listen: false);
    vm.getHistory(widget.endD,widget.startD);
    scrollController = ScrollController()
      ..addListener(loadMore)
      ..addListener(() {
        setState(() {
          if (scrollController.offset != 0) {
            _showBackToTopButton = true; // show the back-to-top button
          } else {
            _showBackToTopButton = false; // hide the back-to-top button
          }
        });
      });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    scrollController.dispose();
    vm.histories.clear();
    super.dispose();

  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AppHeader(title: "Chi tiết thu nhập",),

            Expanded(
              child: Consumer<IncomeDetailsViewModel>(
                builder: (context, value, _){
                  switch (value.res.status) {
                    case ApiStatus.LOADING:
                      return Center(
                        child: SpinKitThreeBounce(
                          color: context.resources.color.appColorMain,
                          size: 30.0,
                        ),
                      );
                    case ApiStatus.ERROR:
                      // return RefreshIndicator(
                      //   onRefresh: _refresh,
                      //   child: SingleChildScrollView(
                      //     physics: const AlwaysScrollableScrollPhysics(),
                      //     child: SizedBox(
                      //       height: MediaQuery.of(context).size.height,
                      //       child: NetworkError(),
                      //     ),
                      //   ),
                      // );
                    case ApiStatus.COMPLETED:
                      return _ui(value);
                    default:
                      return Container();
                  }
                },
              ),),

          ],
        ),
      ),
      floatingActionButton: _showBackToTopButton == false
          ? null
          : FloatingActionButton(
        mini: true,
        onPressed: _scrollToTop,
        backgroundColor: context.resources.color.appColorMain,
        child: const Icon(
          Icons.arrow_upward,
          color: Colors.white,
        ),
      ),
    );

  }

  void _scrollToTop() {
    scrollController.animateTo(0,
        duration: const Duration(seconds: 1), curve: Curves.linear);
  }

  _ui(IncomeDetailsViewModel historyViewModel){
    return RefreshIndicator(
      onRefresh: _refresh,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        physics: const AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
        controller: scrollController,
        itemCount: historyViewModel.histories.length,
        itemBuilder: (context, index) {
          HistoryResponse history = historyViewModel.histories[index];

          return Column(
            children: [
              Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 0.0, left: 16, right: 16),
                  child: InkWell(
                    onTap: (){
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => HistoryDetailScreen(history.id)));
                    },
                    child: Card(
                      surfaceTintColor: Colors.white,
                      shadowColor: null,
                      elevation: 4.0,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  NumberUtils.formatDate(history.createdDate!),
                                  style: const TextStyle(
                                      fontFamily: 'Roboto',
                                      color: Color.fromRGBO(0, 0, 0, 0.66),
                                      fontWeight: FontWeight.w500
                                  ),
                                ),

                                const SizedBox(
                                  width: 15,
                                ),

                                const Expanded(
                                  child: Text(
                                    " ",
                                    style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14,
                                        overflow: TextOverflow.ellipsis
                                    ),
                                  ),
                                ),

                                Image(image: AssetImage(history.state == 300 ? 'assets/images/icon_green_dot.png' : (history.state == -100 ? 'assets/images/icon_red_dot.png' : 'assets/images/icon_yellow_dot.png'))),

                                const SizedBox(
                                  width: 10,
                                ),

                                Text(
                                  history.state == 300 ? 'Hoàn thành' : (history.state == -100 ? 'Đã hủy' : 'Đang thực hiện'),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: history.state == 300 ? Colors.green : (history.state == -100 ? Colors.red : Colors.yellow),
                                  ),
                                )
                              ],
                            ),

                            const SizedBox(
                              height: 5,
                            ),

                            Row(
                              children: [
                                MyTextView(
                                  label: "Tiền chuyến đi: ",
                                  fontSize: 14,
                                ),
                                Text(
                                  "${NumberUtils.formatMoneyToString(history.money!)} đ",
                                  style: const TextStyle(
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                      overflow: TextOverflow.ellipsis
                                  ),
                                ),
                              ],
                            ),

                            Row(
                              children: [
                                MyTextView(
                                  label: "Thu nhập: ",
                                  fontSize: 14,
                                ),
                                Text(
                                  "${NumberUtils.formatMoneyToString(double.parse((history.money!*history.ratioShare!/100).toStringAsFixed(0)))} đ",
                                  style: const TextStyle(
                                      color: Color(0xFF7EA567),
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                      overflow: TextOverflow.ellipsis
                                  ),
                                ),
                              ],
                            ),

                            Row(
                              children: [
                                MyTextView(
                                  label: "Thuế: ",
                                  fontSize: 14,
                                ),
                                Text(
                                  "${100 - history.ratioShare!} %",
                                  style: const TextStyle(
                                      color: Colors.red,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                      overflow: TextOverflow.ellipsis
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),

                            Row(
                              children: [
                                const Image(
                                  image: AssetImage('assets/images/icon_vector.png'),
                                  height: 20,
                                  width: 20,
                                ),

                                const SizedBox(
                                  width: 15,
                                ),

                                Flexible(
                                  child: Text(
                                    history.pickupAddress ?? '',
                                    style: const TextStyle(
                                        fontFamily: 'Roboto',
                                        color: Color.fromRGBO(0, 0, 0, 0.52),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                        overflow: TextOverflow.ellipsis
                                    ),
                                  ),
                                ),
                              ],

                            ),

                            const SizedBox(
                              height: 10,
                            ),

                            Row(
                              children: [
                                const Image(
                                  image: AssetImage('assets/images/icon_destination.png'),
                                  height: 20,
                                  width: 20,
                                ),

                                const SizedBox(
                                  width: 15,
                                ),

                                Flexible(
                                  child: Text(
                                    history.destinationAddress ?? '',
                                    style: const TextStyle(
                                        fontFamily: 'Roboto',
                                        color: Color.fromRGBO(0, 0, 0, 0.52),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                        overflow: TextOverflow.ellipsis
                                    ),
                                  ),
                                ),
                              ],

                            ),

                            const SizedBox(
                              height: 10,
                            ),

                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                history.service!.name!,
                                style: const TextStyle(
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                    overflow: TextOverflow.ellipsis
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
              ),

              if(index == historyViewModel.histories.length - 1 && historyViewModel.histories.length < historyViewModel.totalElements)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SpinKitThreeBounce(
                    color: context.resources.color.appColorMain,
                    size: 30.0,
                  ),
                )

            ],
          );
        },
      ),
    );
  }

  void loadMore(){
    if(scrollController.position.pixels == scrollController.position.maxScrollExtent && vm.histories.length < vm.totalElements){
      vm.isLazyLoad = true;
      vm.getHistory(widget.endD,widget.startD);
    }
  }

  Future<void> _refresh() async{
    vm.setPage(0);
    vm.refreshListHistory();
    vm.getHistory(widget.endD,widget.startD);
  }

}

