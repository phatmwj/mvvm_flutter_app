
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mvvm_flutter_app/res/app_context_extension.dart';
import 'package:provider/provider.dart';

import '../../data/local/prefs/prefereces_service_impl.dart';
import '../../data/model/api/api_status.dart';
import '../../data/model/api/response/message_chat.dart';
import '../../socket/command.dart';
import '../../socket/web_socket_viewmodel.dart';
import '../widget/app_header.dart';
import '../widget/my_oval_avartar.dart';
import '../widget/network_error.dart';
import 'chat_viewmodel.dart';

class ChatScreen extends StatefulWidget {
  int? roomId;
  static const String id = 'Chat_screen';
  ChatScreen(this.roomId,{super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  ScrollController _scrollController = ScrollController();

  late ChatViewModel vm;

  late WebSocketViewModel wsvm;

  final _prefs = PreferencesServiceImpl();

  final TextEditingController _controller = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    vm = Provider.of<ChatViewModel>(context, listen: false);
    wsvm = Provider.of<WebSocketViewModel>(context, listen: false);
    vm.getRoom(widget.roomId.toString());
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            AppHeader(title: "Nhắn tin cho khách hàng",),

            Expanded(
              child: Consumer<ChatViewModel>(
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
                      return RefreshIndicator(
                        onRefresh: _refresh,
                        child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height,
                            child: NetworkError(),
                          ),
                        ),
                      );
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
    );

  }

  _ui(ChatViewModel vm){
    return Column(
      children: [
        Expanded(child:Consumer<WebSocketViewModel>(builder: (context, value, _){

          if (wsvm.messageRes != null) {
            switch (wsvm.messageRes?.cmd) {
              case Command.CM_SEND_MESSAGE:
                vm.getRoom2(widget.roomId.toString());
                wsvm.messageRes = null;
                break;

              default:
                break;
            }
          }
          return ListView.builder(
              reverse: true,
              controller: _scrollController,
              scrollDirection: Axis.vertical,
              physics: const AlwaysScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: vm.res.data!.chatDetails!.length,
              itemBuilder: (context, index) {
                MessageChat msg = vm.res.data!.chatDetails!.reversed.toList()[index];
                if(index > 0){
                  MessageChat msg_late = vm.res.data!.chatDetails!.reversed.toList()[index-1];
                }
                return Column(
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(top: 0.0, bottom: 0.0, left: 16, right: 16),
                          child:  Card(
                            surfaceTintColor: Colors.white,
                            shadowColor: null,
                            elevation: 0.0,
                            child: Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Row(
                                mainAxisAlignment: msg.sender == vm.userId ? MainAxisAlignment.end :MainAxisAlignment.start,
                                children: [
                                  msg.sender == vm.userId ?
                                  Card(
                                      surfaceTintColor: Colors.white,
                                      color: Color(0xffD5E7B8),
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10.0),
                                            topRight: Radius.circular(10.0),
                                            bottomLeft: Radius.circular(10.0)
                                        ),
                                      ),
                                      elevation: 4.0,
                                      child: Padding(padding: const EdgeInsets.all(5.0),
                                        child:Text(
                                          msg.msg!,
                                        ),
                                      )

                                  ):
                                  Row(
                                    children: [
                                      MyOvalAvatar(
                                        avatar: msg.senderAvatar?? "",
                                        size: 30.0,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Card(
                                          surfaceTintColor: Colors.white,
                                          color: Color(0xffD5E7B8),
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10.0),
                                                topRight: Radius.circular(10.0),
                                                bottomRight: Radius.circular(10.0)
                                            ),
                                          ),
                                          elevation: 4.0,
                                          child: Padding(padding: const EdgeInsets.all(5.0),
                                            child:Text(
                                              msg.msg!,
                                            ),
                                          )

                                      )
                                    ],
                                  ),
                                ],
                              ),

                            ),
                          )
                      ),
                    ]
                );
              }
          );
        })

        ),

        const SizedBox(
          height: 15,
        ),

        Row(
          children: [
            const SizedBox(
              width: 20,
            ),
            Expanded(child:
            TextFormField(
              controller: _controller,
              onChanged: (value)=>
                  vm.setMsg(value),

              decoration: InputDecoration(
                counterText: '',
                hintText: 'Soạn tin nhắn',
                hintStyle: const TextStyle(
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Color(0xFF7EA567)),
                    borderRadius: BorderRadius.circular(20)
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 7, horizontal: 12),
              ),
              style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16
              ),
              maxLines: 1,
              // validator: (value) {
              //   return null;
              // },
            ),),
            const SizedBox(
              width: 10,
            ),

            IconButton(
              onPressed: () async {
                String msg = await vm.sendMessage(wsvm.bookingMsg.codeBooking!);
                wsvm.sendMessage(msg);
                vm.setMsg("");
                _controller.clear();
                _scrollToBottom();
              },
              icon:Icon(Icons.send,
                color: context.resources.color.appColorMain, size: 30,),
            ),
            const SizedBox(
              width: 20,
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }


  Future<void> _refresh() async{
    vm.getRoom(widget.roomId.toString());
  }

  void _scrollToBottom() {
    _scrollController.animateTo(
      0,
      duration: Duration(milliseconds: 10),
      curve: Curves.ease,
    );
  }

}

