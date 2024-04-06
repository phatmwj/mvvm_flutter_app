import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_flutter_app/res/app_context_extension.dart';

import '../../constant/Constant.dart';

class MyOvalAvatar extends StatelessWidget {

  String avatar;
  double size;


  MyOvalAvatar({this.avatar = '', this.size = 50.0});

  @override
  Widget build(BuildContext context) {
    return  Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
        shape: BoxShape.circle,
              border: Border.all(
              color: context.resources.color.appColorMain,
              width: 1.0,
              ),
          ),
          child:
          ClipOval(
            child: avatar == null || avatar == '' ?
            Image(
              image: const AssetImage('assets/images/user_avatar.png'),
              width: size,
              height: size,
            )
            :CachedNetworkImage(
              // width: size,
              // height: size,
              imageUrl: Constant.MEDIA_URL+Constant.MEDIA_LOAD_URL+avatar,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error, size: size,),
            ),

          //   avatar!= null && avatar!=''
          //     ? Image.network(Constant.MEDIA_URL+Constant.MEDIA_LOAD_URL+avatar
          //   ,width: size,
          //   height: size,
          //   fit: BoxFit.cover,
          //   errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
          //     return const Icon(Icons.error, size: 50.0,); // Replace with your desired error widget
          //   },)
          //     : Image(
          //   image: const AssetImage('assets/images/user_avatar.png'),
          //   width: size,
          //   height: size,
          // ),
        ),
    );
  }
}
