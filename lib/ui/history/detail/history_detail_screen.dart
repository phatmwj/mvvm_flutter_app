
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mvvm_flutter_app/constant/Constant.dart';
import 'package:mvvm_flutter_app/res/app_context_extension.dart';
import 'package:mvvm_flutter_app/ui/widget/app_header.dart';
import 'package:mvvm_flutter_app/ui/widget/my_oval_avartar.dart';
import 'package:mvvm_flutter_app/ui/widget/my_textview.dart';
import 'package:mvvm_flutter_app/ui/widget/network_error.dart';
import 'package:provider/provider.dart';

import '../../../data/model/api/api_status.dart';
import '../../../res/colors/app_color.dart';
import '../../../utils/number_utils.dart';
import 'history_detail_viewmodel.dart';

class HistoryDetailScreen extends StatefulWidget {
  static const String id = 'history_detail_screen';
  int? historyId;

  HistoryDetailScreen(this.historyId, {super.key});

  @override
  State<HistoryDetailScreen> createState() => _HistoryDetailScreenState();
}

class _HistoryDetailScreenState extends State<HistoryDetailScreen> {
  late HistoryDetailViewModel vm;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    vm = Provider.of<HistoryDetailViewModel>(context, listen: false);
    vm.getBooking(widget.historyId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            AppHeader(title: "Chi tiết chuyến đi",),
            Expanded(
              child: RefreshIndicator(
                onRefresh: _refresh,
                child: Consumer<HistoryDetailViewModel>(
                  builder: (context, value, _) {
                    switch (value.res.status) {
                      case ApiStatus.LOADING:
                        return Center(
                          child: SpinKitThreeBounce(
                            color: context.resources.color.appColorMain,
                            size: 30.0,
                          ),
                        );
                      case ApiStatus.ERROR:
                        return RefreshIndicator(
                          onRefresh: _refresh,
                          child: SingleChildScrollView(
                            physics: AlwaysScrollableScrollPhysics(),
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height,
                              child: NetworkError(),
                            ),
                          ),
                        );
                      case ApiStatus.COMPLETED:
                        return _ui1(value);
                      default:
                        return Container();
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _refresh() async{
    vm.isRefresh = true;
    vm.getBooking(widget.historyId);
  }

  _ui1(HistoryDetailViewModel vm){
    return Column(
      children: [
        Expanded(child: SingleChildScrollView(
          child: Column(
            children: [
              if(vm.res.data?.state == 300)
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16,right: 16,bottom: 16,top: 5),
                      child: Card(
                          surfaceTintColor: Colors.white,
                          shadowColor: null,
                          elevation: 4.0,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: MyOvalAvatar(
                                    avatar: vm.res?.data?.customer?.avatar ?? '',
                                  ),
                                ),
                              ),

                              Expanded(
                                  child: Column(
                                    children: [
                                      MyTextView(
                                        label: vm.res.data?.customer?.name ?? '',
                                      ),

                                      Container(
                                        padding: const EdgeInsets.only(top: 5, bottom: 5, left: 10,right: 10),
                                        decoration: BoxDecoration(
                                            color: AppColor.backgroundColor,
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                        child: MyTextView(label: vm.res.data?.customer?.phone ?? '',),
                                      )
                                    ],
                                  )
                              ),

                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              if(vm.res.data?.rating != null)
                Column(
                  children: [
                    MyTextView(
                      label: 'Đánh giá từ khách hàng',
                    ),

                    RatingBar(
                        initialRating: vm.res.data?.rating?.star?.toDouble() ?? 0,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        ignoreGestures: true,
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
                        onRatingUpdate: (value) {

                        }),

                    const SizedBox(
                      height: 10,
                    ),

                    Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(horizontal: 50.0),
                      child: MyTextView(label: vm.res.data?.rating?.message ?? '',),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    const Divider(
                      thickness: 5.0,
                      color: AppColor.backgroundColor,
                    ),
                  ],
                ),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyTextView(label: "Thanh toán",),

                          const SizedBox(
                            height: 5,
                          ),

                          Row(
                            children: [
                              MyTextView(
                                label: "Cước phí",
                                fontSize: 14,
                              ),

                              Expanded(
                                child: MyTextView(
                                  label: '${NumberUtils.formatMoneyToString(vm.res.data!.money!)} đ',
                                  fontSize: 14,
                                  textAlign: TextAlign.end,
                                ),

                              )
                            ],
                          ),

                          const SizedBox(
                            height: 3,
                          ),

                          const Divider(
                            color: Color(0xffEEF2F5),
                          ),

                          Row(
                            children: [
                              MyTextView(
                                label: "Thành tiền",
                                    fontWeight: FontWeight.w600,
                                ),

                              Expanded(
                                child: MyTextView(
                                  label: '${NumberUtils.formatMoneyToString(vm.res.data!.money!)} đ',
                                  textAlign: TextAlign.end,
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),


                  ],
                ),
              ),

              const Divider(
                thickness: 5.0,
                color: Color(0xffEEF2F5),
              ),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Chi tiết chuyến đi',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Color(0xFF424242),
                      ),),

                    Row(
                      children: [
                        Text(
                          'Mã: ${vm.res.data?.code}',
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Color(0xFF424242)
                          ),),

                        const SizedBox(
                          width: 16.0,
                        ),

                        Text(
                          '${NumberUtils.formatDate(vm.res.data!.createdDate!)}',
                          textAlign: TextAlign.end,
                          style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Color(0xFF424242)
                          ),),
                      ],
                    ),

                    const SizedBox(
                      height: 16,
                    ),

                    Row(
                      children: [
                        const Image(
                          image: AssetImage('assets/images/icon_vector.png'),
                          height: 30,
                          width: 30,
                        ),

                        const SizedBox(
                          width: 16,
                        ),

                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Điểm đón',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    color: Colors.grey,
                                    overflow: TextOverflow.ellipsis
                                ),
                              ),

                              Text(
                                vm.res.data?.pickupAddress ?? '',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: Color(0xFF424242),
                                    overflow: TextOverflow.ellipsis
                                ),
                              ),
                            ],
                          ),
                        ),

                      ],

                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    Row(
                      children: [
                        const Image(
                          image: AssetImage('assets/images/icon_destination.png'),
                          height: 30,
                          width: 30,
                        ),


                        const SizedBox(
                          width: 16,
                        ),

                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    'Điểm đến',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                        color: Colors.grey,
                                        overflow: TextOverflow.ellipsis
                                    ),
                                  ),

                                  const SizedBox(
                                    width: 10,
                                  ),

                                  Text(
                                    '${NumberUtils.formatDistance(vm.res.data!.distance!)} km',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                        color: Colors.grey,
                                        overflow: TextOverflow.ellipsis
                                    ),
                                  ),
                                ],
                              ),

                              Text(
                                vm.res.data?.destinationAddress ?? '',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: Color(0xFF424242),
                                    overflow: TextOverflow.ellipsis
                                ),
                              ),
                            ],
                          ),
                        ),

                      ],

                    ),

                  ],

                ),
              ),
            ],
          ),
        ),),

        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              padding: EdgeInsets.all(10),
              width: double.infinity,
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: vm.res.data!.state == 300 ? Color(0xffDCFFED) : (vm.res.data!.state == -100 ? Color(0xffFFDDDD) : Color(
                      0xfffdf8db)),
                  borderRadius: const BorderRadius.all(Radius.circular(10))
              ),
              child: Text(
                textAlign: TextAlign.center,
                vm.res.data!.state == 300 ? 'Đã hoàn thành' : (vm.res.data!.state == -100 ? 'Đã hủy' : 'Đang thực hiện')
                ,
                style: TextStyle(
                    color: vm.res.data!.state == 300 ? Color(0xff0FA958) : (vm.res.data!.state == -100 ? Color(0xffFF0000) : Color(0xffFDDA23)),
                    fontWeight: FontWeight.w700, fontSize: 18),),
            ),
          ),
        )
      ],
    );
  }

}
