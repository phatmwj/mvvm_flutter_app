

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_flutter_app/data/model/api/response/driver_service_response.dart';
import 'package:mvvm_flutter_app/ui/service/service_viewmodel.dart';
import 'package:mvvm_flutter_app/utils/Utils.dart';
import 'package:provider/provider.dart';

import '../../data/model/api/api_status.dart';
import '../widget/loading_widget.dart';
import '../widget/my_error_widget.dart';

class ServiceScreen extends StatefulWidget {
  static const String id = "service_screen";

  const ServiceScreen({super.key});

  @override
  _ServiceScreenState createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {

  late ServiceViewModel vm;

  @override
  void initState() {
    vm = Provider.of<ServiceViewModel>(context, listen: false);
    vm.getService(context);
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
                            'Cấu hình dịch vụ AllWin',
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

                  const SizedBox(height: 25),

                  Expanded(child: Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Consumer<ServiceViewModel>(builder: (context, viewModel, _) {
                      switch (vm.service.status) {
                        case ApiStatus.LOADING:
                          Utils.showLoading();
                        case ApiStatus.ERROR:
                          return MyErrorWidget(vm.service.message ?? "NA");
                        case ApiStatus.COMPLETED:
                          return _getServicesListView(vm.service.data?.content);
                        default:
                      }
                      Utils.dismissLoading();
                      return Container();
                    }),
                  ),

                      ),
                ],
              ),
            ],
          ),
      ),
    );
  }

  Widget _getServicesListView(List<DriverServiceResponse>? services) {
    return ListView.builder(
        itemCount: services?.length,
        itemBuilder: (context, position) {
            return _getServiceListItem(services![position]);
        }
    );
  }

  Widget _getServiceListItem(DriverServiceResponse item) {
    return Padding(padding: const EdgeInsets.only(left: 0, right: 0, bottom: 10, top: 0),
    child: Card(
      surfaceTintColor: Colors.white,
      color: Colors.white,
      elevation: 4.0,
      child:Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 10, top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // const SizedBox(width: 80),
            Text(
              item.service?.name ?? "N/A",
              style: const TextStyle(
                fontSize: 16,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 70),
            Expanded(child: Text(
              "${item.ratioShare!}%"?? "N/A",
              style: const TextStyle(
                fontSize: 16,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
              ),
            ),),

            SizedBox(
              height: 35.0,
              child: FittedBox(
                fit: BoxFit.fitHeight,
                child:  Switch(
                  value: item.state != 1? false : true,
                  activeColor: const Color(0xFF31C548),
                  onChanged: (bool value) {
                      if(value){
                        vm.changeServiceState(context, 1, item.id!);
                      }else{
                        vm.changeServiceState(context, 0, item.id!);
                      }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    ),);
  }
}
