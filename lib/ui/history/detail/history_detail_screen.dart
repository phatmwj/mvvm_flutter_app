import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mvvm_flutter_app/data/model/api/ApiStatus.dart';
import 'package:mvvm_flutter_app/data/model/api/ResponseWrapper.dart';
import 'package:mvvm_flutter_app/ui/history/detail/history_detail_view_model.dart';
import 'package:mvvm_flutter_app/utils/Utils.dart';
import 'package:mvvm_flutter_app/utils/number_utils.dart';
import 'package:provider/provider.dart';

import '../../../constant/Constant.dart';

class HistoryDetailScreen extends StatefulWidget {
  int? historyId;

  HistoryDetailScreen(this.historyId, {super.key});

  @override
  State<HistoryDetailScreen> createState() => _HistoryDetailScreenState();
}

class _HistoryDetailScreenState extends State<HistoryDetailScreen> {
  HistoryDetailViewModel viewModel = HistoryDetailViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.getHistoryDetail(widget.historyId??0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
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
                        'Chi tiết chuyến đi',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 20.0,
                          color: Color(0xff424242),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: ChangeNotifierProvider<HistoryDetailViewModel>(
                  create: (BuildContext context) => viewModel,
                  child: Consumer<HistoryDetailViewModel>(
                    builder: (context, value, _){
                      switch(value.res.status){
                        case ApiStatus.LOADING:
                          return const Center(child: SpinKitThreeBounce(color: Color(0xff7EA567), size: 30.0,));
                        case ApiStatus.ERROR:
                          return RefreshIndicator(
                            onRefresh: _refresh,
                            child: SingleChildScrollView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              child: SizedBox(
                                height: MediaQuery.of(context).size.height,
                                child: const Center(
                                  child: Text(
                                    'Lỗi kết nối, vui lòng thử lại!',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20.0,
                                        color: Colors.red
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        case ApiStatus.COMPLETED:
                          return Column(
                            children: [
                              Expanded(
                                child:
                                RefreshIndicator(
                                  onRefresh: _refresh,
                                  child:
                                  SingleChildScrollView(
                                    physics: AlwaysScrollableScrollPhysics(),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 10,
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Column(
                                            children: [
                                              ClipOval(
                                                child: viewModel.res.data?.customer?.avatar != null ?
                                                Image.network(Constant.MEDIA_URL+Constant.MEDIA_LOAD_URL +  viewModel.res.data!.customer!.avatar!
                                                  ,width: 80.0,
                                                  height: 80.0,
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                                                    return const Icon(Icons.error, size: 50.0,); // Replace with your desired error widget
                                                  },)
                                                    :
                                                const Image(
                                                    image: AssetImage('assets/images/user_avatar.png'),
                                                    width: 80.0,
                                                    height: 80.0),
                                              ),



                                              SizedBox(
                                                height: 16,
                                              ),

                                              Column(
                                                children: [
                                                  Text(
                                                    viewModel.res.data?.customer?.name ?? '',
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 20,
                                                      color: Color(0xff424242),
                                                    ),),

                                                  Text(
                                                    viewModel.res.data?.customer?.phone ?? '',
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 16,
                                                      color: Color(0xff424242),
                                                    ),),

                                                ],
                                              ),

                                              SizedBox(
                                                height: 16,
                                              ),

                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Thanh toán',
                                                      textAlign: TextAlign.start,
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 20,
                                                        color: Color(0xff424242),
                                                      ),),

                                                    SizedBox(
                                                      height: 5,
                                                    ),

                                                    Row(
                                                      children: [
                                                        Text(
                                                          'Cước phí',
                                                          textAlign: TextAlign.start,
                                                          style: TextStyle(
                                                              fontWeight: FontWeight.w500,
                                                              fontSize: 16,
                                                              color: Color(0xc9424242)
                                                          ),),

                                                        Expanded(
                                                          child: Text(
                                                            NumberUtils.formatMoneyToString(viewModel.res.data!.money!) + "đ",
                                                            textAlign: TextAlign.end,
                                                            style: TextStyle(
                                                                fontWeight: FontWeight.w500,
                                                                fontSize: 16,
                                                                color: Color(0xc9424242)
                                                            ),
                                                            maxLines: 1,
                                                            overflow: TextOverflow.ellipsis,
                                                          ),
                                                        )
                                                      ],
                                                    ),

                                                    SizedBox(
                                                      height: 10,
                                                    ),

                                                    Row(
                                                      children: [
                                                        Text(
                                                          'Khuyến mãi',
                                                          textAlign: TextAlign.start,
                                                          style: TextStyle(
                                                              fontWeight: FontWeight.w500,
                                                              fontSize: 16,
                                                              color: Color(0xc9424242)
                                                          ),),

                                                        Expanded(
                                                          child: Text(
                                                            viewModel.res.data?.promotionMoney != null ? NumberUtils.formatMoneyToString(viewModel.res.data!.promotionMoney!) + "đ" : "0 đ" ,
                                                            textAlign: TextAlign.end,
                                                            style: TextStyle(
                                                                fontWeight: FontWeight.w500,
                                                                fontSize: 16,
                                                                color: Color(0xc9424242)
                                                            ),
                                                            maxLines: 1,
                                                            overflow: TextOverflow.ellipsis,
                                                          ),
                                                        )
                                                      ],
                                                    ),

                                                    SizedBox(
                                                      height: 5,
                                                    ),

                                                    Divider(
                                                      color: Color(0xffEEF2F5),
                                                    ),

                                                    Row(
                                                      children: [
                                                        Text(
                                                          'Thành tiền',
                                                          textAlign: TextAlign.start,
                                                          style: TextStyle(
                                                            fontWeight: FontWeight.w700,
                                                            fontSize: 20,
                                                            color: Color(0xff424242),
                                                          ),
                                                          maxLines: 1,
                                                          overflow: TextOverflow.ellipsis,
                                                        ),

                                                        Expanded(
                                                          child: Text(
                                                            NumberUtils.formatMoneyToString(viewModel.res.data!.money!) + "đ",
                                                            textAlign: TextAlign.end,
                                                            style: TextStyle(
                                                              fontWeight: FontWeight.w700,
                                                              fontSize: 20,
                                                              color: Color(0xff424242),
                                                            ),
                                                            maxLines: 1,
                                                            overflow: TextOverflow.ellipsis,
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


                                        Divider(
                                          thickness: 8.0,
                                          color: Color(0xffEEF2F5),
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Chi tiết chuyến đi',
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 20,
                                                  color: Color(0xff424242),
                                                ),),

                                              Row(
                                                children: [
                                                  Text(
                                                    'Mã: ${viewModel.res.data!.code!}',
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 16
                                                    ),),

                                                  SizedBox(
                                                    width: 16.0,
                                                  ),

                                                  Text(
                                                    NumberUtils.formatDate(viewModel.res.data!.createdDate!),
                                                    textAlign: TextAlign.end,
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 16
                                                    ),),
                                                ],
                                              ),

                                              SizedBox(
                                                height: 16,
                                              ),

                                              Row(
                                                children: [
                                                  Image(
                                                    image: AssetImage('assets/images/icon_vector.png'),
                                                    height: 30,
                                                    width: 30,
                                                  ),

                                                  SizedBox(
                                                    width: 16,
                                                  ),

                                                  Flexible(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          'Điểm đón',
                                                          style: TextStyle(
                                                              fontWeight: FontWeight.w500,
                                                              fontSize: 16,
                                                              color: Colors.grey,
                                                              overflow: TextOverflow.ellipsis
                                                          ),
                                                        ),

                                                        Text(
                                                          viewModel.res.data!.pickupAddress!,
                                                          style: TextStyle(
                                                              fontWeight: FontWeight.w700,
                                                              fontSize: 16,
                                                              color: Color(0xff424242),
                                                              overflow: TextOverflow.ellipsis
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),

                                                ],

                                              ),

                                              SizedBox(
                                                height: 20,
                                              ),

                                              Row(
                                                children: [
                                                  Image(
                                                    image: AssetImage('assets/images/icon_destination.png'),
                                                    height: 30,
                                                    width: 30,
                                                  ),

                                                  // SvgPicture.asset(
                                                  //   'assets/icons/ic_icon_destination.svg',
                                                  //   semanticsLabel: 'My SVG Image',
                                                  //   height: 30,
                                                  //   width: 30,
                                                  // ),

                                                  SizedBox(
                                                    width: 16,
                                                  ),

                                                  Flexible(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Text(
                                                              'Điểm đến',
                                                              style: TextStyle(
                                                                  fontWeight: FontWeight.w500,
                                                                  fontSize: 16,
                                                                  color: Colors.grey,
                                                                  overflow: TextOverflow.ellipsis
                                                              ),
                                                            ),

                                                            SizedBox(
                                                              width: 10,
                                                            ),

                                                            Text(
                                                              '${NumberUtils.formatDistance(viewModel.res.data!.distance!)} km',
                                                              style: TextStyle(
                                                                  fontWeight: FontWeight.w500,
                                                                  fontSize: 16,
                                                                  color: Colors.grey,
                                                                  overflow: TextOverflow.ellipsis
                                                              ),
                                                            ),
                                                          ],
                                                        ),

                                                        Text(
                                                          viewModel.res.data!.destinationAddress!,
                                                          style: TextStyle(
                                                              fontWeight: FontWeight.w700,
                                                              fontSize: 16,
                                                              color: Color(0xff424242),
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
                                  ),
                                ),
                              ),
                
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Container(
                                    padding: EdgeInsets.all(16),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        color: viewModel.res.data!.state == 300 ? Color(0xffDCFFED) : (viewModel.res.data!.state == -100 ? Color(0xffFFDDDD) : Color(
                                            0xfffdf8db)),
                                        borderRadius: BorderRadius.all(Radius.circular(10))
                                    ),
                                    child: Text(
                                      textAlign: TextAlign.center,
                                      viewModel.res.data!.state == 300 ? 'Đã hoàn thành' : (viewModel.res.data!.state == -100 ? 'Đã hủy' : 'Đang thực hiện')
                                      ,
                                      style: TextStyle(
                                          color: viewModel.res.data!.state == 300 ? Color(0xff0FA958) : (viewModel.res.data!.state == -100 ? Color(0xffFF0000) : Color(0xffFDDA23)),
                                          fontWeight: FontWeight.w700, fontSize: 18),),
                                  ),
                                ),
                              )
                            ],
                          );
                        default:
                          return Container();
                      }
                    },
                  )
                ),
              ),
            ],
          )
      ));
  }

  Future<void> _refresh() async{
    viewModel.setRes(ResponseWrapper.loading());
    viewModel.getHistoryDetail(widget.historyId!);
  }
}
