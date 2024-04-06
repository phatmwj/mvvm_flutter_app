import 'dart:ui';

import 'package:flutter/material.dart';

import 'base_colors.dart';

class AppColors implements BaseColors {

  final BuildContext context;

  static AppColors? _instance;

  AppColors(this.context);

  static AppColors of(BuildContext context){
    _instance ??= AppColors(context);
    return _instance!;
  }

  @override
  // TODO: implement appColor
  Color get appColorMain => const Color.fromRGBO(126, 165, 103, 1.0);

  @override
  // TODO: implement textColor
  Color get textColorMain => const Color.fromRGBO(66, 66, 66, 1);

  @override
  // TODO: implement greyColor
  Color get greyColor => const Color.fromRGBO(87, 87, 87, 0.77);

  @override
  // TODO: implement dividerColor
  Color get dividerColor => const Color.fromRGBO(66, 66, 66, 0.2);

  @override
  // TODO: implement cancelColor
  Color get cancelColor => Colors.red;



}
