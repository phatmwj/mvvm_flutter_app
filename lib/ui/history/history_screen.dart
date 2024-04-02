import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:mvvm_flutter_app/data/model/api/api_status.dart';
import 'package:mvvm_flutter_app/data/model/api/response/history_response.dart';
import 'package:mvvm_flutter_app/ui/history/history_viewmodel.dart';
import 'package:mvvm_flutter_app/ui/home/home_viewmodel.dart';
import 'package:mvvm_flutter_app/utils/utils.dart';
import 'package:mvvm_flutter_app/utils/number_utils.dart';
import 'package:provider/provider.dart';
class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final ScrollController scrollController = ScrollController();

  late HistoryViewModel vm;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    vm = Provider.of<HistoryViewModel>(context, listen: false);
    vm.getHistory();
    scrollController.addListener(loadMore);
    Utils.dismissLoading();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    scrollController.dispose();
    super.dispose();

  }


  @override
  Widget build(BuildContext context) {

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
                          'Lịch sử chuyến đi',
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

                ChangeNotifierProvider<HistoryViewModel>(
                  create: (BuildContext context) => vm,
                  child: Consumer<HistoryViewModel>(
                    builder: (context, value, _){
                      return _ui(vm);
                    },
                  )
                ),

               // _ui(historyViewModel),

              ],
            ),
          ],
        ),
      ),
    );

  }

  _ui(HistoryViewModel historyViewModel){
    return Expanded(
      child: RefreshIndicator(
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
      
                              Expanded(
                                child: Text(
                                  "${NumberUtils.formatMoneyToString(history.money!)} đ",
                                  style: const TextStyle(
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
                            height: 10,
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
                                      fontSize: 16,
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
                                      fontSize: 16,
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
                ),
      
                if(index == historyViewModel.histories.length - 1 && historyViewModel.isLoading)
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: CircularProgressIndicator(),
                  )
      
              ],
            );
          },
        ),
      ),
    );
  }

  void loadMore(){
    if(scrollController.position.pixels == scrollController.position.maxScrollExtent && vm.histories.length < vm.totalElements){
      vm.getHistory();
    }
  }

  Future<void> _refresh() async{
    vm.setPage(0);
    vm.refreshListHistory();
    vm.getHistory();
  }

}

