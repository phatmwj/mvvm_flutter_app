import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:mvvm_flutter_app/data/model/api/ApiStatus.dart';
import 'package:mvvm_flutter_app/data/model/api/response/history_response.dart';
import 'package:mvvm_flutter_app/ui/history/history_view_model.dart';
import 'package:mvvm_flutter_app/ui/home/home_viewmodel.dart';
import 'package:mvvm_flutter_app/utils/number_utils.dart';
import 'package:provider/provider.dart';
class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final ScrollController scrollController = ScrollController();

  HistoryViewModel viewModel = HistoryViewModel();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.getHistory();
    scrollController.addListener(loadMore);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    viewModel.dispose();
    scrollController.dispose();

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
                  margin: EdgeInsets.only(top: 20.0),
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
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
                      SizedBox(width: 10),
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          'Lịch sử chuyến đi',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 20.0
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15),

                ChangeNotifierProvider<HistoryViewModel>(
                  create: (BuildContext context) => viewModel,
                  child: Consumer<HistoryViewModel>(
                    builder: (context, value, _){
                      return _ui(viewModel);
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
                padding: const EdgeInsets.only(top: 10, bottom: 10, left: 16, right: 16),
                child: Card(
                  surfaceTintColor: Colors.white,
                  shadowColor: Colors.lightGreenAccent,
                  elevation: 4.0,
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              NumberUtils.formatDate(history.createdDate!),
                              style: TextStyle(
                                  fontWeight: FontWeight.w500
                              ),
                            ),

                            SizedBox(
                              width: 30,
                            ),

                            Expanded(
                              child: Text(
                                NumberUtils.formatMoneyToString(history.money!) + " đ",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14
                                ),
                              ),
                            ),

                            Image(image: AssetImage(history.state == 300 ? 'assets/images/icon_green_dot.png' : (history.state == -100 ? 'assets/images/icon_red_dot.png' : 'assets/images/icon_yellow_dot.png'))),

                            SizedBox(
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

                        SizedBox(
                          height: 10,
                        ),

                        Row(
                          children: [
                            Image(
                              image: AssetImage('assets/images/icon_vector.png'),
                              height: 20,
                              width: 20,
                            ),

                            SizedBox(
                              width: 15,
                            ),

                            Flexible(
                              child: Text(
                                history.pickupAddress ?? '',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                    color: Colors.grey,
                                    overflow: TextOverflow.ellipsis
                                ),
                              ),
                            ),
                          ],

                        ),

                        SizedBox(
                          height: 10,
                        ),

                        Row(
                          children: [
                            Image(
                              image: AssetImage('assets/images/icon_destination.png'),
                              height: 20,
                              width: 20,
                            ),

                            SizedBox(
                              width: 15,
                            ),

                            Flexible(
                              child: Text(
                                history.destinationAddress ?? '',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                    color: Colors.grey,
                                    overflow: TextOverflow.ellipsis
                                ),
                              ),
                            ),
                          ],

                        ),

                        SizedBox(
                          height: 10,
                        ),

                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'AllBike',
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 16
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
    );
  }

  void loadMore(){
    if(scrollController.position.pixels == scrollController.position.maxScrollExtent && viewModel.histories.length < viewModel.totalElements){
      viewModel.getHistory();
    }
  }
}
