import 'package:flutter/material.dart';
import 'package:mvvm_flutter_app/data/model/api/response/history_response.dart';
import 'package:mvvm_flutter_app/ui/history/history_view_model.dart';
import 'package:provider/provider.dart';
class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final ScrollController scrollController = ScrollController();
  List<HistoryResponse> products = [];
  HistoryViewModel viewModel = HistoryViewModel();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(loadMore);
    viewModel.getHistory();

  }
  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<HistoryViewModel>(context);

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
                SizedBox(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    physics: const AlwaysScrollableScrollPhysics(),
                    shrinkWrap: true,
                    controller: scrollController,
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
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
                                      '25/09/2023 15:00',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500
                                      ),
                                    ),

                                    SizedBox(
                                      width: 30,
                                    ),

                                    Expanded(
                                      child: Text(
                                        '27.000 đ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16
                                        ),
                                      ),
                                    ),

                                    Image(image: AssetImage('assets/images/icon_green_dot.png')),

                                    SizedBox(
                                      width: 10,
                                    ),

                                    Text(
                                      'Hoàn thành',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: Colors.green,
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
                                        '150/17 Đinh Tiên Hoàng, Phường26, Q.3, Hoss',
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
                                        'Masteri Thảo Điền, Phường 2, Q.2, Ho Chi Minh',
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
                      );
                    },
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );

  }

  void loadMore(){

  }
}
